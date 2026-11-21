//! macOS and Linux desktop proxy settings, behind one interface. Commands run
//! through a replaceable runner so tests can replay recorded output.

use crate::sync::lock;
use std::sync::Mutex;

pub trait PacBackend: Send + Sync {
    fn name(&self) -> &'static str;
    /// The PAC URL in use, or "" if the system isn't using one.
    fn current(&self) -> Result<String, String>;
    /// The settings `apply` will change, so `restore` can put them back.
    fn snapshot(&self) -> Result<serde_json::Value, String>;
    fn apply(&self, url: &str) -> Result<(), String>;
    fn restore(&self, prev: &serde_json::Value) -> Result<(), String>;
    /// Changing it costs a password prompt: leave it on while running (the PAC
    /// goes all-direct when paused) and only change it at start and quit.
    fn privileged(&self) -> bool;
    /// Run "<exe> --cleanup" at next login, in case the app and its watchdog both die.
    fn install_cleanup(&self, exe: &str) -> Result<(), String>;
    fn remove_cleanup(&self);
}

type Runner = Box<dyn Fn(&str, &[&str]) -> Result<String, String> + Send + Sync>;
static RUNNER: Mutex<Option<Runner>> = Mutex::new(None);

/// Runs a command, returning its combined output.
pub fn run(cmd: &str, args: &[&str]) -> Result<String, String> {
    if let Some(r) = lock(&RUNNER).as_ref() {
        return r(cmd, args);
    }
    let out = std::process::Command::new(cmd).args(args).output().map_err(|e| format!("{cmd}: {e}"))?;
    let mut text = String::from_utf8_lossy(&out.stdout).into_owned();
    text.push_str(&String::from_utf8_lossy(&out.stderr));
    if out.status.success() { Ok(text) } else { Err(text) }
}

/// Tests: replace the command runner.
#[cfg(test)]
pub fn set_runner(r: Option<Runner>) {
    *lock(&RUNNER) = r;
}

pub fn installed(cmd: &str) -> bool {
    if lock(&RUNNER).is_some() {
        return run("which", &[cmd]).is_ok();
    }
    std::env::var_os("PATH").is_some_and(|p| std::env::split_paths(&p).any(|d| d.join(cmd).is_file()))
}

pub fn shell_quote(s: &str) -> String {
    format!("'{}'", s.replace('\'', r"'\''"))
}

pub fn apple_script_string(s: &str) -> String {
    format!("\"{}\"", s.replace('\\', r"\\").replace('"', "\\\""))
}

// ---- macOS: networksetup on every enabled network service ----

pub struct MacBackend {
    privileged: std::sync::atomic::AtomicBool,
}

impl MacBackend {
    pub fn new() -> Self {
        MacBackend { privileged: false.into() }
    }

    fn services() -> Result<Vec<String>, String> {
        let out = run("networksetup", &["-listallnetworkservices"])?;
        let svcs: Vec<String> = out
            .lines()
            .enumerate()
            .filter(|(i, l)| {
                let l = l.trim();
                let header = *i == 0 && l.to_lowercase().contains("asterisk");
                !(l.is_empty() || l.starts_with('*') || header)
            })
            .map(|(_, l)| l.trim().to_owned())
            .collect();
        if svcs.is_empty() {
            return Err("no enabled network services found".into());
        }
        Ok(svcs)
    }

    fn get(svc: &str) -> Result<(String, bool), String> {
        Ok(parse_mac_autoproxy(&run("networksetup", &["-getautoproxyurl", svc])?))
    }

    /// Runs the commands directly; if macOS says admin rights are needed, runs
    /// them all again behind one administrator password prompt.
    fn run_all(&self, cmds: &[Vec<String>]) -> Result<(), String> {
        use std::sync::atomic::Ordering;
        if !self.privileged.load(Ordering::SeqCst) {
            let mut need_admin = false;
            for c in cmds {
                let args: Vec<&str> = c[1..].iter().map(String::as_str).collect();
                let (out, ok) = match run(&c[0], &args) {
                    Ok(o) => (o, true),
                    Err(o) => (o, false),
                };
                let low = out.to_lowercase();
                if low.contains("admin") || low.contains("privilege") {
                    need_admin = true;
                    break;
                }
                if !ok {
                    return Err(format!("{}: {}", c.join(" "), out.trim()));
                }
            }
            if !need_admin {
                return Ok(());
            }
            self.privileged.store(true, Ordering::SeqCst);
        }
        let script = cmds
            .iter()
            .map(|c| c.iter().map(|a| shell_quote(a)).collect::<Vec<_>>().join(" "))
            .collect::<Vec<_>>()
            .join(" && ");
        let apple = format!(
            "do shell script {} with prompt {} with administrator privileges",
            apple_script_string(&script),
            apple_script_string("Tailnet Link wants to change your proxy setting.")
        );
        run("osascript", &["-e", &apple])
            .map(|_| ())
            .map_err(|e| format!("changing proxy setting with admin rights: {}", e.trim()))
    }
}

pub fn parse_mac_autoproxy(out: &str) -> (String, bool) {
    let (mut url, mut enabled) = (String::new(), false);
    for line in out.lines() {
        if let Some((k, v)) = line.split_once(':') {
            let v = v.trim();
            match k.trim() {
                "URL" if v != "(null)" => v.clone_into(&mut url),
                "Enabled" => enabled = v.eq_ignore_ascii_case("yes"),
                _ => {}
            }
        }
    }
    (url, enabled)
}

impl PacBackend for MacBackend {
    fn name(&self) -> &'static str {
        "macos"
    }
    fn privileged(&self) -> bool {
        self.privileged.load(std::sync::atomic::Ordering::SeqCst)
    }
    fn current(&self) -> Result<String, String> {
        for s in Self::services()? {
            if let Ok((url, true)) = Self::get(&s)
                && !url.is_empty()
            {
                return Ok(url);
            }
        }
        Ok(String::new())
    }
    fn snapshot(&self) -> Result<serde_json::Value, String> {
        let mut m = serde_json::Map::new();
        for s in Self::services()? {
            let (url, enabled) = Self::get(&s)?;
            m.insert(s, serde_json::json!({"url": url, "enabled": enabled}));
        }
        Ok(serde_json::Value::Object(m))
    }
    fn apply(&self, url: &str) -> Result<(), String> {
        let mut cmds = Vec::new();
        for s in Self::services()? {
            cmds.push(vec!["networksetup".into(), "-setautoproxyurl".into(), s.clone(), url.into()]);
            cmds.push(vec!["networksetup".into(), "-setautoproxystate".into(), s, "on".into()]);
        }
        self.run_all(&cmds)
    }
    fn restore(&self, prev: &serde_json::Value) -> Result<(), String> {
        let mut cmds = Vec::new();
        for s in Self::services()? {
            let p = prev.get(&s);
            let url = p.and_then(|p| p["url"].as_str()).unwrap_or("").to_owned();
            let enabled = p.and_then(|p| p["enabled"].as_bool()).unwrap_or(false);
            if !url.is_empty() {
                cmds.push(vec!["networksetup".into(), "-setautoproxyurl".into(), s.clone(), url.clone()]);
            }
            let state = if enabled && !url.is_empty() { "on" } else { "off" };
            cmds.push(vec!["networksetup".into(), "-setautoproxystate".into(), s, state.into()]);
        }
        self.run_all(&cmds)
    }
    fn install_cleanup(&self, exe: &str) -> Result<(), String> {
        crate::autostart::write_launch_agent("com.azazellabs.tailnet-link.cleanup", &[exe, "--cleanup"])
    }
    fn remove_cleanup(&self) {
        let _ = std::fs::remove_file(crate::autostart::launch_agent_path("com.azazellabs.tailnet-link.cleanup"));
    }
}

// ---- Linux desktops: GNOME (gsettings) and KDE (kioslaverc) ----

const GNOME: &str = "org.gnome.system.proxy";
const KDE_GROUP: &str = "Proxy Settings";

pub struct DesktopBackend {
    gnome: bool,
    kver: Option<&'static str>,
}

fn unquote_gvariant(s: &str) -> String {
    let s = s.trim();
    if s.len() >= 2 && s.starts_with('\'') && s.ends_with('\'') {
        s[1..s.len() - 1].replace("\\'", "'")
    } else {
        s.to_owned()
    }
}

fn quote_gvariant(s: &str) -> String {
    format!("'{}'", s.replace('\\', r"\\").replace('\'', r"\'"))
}

impl DesktopBackend {
    pub fn new() -> Result<Self, String> {
        let gnome = installed("gsettings") && run("gsettings", &["get", GNOME, "mode"]).is_ok();
        let mut kver = None;
        if std::env::var("XDG_CURRENT_DESKTOP").unwrap_or_default().to_uppercase().contains("KDE") {
            for v in ["6", "5"] {
                if installed(&format!("kwriteconfig{v}")) && installed(&format!("kreadconfig{v}")) {
                    kver = Some(v);
                    break;
                }
            }
        }
        if !gnome && kver.is_none() {
            return Err("no GNOME or KDE proxy settings found; set your browser to the PAC address yourself".into());
        }
        Ok(DesktopBackend { gnome, kver })
    }

    fn gget(key: &str) -> Result<String, String> {
        run("gsettings", &["get", GNOME, key]).map(|o| unquote_gvariant(&o))
    }
    fn gset(key: &str, val: &str) -> Result<(), String> {
        run("gsettings", &["set", GNOME, key, &quote_gvariant(val)]).map(|_| ())
    }
    fn kget(&self, key: &str) -> String {
        let v = self.kver.unwrap_or("5");
        run(&format!("kreadconfig{v}"), &["--file", "kioslaverc", "--group", KDE_GROUP, "--key", key])
            .map(|o| o.trim().to_owned())
            .unwrap_or_default()
    }
    fn kset(&self, key: &str, val: &str) -> Result<(), String> {
        let v = self.kver.unwrap_or("5");
        run(&format!("kwriteconfig{v}"), &["--file", "kioslaverc", "--group", KDE_GROUP, "--key", key, val]).map(|_| ())
    }
    fn kde_notify() {
        let _ = run(
            "dbus-send",
            &["--type=signal", "/KIO/Scheduler", "org.kde.KIO.Scheduler.reparseSlaveConfiguration", "string:"],
        );
    }
}

impl PacBackend for DesktopBackend {
    fn name(&self) -> &'static str {
        "linux-desktop"
    }
    fn privileged(&self) -> bool {
        false
    }
    fn current(&self) -> Result<String, String> {
        if self.gnome && Self::gget("mode")? == "auto" {
            return Self::gget("autoconfig-url");
        }
        if self.kver.is_some() && self.kget("ProxyType") == "2" {
            return Ok(self.kget("Proxy Config Script"));
        }
        Ok(String::new())
    }
    fn snapshot(&self) -> Result<serde_json::Value, String> {
        let mut v = serde_json::json!({});
        if self.gnome {
            v["gnome_mode"] = Self::gget("mode")?.into();
            v["gnome_url"] = Self::gget("autoconfig-url")?.into();
        }
        if self.kver.is_some() {
            v["kde_type"] = self.kget("ProxyType").into();
            v["kde_script"] = self.kget("Proxy Config Script").into();
        }
        Ok(v)
    }
    fn apply(&self, url: &str) -> Result<(), String> {
        if self.gnome {
            Self::gset("autoconfig-url", url)?; // URL first, so nothing points at a stale address
            Self::gset("mode", "auto")?;
        }
        if self.kver.is_some() {
            self.kset("Proxy Config Script", url)?;
            self.kset("ProxyType", "2")?;
            Self::kde_notify();
        }
        Ok(())
    }
    fn restore(&self, prev: &serde_json::Value) -> Result<(), String> {
        let mut errs = Vec::new();
        if self.gnome {
            let mode = prev["gnome_mode"].as_str().filter(|s| !s.is_empty()).unwrap_or("none");
            let url = prev["gnome_url"].as_str().unwrap_or("");
            // Mode first, so nothing points at our address once it's gone.
            errs.extend(Self::gset("mode", mode).err());
            errs.extend(Self::gset("autoconfig-url", url).err());
        }
        if self.kver.is_some() {
            let typ = prev["kde_type"].as_str().filter(|s| !s.is_empty()).unwrap_or("0");
            let script = prev["kde_script"].as_str().unwrap_or("");
            errs.extend(self.kset("ProxyType", typ).err());
            errs.extend(self.kset("Proxy Config Script", script).err());
            Self::kde_notify();
        }
        if errs.is_empty() { Ok(()) } else { Err(errs.join("; ")) }
    }
    fn install_cleanup(&self, exe: &str) -> Result<(), String> {
        crate::autostart::write_desktop_entry("tailnet-link-cleanup", "Tailnet Link cleanup", &[exe, "--cleanup"])
    }
    fn remove_cleanup(&self) {
        let _ = std::fs::remove_file(crate::autostart::xdg_autostart_path("tailnet-link-cleanup"));
    }
}

#[cfg(test)]
pub(crate) mod tests {
    use super::*;
    use std::sync::{Arc, Mutex as StdMutex};

    /// Serialises tests that replace the global command runner.
    pub static RUNNER_LOCK: StdMutex<()> = StdMutex::new(());

    pub struct Shell {
        pub calls: Arc<StdMutex<Vec<String>>>,
    }
    impl Shell {
        pub fn install(answer: impl Fn(&str) -> Result<String, String> + Send + Sync + 'static) -> Shell {
            let calls = Arc::new(StdMutex::new(Vec::new()));
            let c2 = calls.clone();
            set_runner(Some(Box::new(move |cmd, args| {
                let line = format!("{cmd} {}", args.join(" "));
                lock(&c2).push(line.clone());
                answer(&line)
            })));
            Shell { calls }
        }
        pub fn ran(&self, prefix: &str) -> bool {
            lock(&self.calls).iter().any(|c| c.starts_with(prefix))
        }
        pub fn clear(&self) {
            lock(&self.calls).clear();
        }
    }
    impl Drop for Shell {
        fn drop(&mut self) {
            set_runner(None);
        }
    }

    const SERVICES: &str =
        "An asterisk (*) denotes that a network service is disabled.\nWi-Fi\nThunderbolt Bridge\n*Old VPN\n";

    #[test]
    fn mac_snapshot_apply_restore() {
        let _g = lock(&RUNNER_LOCK);
        let sh = Shell::install(|c| {
            Ok(if c.starts_with("networksetup -listallnetworkservices") {
                SERVICES.into()
            } else if c == "networksetup -getautoproxyurl Wi-Fi" {
                "URL: http://corp.example/proxy.pac\nEnabled: Yes\n".into()
            } else if c.starts_with("networksetup -getautoproxyurl") {
                "URL: (null)\nEnabled: No\n".into()
            } else {
                String::new()
            })
        });
        let m = MacBackend::new();
        assert_eq!(MacBackend::services().unwrap(), vec!["Wi-Fi", "Thunderbolt Bridge"]);
        assert_eq!(m.current().unwrap(), "http://corp.example/proxy.pac");
        let snap = m.snapshot().unwrap();
        assert_eq!(snap["Wi-Fi"]["enabled"], true);
        m.apply("http://127.0.0.1:1055/proxy.pac?v=1").unwrap();
        assert!(!m.privileged());
        assert!(sh.ran("networksetup -setautoproxyurl Wi-Fi http://127.0.0.1:1055/proxy.pac?v=1"));
        assert!(sh.ran("networksetup -setautoproxystate Wi-Fi on"));
        sh.clear();
        m.restore(&snap).unwrap();
        assert!(sh.ran("networksetup -setautoproxyurl Wi-Fi http://corp.example/proxy.pac"));
        assert!(sh.ran("networksetup -setautoproxystate Thunderbolt Bridge off"));
    }

    #[test]
    fn mac_falls_back_to_admin_prompt() {
        let _g = lock(&RUNNER_LOCK);
        let script = Arc::new(StdMutex::new(String::new()));
        let s2 = script.clone();
        let _sh = Shell::install(move |c| {
            if c.starts_with("networksetup -listallnetworkservices") {
                Ok("An asterisk (*) denotes that a network service is disabled.\nWi-Fi\n".into())
            } else if c.starts_with("networksetup -set") {
                Err("** Error: Command requires admin privileges.\n".into())
            } else if let Some(s) = c.strip_prefix("osascript -e ") {
                *lock(&s2) = s.to_owned();
                Ok(String::new())
            } else {
                Ok(String::new())
            }
        });
        let m = MacBackend::new();
        m.apply("http://127.0.0.1:1055/proxy.pac?v=1").unwrap();
        assert!(m.privileged());
        let s = lock(&script).clone();
        assert!(s.starts_with(r#"do shell script "'networksetup' '-setautoproxyurl' 'Wi-Fi' 'http://127.0.0.1:1055/proxy.pac?v=1' && 'networksetup' '-setautoproxystate' 'Wi-Fi' 'on'""#), "{s}");
        assert!(s.ends_with("with administrator privileges"));
    }

    #[test]
    fn gnome_apply_restore() {
        let _g = lock(&RUNNER_LOCK);
        let sh = Shell::install(|c| match c {
            "which gsettings" => Ok(String::new()),
            c if c.starts_with("which") => Err(String::new()),
            "gsettings get org.gnome.system.proxy mode" => Ok("'manual'\n".into()),
            "gsettings get org.gnome.system.proxy autoconfig-url" => Ok("''\n".into()),
            _ => Ok(String::new()),
        });
        let b = DesktopBackend::new().unwrap();
        assert!(b.gnome);
        let snap = b.snapshot().unwrap();
        sh.clear();
        b.apply("http://127.0.0.1:1055/proxy.pac?v=1").unwrap();
        assert!(sh.ran("gsettings set org.gnome.system.proxy autoconfig-url 'http://127.0.0.1:1055/proxy.pac?v=1'"));
        assert!(sh.ran("gsettings set org.gnome.system.proxy mode 'auto'"));
        sh.clear();
        b.restore(&snap).unwrap();
        assert!(sh.ran("gsettings set org.gnome.system.proxy mode 'manual'"));
        assert!(sh.ran("gsettings set org.gnome.system.proxy autoconfig-url ''"));
    }

    #[test]
    fn quoting() {
        assert_eq!(apple_script_string(r#"a "b" \c"#), r#""a \"b\" \\c""#);
        assert_eq!(shell_quote("it's"), r"'it'\''s'");
        assert_eq!(unquote_gvariant("'auto'\n"), "auto");
    }
}
