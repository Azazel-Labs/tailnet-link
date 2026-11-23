//! A Tailscale node running inside this process, via libtailscale (tsbridge/).
//!
//! We use libtailscale's portable parts only:
//! - start / close / status,
//! - `tailscale_loopback`: a SOCKS5 proxy onto the tailnet (for connections)
//!   and Tailscale's LocalAPI over HTTP (login, logout, prefs), both on
//!   127.0.0.1 and protected by random credentials.

use base64::Engine as _;
use serde::Deserialize;
use std::ffi::{CStr, CString, c_char, c_int};
use std::path::Path;
use std::time::Duration;

unsafe extern "C" {
    fn TsnetNewServer() -> c_int;
    fn TsnetStart(sd: c_int) -> c_int;
    fn TsnetClose(sd: c_int) -> c_int;
    fn TsnetErrmsg(sd: c_int, buf: *mut c_char, buflen: usize) -> c_int;
    fn TsnetSetDir(sd: c_int, s: *mut c_char) -> c_int;
    fn TsnetSetHostname(sd: c_int, s: *mut c_char) -> c_int;
    fn TsnetSetLogFD(sd: c_int, fd: c_int) -> c_int;
    fn TsnetLoopback(
        sd: c_int,
        addr_out: *mut c_char,
        addr_len: usize,
        proxy_out: *mut c_char,
        local_out: *mut c_char,
    ) -> c_int;
    fn TsnetStatusJSON(sd: c_int, json_out: *mut *mut c_char) -> c_int;
}

/// The parts of Tailscale's status (ipnstate.Status) we use.
#[derive(Debug, Default, Clone, Deserialize)]
pub struct Status {
    #[serde(rename = "BackendState", default)]
    pub backend_state: String,
    #[serde(rename = "AuthURL", default)]
    pub auth_url: String,
    #[serde(rename = "Self", default)]
    pub self_node: Option<PeerStatus>,
    #[serde(rename = "CurrentTailnet", default)]
    pub current_tailnet: Option<TailnetInfo>,
    /// The other machines in the tailnet (null when there are none).
    #[serde(rename = "Peer", default)]
    pub peers: Option<std::collections::HashMap<String, PeerStatus>>,
}

#[derive(Debug, Default, Clone, Deserialize)]
pub struct PeerStatus {
    #[serde(rename = "DNSName", default)]
    pub dns_name: String,
    #[serde(rename = "OS", default)]
    pub os: String,
    #[serde(rename = "Online", default)]
    pub online: bool,
    #[serde(rename = "TailscaleIPs", default)]
    pub ips: Option<Vec<String>>,
    /// The subnets this machine routes for the tailnet (approved, and it's the
    /// primary router for them), e.g. 192.168.0.0/16. An exit node lists 0.0.0.0/0.
    #[serde(rename = "PrimaryRoutes", default)]
    pub primary_routes: Option<Vec<String>>,
    /// Its tags from the tailnet's policy, e.g. tag:server.
    #[serde(rename = "Tags", default)]
    pub tags: Option<Vec<String>>,
}

#[derive(Debug, Default, Clone, Deserialize)]
pub struct TailnetInfo {
    #[serde(rename = "Name", default)]
    pub name: String,
    #[serde(rename = "MagicDNSSuffix", default)]
    pub magic_dns_suffix: String,
}

/// Where and how to reach a node's SOCKS5 proxy.
#[derive(Clone, Debug)]
pub struct SocksTarget {
    pub addr: String,
    pub user: String,
    pub pass: String,
}

pub struct Node {
    sd: c_int,
    loopback: String,
    proxy_cred: String,
    api_cred: String,
    http: ureq::Agent,
}

fn cstring(s: &str) -> Result<CString, String> {
    CString::new(s).map_err(|_| "string contains a NUL byte".to_owned())
}

/// Copies a NUL-terminated string out of a buffer libtailscale filled in.
fn read_buf(b: &[c_char]) -> String {
    // A buffer that's all bytes and no NUL would make CStr read past the end.
    if !b.contains(&0) {
        return String::new();
    }
    // SAFETY: `b` contains a NUL (checked above), so the string ends inside it.
    unsafe { CStr::from_ptr(b.as_ptr()) }.to_string_lossy().into_owned()
}

/// Closes a node handle, ignoring errors (it's being thrown away).
fn close(sd: c_int) {
    // SAFETY: plain integer handle; libtailscale ignores unknown ones.
    unsafe { TsnetClose(sd) };
}

impl Node {
    /// Creates and starts a node keeping its state (login) in `dir`.
    pub fn start(dir: &Path, hostname: &str) -> Result<Node, String> {
        std::fs::create_dir_all(dir).map_err(|e| format!("creating {}: {e}", dir.display()))?;
        // SAFETY: no arguments; returns a handle or a negative error.
        let sd = unsafe { TsnetNewServer() };
        if sd < 0 {
            return Err("libtailscale: couldn't create a node".into());
        }
        let dir_c = cstring(&dir.to_string_lossy())?;
        let host_c = cstring(hostname)?;
        // The strings are valid NUL-terminated C strings that outlive the calls;
        // libtailscale copies them and never writes through the pointers.
        // SAFETY: see above.
        let mut rc = unsafe { TsnetSetDir(sd, dir_c.as_ptr().cast_mut()) };
        if rc == 0 {
            // SAFETY: see above.
            rc = unsafe { TsnetSetHostname(sd, host_c.as_ptr().cast_mut()) };
        }
        if rc == 0 {
            // SAFETY: integer arguments only (-1: discard Tailscale's own logs).
            rc = unsafe { TsnetSetLogFD(sd, -1) };
        }
        if rc != 0 {
            let e = Self::errmsg(sd);
            close(sd);
            return Err(e);
        }
        // SAFETY: integer handle from TsnetNewServer.
        if unsafe { TsnetStart(sd) } != 0 {
            let e = Self::errmsg(sd);
            close(sd);
            return Err(format!("starting Tailscale: {e}"));
        }

        // libtailscale writes the address (up to addr_len) and two 32-character
        // credentials plus a NUL into these.
        let mut addr: [c_char; 128] = [0; 128];
        let mut proxy: [c_char; 33] = [0; 33];
        let mut local: [c_char; 33] = [0; 33];
        // SAFETY: the buffers are as large as libtailscale expects (see above).
        let rc = unsafe { TsnetLoopback(sd, addr.as_mut_ptr(), addr.len(), proxy.as_mut_ptr(), local.as_mut_ptr()) };
        if rc != 0 {
            let e = Self::errmsg(sd);
            close(sd);
            return Err(format!("starting the node's local proxy: {e}"));
        }

        // Talk to our own 127.0.0.1 LocalAPI directly: never through a system/corporate proxy.
        let http: ureq::Agent = ureq::Agent::config_builder()
            .proxy(None)
            .timeout_global(Some(Duration::from_secs(15)))
            .http_status_as_error(false)
            .build()
            .into();

        Ok(Node { sd, loopback: read_buf(&addr), proxy_cred: read_buf(&proxy), api_cred: read_buf(&local), http })
    }

    fn errmsg(sd: c_int) -> String {
        let mut buf: [c_char; 512] = [0; 512];
        // SAFETY: libtailscale writes at most `buf.len()` bytes, NUL included.
        unsafe { TsnetErrmsg(sd, buf.as_mut_ptr(), buf.len()) };
        read_buf(&buf)
    }

    pub fn status(&self) -> Result<Status, String> {
        let mut out: *mut c_char = std::ptr::null_mut();
        // SAFETY: `out` is a valid place for libtailscale to store a pointer.
        let rc = unsafe { TsnetStatusJSON(self.sd, &raw mut out) };
        if rc != 0 || out.is_null() {
            return Err(Self::errmsg(self.sd));
        }
        // SAFETY: on success `out` is a NUL-terminated string from C.CString.
        let json = unsafe { CStr::from_ptr(out) }.to_string_lossy().into_owned();
        // SAFETY: C.CString allocates with malloc, and we own the result.
        unsafe { libc::free(out.cast::<libc::c_void>()) };
        serde_json::from_str(&json).map_err(|e| format!("reading Tailscale status: {e}"))
    }

    pub fn socks(&self) -> SocksTarget {
        SocksTarget { addr: self.loopback.clone(), user: "tsnet".into(), pass: self.proxy_cred.clone() }
    }

    fn local_api(&self, method: &str, path: &str, body: Option<&str>) -> Result<String, String> {
        let url = format!("http://{}/localapi/v0/{}", self.loopback, path);
        let auth =
            format!("Basic {}", base64::engine::general_purpose::STANDARD.encode(format!("tsnet:{}", self.api_cred)));
        let result = match method {
            "POST" => {
                let req = self.http.post(&url).header("Sec-Tailscale", "localapi").header("Authorization", &auth);
                match body {
                    Some(b) => req.header("Content-Type", "application/json").send(b),
                    None => req.send_empty(),
                }
            }
            "PATCH" => self
                .http
                .patch(&url)
                .header("Sec-Tailscale", "localapi")
                .header("Authorization", &auth)
                .header("Content-Type", "application/json")
                .send(body.unwrap_or("{}")),
            _ => self.http.get(&url).header("Sec-Tailscale", "localapi").header("Authorization", &auth).call(),
        };
        let mut resp = result.map_err(|e| format!("LocalAPI {path}: {e}"))?;
        let status = resp.status();
        let text = resp.body_mut().read_to_string().unwrap_or_default();
        if !status.is_success() {
            return Err(format!("LocalAPI {path}: {status}: {}", text.trim()));
        }
        Ok(text)
    }

    /// Starts Tailscale's interactive login; the sign-in URL then appears in `status().auth_url`.
    pub fn login_interactive(&self) -> Result<(), String> {
        self.local_api("POST", "login-interactive", None).map(|_| ())
    }

    pub fn logout(&self) -> Result<(), String> {
        self.local_api("POST", "logout", None).map(|_| ())
    }

    /// Blocks every incoming connection from that tailnet to this computer, and
    /// accepts the subnets its routers share, so their addresses can be reached
    /// (Tailscale already does on Windows; Linux and macOS need asking).
    pub fn set_prefs(&self) -> Result<(), String> {
        self.local_api(
            "PATCH",
            "prefs",
            Some(r#"{"ShieldsUp":true,"ShieldsUpSet":true,"RouteAll":true,"RouteAllSet":true}"#),
        )
        .map(|_| ())
    }
}

impl Drop for Node {
    fn drop(&mut self) {
        close(self.sd);
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    /// Starts a real libtailscale node (no login needed) and checks every
    /// piece we rely on: status, LocalAPI auth, and the SOCKS5 proxy.
    /// Needs network access to Tailscale only for login, which isn't tested here.
    #[test]
    fn real_node_bridge() {
        let dir = std::env::temp_dir().join(format!("tp-node-{}", rand::random::<u64>()));
        let node = Node::start(&dir, "tailnet-link-test").expect("node starts");
        assert!(node.loopback.starts_with("127.0.0.1:"), "loopback {}", node.loopback);
        assert_eq!(node.proxy_cred.len(), 32);
        assert_eq!(node.api_cred.len(), 32);

        // Status via the C API.
        let st = node.status().expect("status");
        assert!(
            ["NoState", "NeedsLogin", "Starting", "Stopped"].contains(&st.backend_state.as_str()),
            "backend state {}",
            st.backend_state
        );

        // LocalAPI: our credentials are accepted (a wrong one is refused).
        node.set_prefs().expect("LocalAPI prefs with our credentials");
        let bad = Node {
            sd: -1,
            loopback: node.loopback.clone(),
            proxy_cred: String::new(),
            api_cred: "wrong".into(),
            http: node.http.clone(),
        };
        assert!(bad.local_api("GET", "status", None).is_err(), "wrong LocalAPI credential must be refused");
        std::mem::forget(bad); // sd -1: nothing to close

        // SOCKS5: handshake + auth work; the target just isn't reachable (not logged in).
        let rt = tokio::runtime::Runtime::new().unwrap();
        let r = rt.block_on(crate::socks::connect(&node.socks(), "nothing.example.ts.net", 443));
        let e = r.expect_err("not logged in, so no route");
        assert!(!e.to_string().contains("authentication failed"), "SOCKS auth must succeed: {e}");

        drop(node);
        let _ = std::fs::remove_dir_all(dir);
    }
}
