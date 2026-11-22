//! Windows: HKCU\...\Internet Settings\AutoConfigURL ("Use setup script").
//! What to restore and which process owns it live in HKCU\Software\Tailnet Link.

use super::ProxyError;
use crate::proxy::{is_our_pac, is_tailnet_link_pac};
use crate::sync::lock;
use std::sync::atomic::{AtomicBool, Ordering};
use std::sync::{Mutex, Once};
use std::time::Instant;
use winreg::RegKey;
use winreg::enums::{HKEY_CURRENT_USER, KEY_SET_VALUE};

const INTERNET_SETTINGS: &str = r"Software\Microsoft\Windows\CurrentVersion\Internet Settings";
const RUN_ONCE: &str = r"Software\Microsoft\Windows\CurrentVersion\RunOnce";
const STATE_KEY: &str = r"Software\Tailnet Link";
const RUN_ONCE_NAME: &str = "Tailnet Link cleanup";

fn hkcu() -> RegKey {
    RegKey::predef(HKEY_CURRENT_USER)
}

/// Tells running apps (Edge, Chrome, ...) to re-read the setting.
fn notify_change() {
    use windows_sys::Win32::Networking::WinInet::{
        INTERNET_OPTION_REFRESH, INTERNET_OPTION_SETTINGS_CHANGED, InternetSetOptionW,
    };
    for option in [INTERNET_OPTION_SETTINGS_CHANGED, INTERNET_OPTION_REFRESH] {
        // SAFETY: these two options take no buffer (null, length 0).
        unsafe { InternetSetOptionW(std::ptr::null_mut(), option, std::ptr::null(), 0) };
    }
}

pub fn read_auto_config_url() -> String {
    hkcu().open_subkey(INTERNET_SETTINGS).and_then(|k| k.get_value::<String, _>("AutoConfigURL")).unwrap_or_default()
}

fn set_auto_config_url(v: Option<&str>) -> std::io::Result<()> {
    let (k, _) = hkcu().create_subkey(INTERNET_SETTINGS)?;
    match v {
        Some(v) => k.set_value("AutoConfigURL", &v),
        None => match k.delete_value("AutoConfigURL") {
            Err(e) if e.kind() == std::io::ErrorKind::NotFound => Ok(()),
            r => r,
        },
    }
}

pub struct SystemProxy {
    pac_url: Mutex<String>,
    on: Mutex<bool>,
    force: AtomicBool,
    watchdog: Once,
    /// When the setting was last put back after something else changed it.
    reapplied: Mutex<Option<Instant>>,
}

/// The copy of the app recorded as owning the setting, if it's another one that's still running.
fn other_copy_running() -> bool {
    let recorded: u32 = hkcu().open_subkey(STATE_KEY).and_then(|k| k.get_value("OwnerPID")).unwrap_or(0);
    recorded != 0 && recorded != std::process::id() && process_alive(recorded)
}

impl SystemProxy {
    /// `force`: replace another program's setup script while running.
    #[expect(clippy::unnecessary_wraps, reason = "same signature as on macOS and Linux, where it can fail")]
    pub fn new(pac_url: &str, force: bool) -> Result<SystemProxy, String> {
        Ok(SystemProxy {
            pac_url: Mutex::new(pac_url.into()),
            on: Mutex::new(false),
            force: AtomicBool::new(force),
            watchdog: Once::new(),
            reapplied: Mutex::new(None),
        })
    }

    pub fn set_force(&self, force: bool) {
        self.force.store(force, Ordering::SeqCst);
    }

    pub fn is_on(&self) -> bool {
        *lock(&self.on)
    }

    /// The setting as it is now ("" when there's none).
    pub fn current(&self) -> String {
        read_auto_config_url()
    }

    /// Points the setting at us, unless another program's script is there.
    pub fn enable(&self) -> Result<(), ProxyError> {
        let mut on = lock(&self.on);
        if *on {
            return Ok(());
        }
        let url = lock(&self.pac_url).clone();
        let cur = read_auto_config_url();
        super::may_take(&cur, &url, self.force.load(Ordering::SeqCst), other_copy_running)?;
        self.watchdog.call_once(|| {
            if let Err(e) = super::start_watchdog() {
                log::warn!(
                    "crash watchdog not started ({e}); a crash would leave the proxy setting on until next login"
                );
            }
        });
        // 1. Record how to undo it (and who owns it) before changing anything.
        let (st, _) =
            hkcu().create_subkey(STATE_KEY).map_err(|e| ProxyError::Failed(format!("saving proxy state: {e}")))?;
        // An earlier copy's address is never what to put back; keep what that copy recorded.
        if !is_our_pac(&cur, &url) && !is_tailnet_link_pac(&cur) {
            if cur.is_empty() {
                let _ = st.delete_value("Prev");
            } else {
                let _ = st.set_value("Prev", &cur);
            }
        }
        let _ = st.set_value("Active", &url);
        let _ = st.set_value("OwnerPID", &std::process::id());
        // 2. Clean up at next login if everything else fails.
        if let Ok(exe) = std::env::current_exe()
            && let Ok((ro, _)) = hkcu().create_subkey(RUN_ONCE)
        {
            let _ = ro.set_value(RUN_ONCE_NAME, &format!("\"{}\" --cleanup", exe.display()));
        }
        // 3. Turn it on.
        set_auto_config_url(Some(&url))
            .map_err(|e| ProxyError::Failed(format!("setting the proxy setup script: {e}")))?;
        notify_change();
        if !is_our_pac(&cur, &url) {
            log::info!("Windows proxy setting now points at {url} (was {cur:?})");
        }
        *on = true;
        Ok(())
    }

    /// Checks that the setting still points at us. If something cleared it (an
    /// old copy's uninstaller, say), puts it back, but only once a minute, so we
    /// never fight a policy that keeps resetting it.
    pub fn verify(&self) -> Result<(), ProxyError> {
        if !*lock(&self.on) {
            return Ok(());
        }
        let url = lock(&self.pac_url).clone();
        let cur = read_auto_config_url();
        if is_our_pac(&cur, &url) {
            return Ok(());
        }
        log::warn!("Windows proxy setting was changed by something else (now {cur:?})");
        *lock(&self.on) = false;
        // Forget our record (and the login cleanup) without touching their setting.
        restore_proxy_state(std::process::id());
        let mut last = lock(&self.reapplied);
        if last.is_some_and(|t| t.elapsed() < super::REAPPLY_GAP) {
            return Err(ProxyError::Changed);
        }
        super::may_take(&cur, &url, self.force.load(Ordering::SeqCst), other_copy_running)?;
        *last = Some(Instant::now());
        drop(last);
        self.enable()?;
        log::info!("Windows proxy setting put back.");
        Ok(())
    }

    /// Switches to a new PAC address (the app bumps ?v= when the domains change).
    pub fn update(&self, pac_url: &str) -> Result<(), String> {
        *lock(&self.pac_url) = pac_url.into();
        if !*lock(&self.on) {
            return Ok(());
        }
        if let Ok((st, _)) = hkcu().create_subkey(STATE_KEY) {
            let _ = st.set_value("Active", &pac_url);
        }
        set_auto_config_url(Some(pac_url)).map_err(|e| e.to_string())?;
        notify_change();
        Ok(())
    }

    /// Routing stopped but the app keeps running.
    pub fn pause(&self) {
        self.disable();
    }

    pub fn disable(&self) {
        let mut on = lock(&self.on);
        if !*on {
            return;
        }
        restore_proxy_state(std::process::id());
        *on = false;
    }
}

/// Undoes our change if still in place. owner != 0: only for that owner.
/// owner == 0 (startup / RunOnce): only if the recorded owner isn't running.
pub fn restore_proxy_state(owner: u32) {
    let Ok(st) = hkcu().open_subkey(STATE_KEY) else {
        return;
    };
    let active: String = st.get_value("Active").unwrap_or_default();
    let prev: String = st.get_value("Prev").unwrap_or_default();
    let recorded: u32 = st.get_value("OwnerPID").unwrap_or(0);
    drop(st);

    if owner != 0 && recorded != owner {
        return; // another run owns it now
    }
    if owner == 0 && recorded != 0 && process_alive(recorded) {
        return; // still running; leave it alone
    }
    if !active.is_empty() && is_our_pac(&read_auto_config_url(), &active) {
        let _ = set_auto_config_url(if prev.is_empty() { None } else { Some(&prev) });
        notify_change();
        log::info!("Windows proxy setting turned off.");
    }
    let _ = hkcu().delete_subkey_all(STATE_KEY);
    if let Ok(ro) = hkcu().open_subkey_with_flags(RUN_ONCE, KEY_SET_VALUE) {
        let _ = ro.delete_value(RUN_ONCE_NAME);
    }
}

pub fn cleanup_stale() {
    restore_proxy_state(0);
}

pub fn process_alive(pid: u32) -> bool {
    use windows_sys::Win32::Foundation::CloseHandle;
    use windows_sys::Win32::System::Threading::{GetExitCodeProcess, OpenProcess, PROCESS_QUERY_LIMITED_INFORMATION};
    const STILL_ACTIVE: u32 = 259;
    // SAFETY: plain values in; returns a handle or null.
    let h = unsafe { OpenProcess(PROCESS_QUERY_LIMITED_INFORMATION, 0, pid) };
    if h.is_null() {
        return false;
    }
    let mut code = 0u32;
    // SAFETY: `h` is the open process handle; `code` is a valid place to write.
    let ok = unsafe { GetExitCodeProcess(h, &raw mut code) } != 0;
    // SAFETY: `h` is open and not used afterwards.
    unsafe { CloseHandle(h) };
    ok && code == STILL_ACTIVE
}

pub fn wait_for_exit(pid: u32) {
    use windows_sys::Win32::Foundation::CloseHandle;
    use windows_sys::Win32::System::Threading::{INFINITE, OpenProcess, PROCESS_SYNCHRONIZE, WaitForSingleObject};
    // SAFETY: plain values in; returns a handle or null.
    let h = unsafe { OpenProcess(PROCESS_SYNCHRONIZE, 0, pid) };
    if h.is_null() {
        return;
    }
    // SAFETY: `h` is an open process handle with SYNCHRONIZE access.
    unsafe { WaitForSingleObject(h, INFINITE) };
    // SAFETY: `h` is open and not used afterwards.
    unsafe { CloseHandle(h) };
}

#[cfg(test)]
mod tests {
    //! These run against the real per-user registry (on the Windows CI runner)
    //! and put everything back.
    use super::*;

    const CORP: &str = "http://corp.example/proxy.pac";
    const V1: &str = "http://127.0.0.1:1055/proxy.pac?v=1";
    const V2: &str = "http://127.0.0.1:1055/proxy.pac?v=2";

    struct Preserve(String);
    impl Drop for Preserve {
        fn drop(&mut self) {
            let _ = set_auto_config_url(if self.0.is_empty() { None } else { Some(&self.0) });
            let _ = hkcu().delete_subkey_all(STATE_KEY);
            if let Ok(ro) = hkcu().open_subkey_with_flags(RUN_ONCE, KEY_SET_VALUE) {
                let _ = ro.delete_value(RUN_ONCE_NAME);
            }
        }
    }
    fn sp(url: &str) -> SystemProxy {
        let s = SystemProxy::new(url, false).unwrap();
        s.watchdog.call_once(|| {}); // no watchdog process from tests
        s
    }

    #[test]
    fn takes_over_an_earlier_copys_address_and_puts_it_back() {
        let _g = lock(&crate::TEST_LOCK);
        let _p = Preserve(read_auto_config_url());
        // An earlier copy on another port left its address behind.
        set_auto_config_url(Some("http://127.0.0.1:1055/proxy.pac?v=7")).unwrap();
        let s = sp("http://127.0.0.1:49768/proxy.pac?v=1");
        s.enable().unwrap();
        assert_eq!(read_auto_config_url(), "http://127.0.0.1:49768/proxy.pac?v=1");
        // Something clears it: it's put back once...
        set_auto_config_url(None).unwrap();
        s.verify().unwrap();
        assert_eq!(read_auto_config_url(), "http://127.0.0.1:49768/proxy.pac?v=1");
        // ...but not again straight away.
        set_auto_config_url(None).unwrap();
        assert_eq!(s.verify(), Err(ProxyError::Changed));
        assert_eq!(read_auto_config_url(), "");
        // Someone else's script is left alone.
        set_auto_config_url(Some(CORP)).unwrap();
        let s = sp(V1);
        assert_eq!(s.enable(), Err(ProxyError::Taken(CORP.into())));
        assert_eq!(read_auto_config_url(), CORP);
    }

    #[test]
    fn registry_lifecycle() {
        let _g = lock(&crate::TEST_LOCK);
        let _p = Preserve(read_auto_config_url());
        set_auto_config_url(Some(CORP)).unwrap();
        let s = sp(V1);
        s.enable().unwrap();
        assert_eq!(read_auto_config_url(), V1);
        s.update(V2).unwrap();
        assert_eq!(read_auto_config_url(), V2);
        s.disable();
        assert_eq!(read_auto_config_url(), CORP, "company script restored");
        assert!(hkcu().open_subkey(STATE_KEY).is_err(), "state removed");

        // Crash: owner alive -> untouched; owner dead -> restored.
        let s = sp(V1);
        s.enable().unwrap();
        cleanup_stale();
        assert_eq!(read_auto_config_url(), V1);
        hkcu()
            .open_subkey_with_flags(STATE_KEY, KEY_SET_VALUE)
            .unwrap()
            .set_value("OwnerPID", &0xFFFF_FFF0u32)
            .unwrap();
        cleanup_stale();
        assert_eq!(read_auto_config_url(), CORP);

        // A foreign watchdog leaves it alone.
        let s = sp(V1);
        s.enable().unwrap();
        restore_proxy_state(std::process::id() + 1);
        assert_eq!(read_auto_config_url(), V1);
        restore_proxy_state(std::process::id());
        assert_eq!(read_auto_config_url(), CORP);
    }
}
