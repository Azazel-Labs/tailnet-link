//! The app's side of `tl` (src/bin/tl.rs): opening a terminal where the
//! tailnets' names work, and putting `tl` on Windows's `PATH` for the installer.

use std::path::PathBuf;
use std::process::Command;

use crate::i18n::tr;

/// `tl`, installed next to the app.
fn tl_path() -> Result<PathBuf, String> {
    let exe = std::env::current_exe().map_err(|e| tr!("open-terminal-failed", error = e.to_string()))?;
    let tl = exe.with_file_name(if cfg!(windows) { "tl.exe" } else { "tl" });
    if tl.is_file() { Ok(tl) } else { Err(tr!("open-terminal-missing")) }
}

/// Opens a new terminal window running `tl`, which starts the usual shell with
/// the tailnets' names working, in the home folder.
pub fn open() -> Result<(), String> {
    let tl = tl_path()?;
    let home = dirs::home_dir().unwrap_or_else(|| PathBuf::from("."));
    let failed = |e: std::io::Error| tr!("open-terminal-failed", error = e.to_string());
    #[cfg(windows)]
    {
        use std::os::windows::process::CommandExt as _;
        const CREATE_NEW_CONSOLE: u32 = 0x0000_0010;
        Command::new(&tl).current_dir(&home).creation_flags(CREATE_NEW_CONSOLE).spawn().map_err(failed)?;
        Ok(())
    }
    #[cfg(target_os = "macos")]
    {
        let line = format!("cd {} && exec {}", sh_quote(&home.to_string_lossy()), sh_quote(&tl.to_string_lossy()));
        let script = format!(
            "tell application \"Terminal\"\nactivate\ndo script \"{}\"\nend tell",
            line.replace('\\', "\\\\").replace('"', "\\\"")
        );
        Command::new("osascript").arg("-e").arg(script).spawn().map_err(failed)?;
        Ok(())
    }
    #[cfg(not(any(windows, target_os = "macos")))]
    {
        // The desktop's own choice first, then the common ones.
        let terminals: [(&str, &[&str]); 7] = [
            ("x-terminal-emulator", &["-e"]),
            ("gnome-terminal", &["--"]),
            ("konsole", &["-e"]),
            ("xfce4-terminal", &["-x"]),
            ("kitty", &[]),
            ("alacritty", &["-e"]),
            ("xterm", &["-e"]),
        ];
        let mut last = None;
        for (program, args) in terminals {
            match Command::new(program).args(args).arg(&tl).current_dir(&home).spawn() {
                Ok(_) => return Ok(()),
                Err(e) if e.kind() == std::io::ErrorKind::NotFound => {}
                Err(e) => last = Some(e),
            }
        }
        Err(last.map_or_else(|| tr!("open-terminal-failed", error = "no terminal program found"), failed))
    }
}

#[cfg(target_os = "macos")]
fn sh_quote(s: &str) -> String {
    format!("'{}'", s.replace('\'', r"'\''"))
}

/// The system `Path`, where the installer puts the app's folder so `tl` works
/// in every terminal.
#[cfg(windows)]
const ENVIRONMENT: &str = r"SYSTEM\CurrentControlSet\Control\Session Manager\Environment";

/// Adds (or with `add` false, removes) the app's folder to the system `Path`.
/// For the installer, run as administrator. Done here rather than in the
/// installer's script because that truncates long values.
#[cfg(windows)]
pub fn set_on_path(add: bool) -> Result<(), String> {
    use winreg::RegKey;
    use winreg::enums::{HKEY_LOCAL_MACHINE, KEY_READ, KEY_WRITE, REG_EXPAND_SZ};
    let dir = std::env::current_exe().map_err(|e| e.to_string())?;
    let dir = dir.parent().ok_or("no folder")?.to_string_lossy().into_owned();
    let key = RegKey::predef(HKEY_LOCAL_MACHINE)
        .open_subkey_with_flags(ENVIRONMENT, KEY_READ | KEY_WRITE)
        .map_err(|e| format!("opening the system environment: {e}"))?;
    let (current, kind) = match key.get_raw_value("Path") {
        Ok(v) => (from_wide(&v.bytes), v.vtype),
        Err(_) => (String::new(), REG_EXPAND_SZ),
    };
    let Some(updated) = path_with(&current, &dir, add) else { return Ok(()) };
    let mut bytes: Vec<u8> = updated.encode_utf16().chain([0]).flat_map(u16::to_le_bytes).collect();
    bytes.shrink_to_fit();
    key.set_raw_value("Path", &winreg::RegValue { bytes: bytes.into(), vtype: kind })
        .map_err(|e| format!("changing the system Path: {e}"))?;
    broadcast_environment_change();
    Ok(())
}

#[cfg(windows)]
fn from_wide(bytes: &[u8]) -> String {
    let units: Vec<u16> = bytes.as_chunks::<2>().0.iter().map(|c| u16::from_le_bytes(*c)).collect();
    let end = units.iter().position(|&u| u == 0).unwrap_or(units.len());
    String::from_utf16_lossy(&units[..end])
}

/// `path` with `dir` added at the end or removed, or None if nothing changes.
/// Entries compare case-insensitively and ignoring a trailing backslash.
#[cfg_attr(not(windows), allow(dead_code))]
fn path_with(path: &str, dir: &str, add: bool) -> Option<String> {
    let same = |e: &str| e.trim().trim_end_matches('\\').eq_ignore_ascii_case(dir.trim_end_matches('\\'));
    let entries: Vec<&str> = path.split(';').filter(|e| !e.is_empty()).collect();
    let present = entries.iter().any(|e| same(e));
    if add {
        if present {
            return None;
        }
        let mut out = entries.join(";");
        if !out.is_empty() {
            out.push(';');
        }
        out.push_str(dir);
        Some(out)
    } else {
        present.then(|| entries.into_iter().filter(|e| !same(e)).collect::<Vec<_>>().join(";"))
    }
}

/// Tells open programs (Explorer, so new terminals) that the environment changed.
#[cfg(windows)]
fn broadcast_environment_change() {
    use windows_sys::Win32::UI::WindowsAndMessaging::{
        HWND_BROADCAST, SMTO_ABORTIFHUNG, SendMessageTimeoutW, WM_SETTINGCHANGE,
    };
    let name: Vec<u16> = "Environment".encode_utf16().chain([0]).collect();
    let mut result = 0;
    // SAFETY: `name` is a NUL-terminated string that outlives the call, and
    // `result` is a valid place for the answer.
    unsafe {
        SendMessageTimeoutW(
            HWND_BROADCAST,
            WM_SETTINGCHANGE,
            0,
            name.as_ptr() as isize,
            SMTO_ABORTIFHUNG,
            5000,
            &raw mut result,
        )
    };
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn path_entries() {
        let dir = r"C:\Program Files\Tailnet Link";
        assert_eq!(
            path_with(r"C:\Windows;C:\Tools", dir, true).as_deref(),
            Some(r"C:\Windows;C:\Tools;C:\Program Files\Tailnet Link")
        );
        assert_eq!(path_with(r"C:\Windows;c:\program files\tailnet link\", dir, true), None, "already there");
        assert_eq!(path_with("", dir, true).as_deref(), Some(dir));
        assert_eq!(
            path_with(r"C:\Windows;C:\Program Files\Tailnet Link;C:\Tools", dir, false).as_deref(),
            Some(r"C:\Windows;C:\Tools")
        );
        assert_eq!(path_with(r"C:\Windows;;C:\Tools", dir, false), None, "not there: left alone");
        assert_eq!(
            path_with(r"%SystemRoot%;C:\Tools;", dir, true).as_deref(),
            Some(r"%SystemRoot%;C:\Tools;C:\Program Files\Tailnet Link")
        );
    }
}
