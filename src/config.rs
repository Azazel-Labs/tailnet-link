//! Settings: which tailnets to join, port forwards, and how to behave.
//! Saved as JSON in the per-user config folder.

use crate::i18n::tr;
use serde::{Deserialize, Serialize};
use std::path::{Path, PathBuf};

/// A local port sent to a machine in one of the tailnets, for apps that don't
/// use proxies (Remote Desktop, databases). The target's name picks the tailnet.
#[derive(Clone, Debug, PartialEq, Eq, Serialize, Deserialize)]
pub struct Forward {
    /// 0 = pick a free port (then saved, so it stays the same).
    pub local_port: u16,
    /// host:port, e.g. build-pc.example.ts.net:3389
    pub target: String,
}

impl std::fmt::Display for Forward {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        if self.local_port == 0 {
            write!(f, "auto = {}", self.target)
        } else {
            write!(f, "{} = {}", self.local_port, self.target)
        }
    }
}

/// One extra tailnet this app joins.
#[derive(Clone, Debug, PartialEq, Eq, Serialize, Deserialize, Default)]
#[serde(default)]
pub struct TailnetConfig {
    /// Folder name for its login.
    pub id: String,
    /// Label; defaults to the tailnet's own name.
    pub name: String,
    pub enabled: bool,
    /// Detected after login: the tailnet's MagicDNS name, e.g. example.ts.net.
    pub domain: String,
    /// Any other names it serves.
    #[serde(deserialize_with = "null_as_empty")]
    pub extra_domains: Vec<String>,
}

impl TailnetConfig {
    /// Everything routed through this tailnet.
    pub fn domains(&self) -> Vec<String> {
        let mut out = Vec::new();
        if !self.domain.is_empty() {
            out.push(self.domain.clone());
        }
        for d in &self.extra_domains {
            if d != &self.domain {
                out.push(d.clone());
            }
        }
        out
    }
}

#[derive(Clone, Debug, PartialEq, Eq, Serialize, Deserialize)]
#[serde(default)]
pub struct Config {
    #[serde(deserialize_with = "null_as_empty")]
    pub tailnets: Vec<TailnetConfig>,
    #[serde(deserialize_with = "null_as_empty")]
    pub forwards: Vec<Forward>,
    /// Master on/off switch.
    pub enabled: bool,
    /// System proxy setting: "on", "off", or "force" (replace an existing
    /// company setup script while running).
    pub system_proxy: String,
    /// This computer's name in the other tailnets (takes effect on next start).
    pub hostname: String,
    /// Local proxy address; must stay on localhost. If the port is taken by
    /// another program, a free one is picked and saved here.
    pub listen: String,
    /// Whether closing the window has shown the "still running" notification.
    /// It only shows the first time.
    pub background_hint_shown: bool,
    /// UI language: a catalog code like "fr", or "auto" to follow the OS.
    pub language: String,
    /// Ask GitHub once in a while whether there's a newer release.
    pub check_updates: bool,
    /// The newest version a notification has been shown for, so each is announced once.
    pub update_notified: String,
    /// Look for websites on the machines in the routing tailnets (each asked at most once a day).
    pub find_sites: bool,
}

/// Reads `null` as an empty list. Older versions wrote `null` for empty lists,
/// and refusing those files would throw away every saved tailnet.
fn null_as_empty<'de, D, T>(d: D) -> Result<Vec<T>, D::Error>
where
    D: serde::Deserializer<'de>,
    T: Deserialize<'de>,
{
    Ok(Option::<Vec<T>>::deserialize(d)?.unwrap_or_default())
}

impl Default for Config {
    fn default() -> Self {
        Config {
            tailnets: Vec::new(),
            forwards: Vec::new(),
            enabled: true,
            system_proxy: "on".into(),
            hostname: default_hostname(),
            listen: "127.0.0.1:1055".into(),
            background_hint_shown: false,
            language: "auto".into(),
            check_updates: true,
            update_notified: String::new(),
            find_sites: true,
        }
    }
}

pub fn default_hostname() -> String {
    let h = hostname_of_machine().unwrap_or_else(|| "laptop".into());
    format!("{}-proxy", sanitize(&h).to_lowercase())
}

fn hostname_of_machine() -> Option<String> {
    for var in ["COMPUTERNAME", "HOSTNAME"] {
        if let Ok(v) = std::env::var(var)
            && !v.trim().is_empty()
        {
            return Some(v.trim().to_owned());
        }
    }
    std::fs::read_to_string("/etc/hostname").ok().map(|s| s.trim().to_owned()).filter(|s| !s.is_empty()).or_else(|| {
        std::process::Command::new("hostname")
            .output()
            .ok()
            .map(|o| String::from_utf8_lossy(&o.stdout).trim().to_owned())
            .filter(|s| !s.is_empty())
    })
}

pub fn sanitize(s: &str) -> String {
    s.chars().map(|c| if c.is_ascii_alphanumeric() || c == '-' || c == '.' { c } else { '-' }).collect()
}

/// The folder's name inside the platform's config folder.
const DIR_NAME: &str = if cfg!(any(windows, target_os = "macos")) { "Tailnet Link" } else { "tailnet-link" };
/// Its name before the app was renamed from tailnet-proxy.
const LEGACY_DIR_NAME: &str = "tailnet-proxy";

/// %AppData%\Tailnet Link, ~/Library/Application Support/Tailnet Link, ~/.config/tailnet-link
pub fn config_dir() -> PathBuf {
    if let Ok(d) = std::env::var("TAILNET_LINK_CONFIG_DIR") {
        return PathBuf::from(d); // tests
    }
    dirs::config_dir().unwrap_or_else(|| PathBuf::from(".")).join(DIR_NAME)
}

/// Moves the settings and logins from the folder the app used when it was called
/// tailnet-proxy, if there are no settings in the new place yet. Returns the old
/// folder if it was moved.
///
/// If tailnet-proxy is still running its files are in use; it retries for a few
/// seconds (an installer may be stopping it) and then fails, and the caller must
/// not save new settings: that would make the move impossible, and signing in
/// again would leave the old login behind as a second machine in each tailnet.
pub fn migrate_legacy_dir() -> std::io::Result<Option<PathBuf>> {
    if std::env::var_os("TAILNET_LINK_CONFIG_DIR").is_some() {
        return Ok(None);
    }
    let Some(base) = dirs::config_dir() else { return Ok(None) };
    migrate_dir(&base.join(LEGACY_DIR_NAME), &config_dir())
}

fn migrate_dir(old: &Path, new: &Path) -> std::io::Result<Option<PathBuf>> {
    if !old.is_dir() || new.join("config.json").exists() {
        return Ok(None);
    }
    let mut tries = 0;
    loop {
        match move_dir(old, new) {
            Ok(()) => return Ok(Some(old.to_owned())),
            Err(_) if tries < 5 => {
                tries += 1;
                std::thread::sleep(std::time::Duration::from_secs(1));
            }
            Err(e) => return Err(e),
        }
    }
}

/// Renames `old` to `new`. If `new` exists without settings (an earlier
/// attempt's log, say), moves what's inside instead, keeping what's there.
fn move_dir(old: &Path, new: &Path) -> std::io::Result<()> {
    if !new.exists() {
        return std::fs::rename(old, new);
    }
    for entry in std::fs::read_dir(old)? {
        let entry = entry?;
        let to = new.join(entry.file_name());
        if !to.exists() {
            std::fs::rename(entry.path(), to)?;
        }
    }
    let _ = std::fs::remove_dir(old); // only if now empty
    Ok(())
}

pub fn config_path() -> PathBuf {
    config_dir().join("config.json")
}

pub fn log_path() -> PathBuf {
    config_dir().join("tailnet-link.log")
}

pub fn node_dir(id: &str) -> PathBuf {
    config_dir().join("nodes").join(id)
}

impl Config {
    pub fn load() -> Result<Config, String> {
        let path = config_path();
        let text = match std::fs::read_to_string(&path) {
            Ok(t) => t,
            Err(e) if e.kind() == std::io::ErrorKind::NotFound => return Ok(Config::default()),
            Err(e) => return Err(format!("reading {}: {e}", path.display())),
        };
        let mut c: Config = serde_json::from_str(&text).map_err(|e| format!("reading {}: {e}", path.display()))?;
        let d = Config::default();
        if c.listen.is_empty() {
            c.listen = d.listen;
        }
        if c.hostname.is_empty() {
            c.hostname = d.hostname;
        }
        if c.system_proxy.is_empty() {
            c.system_proxy = d.system_proxy;
        }
        c.validate()?;
        Ok(c)
    }

    pub fn save(&self) -> Result<(), String> {
        let dir = config_dir();
        std::fs::create_dir_all(&dir).map_err(|e| e.to_string())?;
        let text = serde_json::to_string_pretty(self).map_err(|e| e.to_string())?;
        let tmp = config_path().with_extension("json.tmp");
        std::fs::write(&tmp, text).map_err(|e| e.to_string())?;
        std::fs::rename(&tmp, config_path()).map_err(|e| e.to_string())
    }

    pub fn validate(&self) -> Result<(), String> {
        let host = self.listen.rsplit_once(':').map_or("", |(h, _)| h);
        if !matches!(host, "127.0.0.1" | "localhost" | "[::1]") {
            return Err(format!("listen must be a localhost address like 127.0.0.1:1055 (got {:?})", self.listen));
        }
        if !matches!(self.system_proxy.as_str(), "on" | "off" | "force") {
            return Err(format!("system_proxy must be on, off or force (got {:?})", self.system_proxy));
        }
        Ok(())
    }
}

/// One domain per line (or comma-separated); strips schemes, wildcards and
/// stray dots people tend to paste in.
pub fn parse_domains(text: &str) -> Result<Vec<String>, String> {
    let mut out: Vec<String> = Vec::new();
    for raw in text.split(|c: char| c == '\n' || c == ',' || c.is_whitespace()) {
        let mut d = raw.trim().to_lowercase();
        for p in ["https://", "http://"] {
            if let Some(rest) = d.strip_prefix(p) {
                d = rest.to_owned();
            }
        }
        if let Some(rest) = d.strip_prefix("*.") {
            d = rest.to_owned();
        }
        let d = d.split('/').next().unwrap_or("").trim_matches('.').to_owned();
        if d.is_empty() {
            continue;
        }
        if !d.contains('.') {
            return Err(tr!("domain-invalid", domain = d));
        }
        if !d.chars().all(|c| c.is_ascii_lowercase() || c.is_ascii_digit() || c == '-' || c == '.') {
            return Err(tr!("domain-characters", domain = d));
        }
        if !out.contains(&d) {
            out.push(d);
        }
    }
    Ok(out)
}

/// Lines like "13389 = build-pc.example.ts.net:3389" or "auto = ...".
pub fn parse_forwards(text: &str) -> Result<Vec<Forward>, String> {
    let mut out: Vec<Forward> = Vec::new();
    for (i, line) in text.lines().enumerate() {
        let line = line.trim();
        if line.is_empty() || line.starts_with('#') {
            continue;
        }
        let n = i + 1;
        let (left, right) = line.split_once('=').ok_or_else(|| tr!("forwards-line-format", line = n))?;
        let left = left.trim();
        let port = if left.eq_ignore_ascii_case("auto") {
            0
        } else {
            match left.parse::<u16>() {
                Ok(p) if p > 0 => p,
                _ => return Err(tr!("forwards-line-port", line = n, value = left)),
            }
        };
        let target = right.trim().to_owned();
        match target.rsplit_once(':') {
            Some((h, p)) if !h.is_empty() && p.parse::<u16>().is_ok() => {}
            _ => return Err(tr!("forwards-line-target", line = n, value = target)),
        }
        if port != 0 && out.iter().any(|f| f.local_port == port) {
            return Err(tr!("forwards-line-duplicate", line = n, port = port.to_string()));
        }
        out.push(Forward { local_port: port, target });
    }
    Ok(out)
}

pub fn forwards_text(fs: &[Forward]) -> String {
    fs.iter().map(ToString::to_string).collect::<Vec<_>>().join("\n")
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn legacy_folder_moves_even_after_a_failed_attempt_left_a_log() {
        let root = std::env::temp_dir().join(format!("tl-migrate-{}", rand::random::<u64>()));
        let (old, new) = (root.join("tailnet-proxy"), root.join("Tailnet Link"));
        std::fs::create_dir_all(old.join("nodes").join("t1")).unwrap();
        std::fs::write(old.join("config.json"), "{}").unwrap();
        std::fs::write(old.join("nodes").join("t1").join("tailscaled.state"), "x").unwrap();
        // An earlier start couldn't move it, but its log created the new folder.
        std::fs::create_dir_all(&new).unwrap();
        std::fs::write(new.join("tailnet-link.log"), "log").unwrap();

        assert_eq!(migrate_dir(&old, &new).unwrap(), Some(old.clone()));
        assert!(new.join("config.json").exists());
        assert!(new.join("nodes").join("t1").join("tailscaled.state").exists());
        assert!(new.join("tailnet-link.log").exists());
        assert!(!old.exists());
        // Settings in place: never again.
        std::fs::create_dir_all(&old).unwrap();
        assert_eq!(migrate_dir(&old, &new).unwrap(), None);
        let _ = std::fs::remove_dir_all(&root);
    }

    #[test]
    fn domains_are_cleaned_up() {
        let got = parse_domains("https://Example.ts.net/\n*.example.com, example.com\n\n  .other.ts.net. ").unwrap();
        assert_eq!(got, vec!["example.ts.net", "example.com", "other.ts.net"]);
        assert!(parse_domains("localhost").is_err());
        assert!(parse_domains("bad_domain.com").is_err());
    }

    #[test]
    fn forwards_parse() {
        let got = parse_forwards("# comment\n13389 = build-pc.x.ts.net:3389\n\nauto=db.x.ts.net:5432").unwrap();
        assert_eq!(got.len(), 2);
        assert_eq!(got[0].local_port, 13389);
        assert_eq!(got[1].local_port, 0);
        assert_eq!(got[1].target, "db.x.ts.net:5432");
        for bad in ["abc = h:1", "13389", "70000 = h:1", "1 = nohost", "1 = h:1\n1 = h:2"] {
            assert!(parse_forwards(bad).is_err(), "{bad:?} should fail");
        }
        assert_eq!(forwards_text(&got), "13389 = build-pc.x.ts.net:3389\nauto = db.x.ts.net:5432");
    }

    #[test]
    fn listen_must_be_local() {
        let c = Config { listen: "0.0.0.0:1055".into(), ..Config::default() };
        assert!(c.validate().is_err());
    }

    #[test]
    fn null_lists_from_older_versions_load() {
        let c: Config = serde_json::from_str(
            r#"{"tailnets":[{"id":"t1","name":"","enabled":true,"domain":"","extra_domains":null}],
                "forwards":null,"enabled":true}"#,
        )
        .unwrap();
        assert_eq!(c.tailnets.len(), 1);
        assert!(c.tailnets[0].extra_domains.is_empty(), "{:?}", c.tailnets[0].extra_domains);
        assert!(c.forwards.is_empty(), "{:?}", c.forwards);
    }

    #[test]
    fn tailnet_domains() {
        let t = TailnetConfig {
            domain: "a.ts.net".into(),
            extra_domains: vec!["a.ts.net".into(), "corp.example.com".into()],
            ..Default::default()
        };
        assert_eq!(t.domains(), vec!["a.ts.net", "corp.example.com"]);
    }
}
