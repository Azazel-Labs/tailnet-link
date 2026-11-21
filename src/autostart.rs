//! "Start at login": Windows Run key, macOS `LaunchAgent`, Linux XDG autostart.
//! Also the helpers the macOS/Linux crash cleanup uses for its login items.

#![allow(dead_code)]

use std::fmt::Write as _;
use std::path::PathBuf;

pub fn supported() -> bool {
    cfg!(any(windows, target_os = "macos", target_os = "linux"))
}

// ---- Windows ----

#[cfg(windows)]
const RUN_KEY: &str = r"Software\Microsoft\Windows\CurrentVersion\Run";

#[cfg(windows)]
pub fn enabled() -> bool {
    use winreg::{RegKey, enums::HKEY_CURRENT_USER};
    RegKey::predef(HKEY_CURRENT_USER)
        .open_subkey(RUN_KEY)
        .and_then(|k| k.get_value::<String, _>("Tailnet Link"))
        .is_ok()
}

#[cfg(windows)]
pub fn set(on: bool) -> Result<(), String> {
    use winreg::{RegKey, enums::HKEY_CURRENT_USER};
    let (k, _) = RegKey::predef(HKEY_CURRENT_USER).create_subkey(RUN_KEY).map_err(|e| e.to_string())?;
    if on {
        let exe = std::env::current_exe().map_err(|e| e.to_string())?;
        // Same format as the installer writes.
        k.set_value("Tailnet Link", &format!("\"{}\" --background", exe.display())).map_err(|e| e.to_string())
    } else {
        match k.delete_value("Tailnet Link") {
            Err(e) if e.kind() != std::io::ErrorKind::NotFound => Err(e.to_string()),
            _ => Ok(()),
        }
    }
}

// ---- macOS ----

#[cfg(target_os = "macos")]
pub fn enabled() -> bool {
    launch_agent_path("com.azazellabs.tailnet-link").exists()
}

#[cfg(target_os = "macos")]
pub fn set(on: bool) -> Result<(), String> {
    if on {
        let exe = std::env::current_exe().map_err(|e| e.to_string())?;
        write_launch_agent("com.azazellabs.tailnet-link", &[&exe.to_string_lossy(), "--background"])
    } else {
        remove_if_exists(launch_agent_path("com.azazellabs.tailnet-link"))
    }
}

// ---- Linux ----

#[cfg(target_os = "linux")]
pub fn enabled() -> bool {
    xdg_autostart_path("tailnet-link").exists()
}

#[cfg(target_os = "linux")]
pub fn set(on: bool) -> Result<(), String> {
    if on {
        let exe = std::env::current_exe().map_err(|e| e.to_string())?;
        write_desktop_entry("tailnet-link", "Tailnet Link", &[&exe.to_string_lossy(), "--background"])
    } else {
        remove_if_exists(xdg_autostart_path("tailnet-link"))
    }
}

#[cfg(not(any(windows, target_os = "macos", target_os = "linux")))]
pub fn enabled() -> bool {
    false
}
#[cfg(not(any(windows, target_os = "macos", target_os = "linux")))]
pub fn set(_: bool) -> Result<(), String> {
    Err(crate::i18n::tr!("autostart-unsupported"))
}

fn remove_if_exists(p: PathBuf) -> Result<(), String> {
    match std::fs::remove_file(p) {
        Err(e) if e.kind() != std::io::ErrorKind::NotFound => Err(e.to_string()),
        _ => Ok(()),
    }
}

// ---- Login-item files (shared) ----

pub fn xdg_autostart_path(name: &str) -> PathBuf {
    let base = std::env::var_os("XDG_CONFIG_HOME")
        .map(PathBuf::from)
        .or_else(dirs::config_dir)
        .unwrap_or_else(|| PathBuf::from(".config"));
    base.join("autostart").join(format!("{name}.desktop"))
}

/// Quotes one argument for a .desktop Exec= line.
fn desktop_exec_quote(s: &str) -> String {
    let mut out = String::from("\"");
    for c in s.chars() {
        match c {
            '\\' => out.push_str(r"\\\\"),
            '"' => out.push_str(r#"\\""#),
            '`' => out.push_str(r"\\`"),
            '$' => out.push_str(r"\\$"),
            c => out.push(c),
        }
    }
    out.push('"');
    out
}

pub fn write_desktop_entry(name: &str, title: &str, argv: &[&str]) -> Result<(), String> {
    let p = xdg_autostart_path(name);
    if let Some(dir) = p.parent() {
        std::fs::create_dir_all(dir).map_err(|e| e.to_string())?;
    }
    let exec = argv.iter().map(|a| desktop_exec_quote(a)).collect::<Vec<_>>().join(" ");
    let body = format!(
        "[Desktop Entry]\nType=Application\nName={title}\nExec={exec}\nX-GNOME-Autostart-enabled=true\nNoDisplay=true\nTerminal=false\n"
    );
    std::fs::write(p, body).map_err(|e| e.to_string())
}

pub fn launch_agent_path(label: &str) -> PathBuf {
    dirs::home_dir().unwrap_or_default().join("Library/LaunchAgents").join(format!("{label}.plist"))
}

fn xml_escape(s: &str) -> String {
    s.replace('&', "&amp;").replace('<', "&lt;").replace('>', "&gt;").replace('"', "&quot;")
}

pub fn write_launch_agent(label: &str, argv: &[&str]) -> Result<(), String> {
    let p = launch_agent_path(label);
    if let Some(dir) = p.parent() {
        std::fs::create_dir_all(dir).map_err(|e| e.to_string())?;
    }
    let args = argv.iter().fold(String::new(), |mut out, a| {
        let _ = writeln!(out, "    <string>{}</string>", xml_escape(a));
        out
    });
    let body = format!(
        r#"<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>Label</key><string>{}</string>
  <key>ProgramArguments</key>
  <array>
{args}  </array>
  <key>RunAtLoad</key><true/>
</dict>
</plist>
"#,
        xml_escape(label)
    );
    std::fs::write(p, body).map_err(|e| e.to_string())
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn exec_quoting() {
        assert_eq!(desktop_exec_quote("/opt/my app/x"), "\"/opt/my app/x\"");
        assert_eq!(xml_escape("a&b<c>"), "a&amp;b&lt;c&gt;");
    }
}
