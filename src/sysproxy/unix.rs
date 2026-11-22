//! macOS / Linux manager. What to restore and which process owns it live in
//! proxy-state.json in the config folder.

use super::ProxyError;
use super::backend::{DesktopBackend, MacBackend, PacBackend};
use crate::config::config_dir;
use crate::proxy::{is_our_pac, is_tailnet_link_pac};
use crate::sync::lock;
use serde::{Deserialize, Serialize};
use std::path::PathBuf;
use std::sync::atomic::{AtomicBool, Ordering};
use std::sync::{Arc, Mutex, Once};
use std::time::Instant;

#[derive(Serialize, Deserialize, Default)]
struct State {
    active: String,
    owner_pid: u32,
    backend: String,
    prev: serde_json::Value,
}

fn state_path() -> PathBuf {
    config_dir().join("proxy-state.json")
}

fn read_state() -> Option<State> {
    serde_json::from_str(&std::fs::read_to_string(state_path()).ok()?).ok()
}

fn write_state(st: &State) -> Result<(), String> {
    std::fs::create_dir_all(config_dir()).map_err(|e| e.to_string())?;
    let tmp = state_path().with_extension("json.tmp");
    let json = serde_json::to_string_pretty(st).map_err(|e| e.to_string())?;
    std::fs::write(&tmp, json).map_err(|e| e.to_string())?;
    std::fs::rename(tmp, state_path()).map_err(|e| e.to_string())
}

type BackendFactory = Box<dyn Fn() -> Result<Arc<dyn PacBackend>, String> + Send + Sync>;
static FACTORY: Mutex<Option<BackendFactory>> = Mutex::new(None);

fn new_backend() -> Result<Arc<dyn PacBackend>, String> {
    if let Some(f) = lock(&FACTORY).as_ref() {
        return f();
    }
    if cfg!(target_os = "macos") { Ok(Arc::new(MacBackend::new())) } else { Ok(Arc::new(DesktopBackend::new()?)) }
}

pub struct SystemProxy {
    be: Arc<dyn PacBackend>,
    pac_url: Mutex<String>,
    on: Mutex<bool>,
    force: AtomicBool,
    watchdog: Once,
    /// When the setting was last put back after something else changed it.
    reapplied: Mutex<Option<Instant>>,
}

/// The copy of the app recorded as owning the setting, if it's another one that's still running.
fn other_copy_running() -> bool {
    read_state()
        .is_some_and(|st| st.owner_pid != 0 && st.owner_pid != std::process::id() && process_alive(st.owner_pid))
}

impl SystemProxy {
    /// `force`: replace another program's setup script while running.
    pub fn new(pac_url: &str, force: bool) -> Result<SystemProxy, String> {
        let s = Self::with_backend(new_backend()?, pac_url);
        s.set_force(force);
        Ok(s)
    }

    fn with_backend(be: Arc<dyn PacBackend>, pac_url: &str) -> Self {
        let s = SystemProxy {
            be,
            pac_url: Mutex::new(pac_url.into()),
            on: Mutex::new(false),
            force: AtomicBool::new(false),
            watchdog: Once::new(),
            reapplied: Mutex::new(None),
        };
        #[cfg(test)]
        s.watchdog.call_once(|| {}); // no watchdog process from tests
        s
    }

    pub fn set_force(&self, force: bool) {
        self.force.store(force, Ordering::SeqCst);
    }

    pub fn is_on(&self) -> bool {
        *lock(&self.on)
    }

    /// The setting as it is now ("" when there's none or it can't be read).
    pub fn current(&self) -> String {
        self.be.current().unwrap_or_default()
    }

    /// Points the setting at us, unless another program's script is there.
    pub fn enable(&self) -> Result<(), ProxyError> {
        let mut on = lock(&self.on);
        if *on {
            return Ok(());
        }
        let url = lock(&self.pac_url).clone();
        let cur = self.be.current().map_err(ProxyError::Failed)?;
        super::may_take(&cur, &url, self.force.load(Ordering::SeqCst), other_copy_running)?;
        self.watchdog.call_once(|| {
            if let Err(e) = super::start_watchdog() {
                log::warn!(
                    "crash watchdog not started ({e}); a crash would leave the proxy setting on until next login"
                );
            }
        });
        // 1. Record how to undo it (and who owns it) before changing anything.
        let mut st = match read_state() {
            Some(st) => st,
            None if is_tailnet_link_pac(&cur) => State::default(), // an earlier copy's: never put back
            None => State {
                prev: self
                    .be
                    .snapshot()
                    .map_err(|e| ProxyError::Failed(format!("reading current proxy setting: {e}")))?,
                ..Default::default()
            },
        };
        st.active.clone_from(&url);
        st.owner_pid = std::process::id();
        st.backend = self.be.name().into();
        write_state(&st).map_err(|e| ProxyError::Failed(format!("saving proxy state: {e}")))?;
        // 2. Clean up at next login if everything else fails.
        if let Ok(exe) = std::env::current_exe()
            && let Err(e) = self.be.install_cleanup(&exe.to_string_lossy())
        {
            log::warn!("login cleanup not installed: {e}");
        }
        // 3. Turn it on.
        if let Err(e) = self.be.apply(&url) {
            restore_with(&*self.be, std::process::id()); // don't leave it half-applied
            return Err(ProxyError::Failed(e));
        }
        if !is_our_pac(&cur, &url) {
            log::info!("System proxy setting now points at {url} (was {cur:?})");
        }
        *on = true;
        Ok(())
    }

    /// Checks that the setting still points at us. If something cleared it,
    /// puts it back, but only once a minute, and never where that needs a
    /// password (it would ask over and over).
    pub fn verify(&self) -> Result<(), ProxyError> {
        if !*lock(&self.on) {
            return Ok(());
        }
        let url = lock(&self.pac_url).clone();
        let Ok(cur) = self.be.current() else { return Ok(()) }; // can't tell; assume fine
        if is_our_pac(&cur, &url) {
            return Ok(());
        }
        log::warn!("System proxy setting was changed by something else (now {cur:?})");
        *lock(&self.on) = false;
        // Forget our record (and the login cleanup) without touching their setting.
        restore_with(&*self.be, std::process::id());
        let mut last = lock(&self.reapplied);
        if self.be.privileged() || last.is_some_and(|t| t.elapsed() < super::REAPPLY_GAP) {
            return Err(ProxyError::Changed);
        }
        super::may_take(&cur, &url, self.force.load(Ordering::SeqCst), other_copy_running)?;
        *last = Some(Instant::now());
        drop(last);
        self.enable()?;
        log::info!("System proxy setting put back.");
        Ok(())
    }

    pub fn update(&self, pac_url: &str) -> Result<(), String> {
        *lock(&self.pac_url) = pac_url.into();
        if !*lock(&self.on) {
            return Ok(());
        }
        if let Some(mut st) = read_state() {
            st.active = pac_url.into();
            let _ = write_state(&st);
        }
        self.be.apply(pac_url)
    }

    /// Routing stopped but the app keeps running. Where changing the setting
    /// needs a password, leave it (the PAC serves all-direct) to avoid a
    /// prompt on every disconnect.
    pub fn pause(&self) {
        if !self.be.privileged() {
            self.disable();
        }
    }

    pub fn disable(&self) {
        let mut on = lock(&self.on);
        if !*on {
            return;
        }
        restore_with(&*self.be, std::process::id());
        *on = false;
    }
}

/// Undoes our change if still in place. owner != 0: only for that owner.
/// owner == 0 (startup / login cleanup): only if the recorded owner is gone.
pub fn restore_proxy_state(owner: u32) {
    if read_state().is_none() {
        return;
    }
    if let Ok(be) = new_backend() {
        restore_with(&*be, owner);
    }
}

fn restore_with(be: &dyn PacBackend, owner: u32) {
    let Some(st) = read_state() else { return };
    if owner != 0 && st.owner_pid != owner {
        return; // another run owns it now
    }
    if owner == 0 && st.owner_pid != 0 && process_alive(st.owner_pid) {
        return; // still running; leave it alone
    }
    if let Ok(cur) = be.current()
        && is_our_pac(&cur, &st.active)
    {
        if let Err(e) = be.restore(&st.prev) {
            log::warn!("restoring proxy setting: {e}");
            return; // keep the state so a later cleanup can retry
        }
        log::info!("System proxy setting turned off.");
    }
    let _ = std::fs::remove_file(state_path());
    be.remove_cleanup();
}

pub fn cleanup_stale() {
    restore_proxy_state(0);
}

pub fn process_alive(pid: u32) -> bool {
    // SAFETY: signal 0 only checks that the process exists; nothing is delivered.
    let r = unsafe { libc::kill(pid as libc::pid_t, 0) };
    r == 0 || std::io::Error::last_os_error().raw_os_error() == Some(libc::EPERM)
}

pub fn wait_for_exit(pid: u32) {
    while process_alive(pid) {
        std::thread::sleep(std::time::Duration::from_secs(1));
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use std::sync::Mutex as StdMutex;

    /// A fake system proxy setting.
    #[derive(Default)]
    struct Mem {
        url: StdMutex<String>,
        privileged: bool,
        cleanup: StdMutex<bool>,
    }
    impl PacBackend for Mem {
        fn name(&self) -> &'static str {
            "mem"
        }
        fn current(&self) -> Result<String, String> {
            Ok(lock(&self.url).clone())
        }
        fn snapshot(&self) -> Result<serde_json::Value, String> {
            Ok(lock(&self.url).clone().into())
        }
        fn apply(&self, u: &str) -> Result<(), String> {
            *lock(&self.url) = u.into();
            Ok(())
        }
        fn restore(&self, prev: &serde_json::Value) -> Result<(), String> {
            *lock(&self.url) = prev.as_str().unwrap_or("").into();
            Ok(())
        }
        fn privileged(&self) -> bool {
            self.privileged
        }
        fn install_cleanup(&self, _: &str) -> Result<(), String> {
            *lock(&self.cleanup) = true;
            Ok(())
        }
        fn remove_cleanup(&self) {
            *lock(&self.cleanup) = false;
        }
    }

    const CORP: &str = "http://corp.example/proxy.pac";
    const V1: &str = "http://127.0.0.1:1055/proxy.pac?v=1";
    const V2: &str = "http://127.0.0.1:1055/proxy.pac?v=2";
    const V2_OTHER_PORT: &str = "http://127.0.0.1:49768/proxy.pac?v=2";

    fn setup(start: &str, privileged: bool) -> (std::sync::MutexGuard<'static, ()>, Arc<Mem>, tempdir::Dir) {
        let g = lock(&crate::TEST_LOCK);
        let dir = tempdir::Dir::new();
        // SAFETY: tests that read or change the environment hold TEST_LOCK.
        unsafe { std::env::set_var("TAILNET_LINK_CONFIG_DIR", &dir.0) };
        let m = Arc::new(Mem { url: StdMutex::new(start.into()), privileged, ..Default::default() });
        let m2 = m.clone();
        *lock(&FACTORY) = Some(Box::new(move || Ok(m2.clone() as Arc<dyn PacBackend>)));
        (g, m, dir)
    }

    mod tempdir {
        pub struct Dir(pub std::path::PathBuf);
        impl Dir {
            pub fn new() -> Self {
                let p = std::env::temp_dir().join(format!("tp-test-{}", rand::random::<u64>()));
                std::fs::create_dir_all(&p).unwrap();
                Dir(p)
            }
        }
        impl Drop for Dir {
            fn drop(&mut self) {
                let _ = std::fs::remove_dir_all(&self.0);
            }
        }
    }

    #[test]
    fn enable_update_disable() {
        let (_g, m, _d) = setup(CORP, false);
        let s = SystemProxy::with_backend(m.clone(), V1);
        s.set_force(true); // "Replace it", so the company script is set aside and restored
        s.enable().unwrap();
        assert_eq!(*lock(&m.url), V1);
        assert!(*lock(&m.cleanup));
        s.update(V2).unwrap();
        assert_eq!(*lock(&m.url), V2);
        s.disable();
        assert_eq!(*lock(&m.url), CORP, "previous script restored");
        assert!(!*lock(&m.cleanup));
        assert!(!state_path().exists());
    }

    #[test]
    fn crash_cleanup_and_owners() {
        let (_g, m, _d) = setup("", false);
        let s = SystemProxy::with_backend(m.clone(), V1);
        s.enable().unwrap();
        cleanup_stale(); // owner (us) alive
        assert_eq!(*lock(&m.url), V1);
        restore_proxy_state(std::process::id() + 1); // foreign watchdog
        assert_eq!(*lock(&m.url), V1);
        let mut st = read_state().unwrap();
        st.owner_pid = 0x7fff_fff0; // a process that doesn't exist
        write_state(&st).unwrap();
        cleanup_stale();
        assert_eq!(*lock(&m.url), "");
    }

    #[test]
    fn privileged_pause_keeps_setting() {
        let (_g, m, _d) = setup("", true);
        let s = SystemProxy::with_backend(m.clone(), V1);
        s.enable().unwrap();
        s.pause();
        assert_eq!(*lock(&m.url), V1);
        s.disable();
        assert_eq!(*lock(&m.url), "");
    }

    #[test]
    fn takes_over_an_earlier_copys_address_and_puts_it_back() {
        let (_g, m, _d) = setup("http://127.0.0.1:1055/proxy.pac?v=7", false);
        let s = SystemProxy::with_backend(m.clone(), V2_OTHER_PORT);
        s.enable().unwrap();
        assert_eq!(*lock(&m.url), V2_OTHER_PORT);
        *lock(&m.url) = String::new(); // something clears it
        s.verify().unwrap();
        assert_eq!(*lock(&m.url), V2_OTHER_PORT, "put back once");
        *lock(&m.url) = String::new();
        assert_eq!(s.verify(), Err(ProxyError::Changed), "not again straight away");
        assert_eq!(*lock(&m.url), "");
        // Quitting puts back nothing: the earlier copy's address was never ours to restore.
        s.enable().unwrap();
        s.disable();
        assert_eq!(*lock(&m.url), "");
    }

    #[test]
    fn refuses_someone_elses_script_unless_forced() {
        let (_g, m, _d) = setup(CORP, false);
        let s = SystemProxy::with_backend(m.clone(), V1);
        assert_eq!(s.enable(), Err(ProxyError::Taken(CORP.into())));
        assert_eq!(*lock(&m.url), CORP);
        s.set_force(true);
        s.enable().unwrap();
        assert_eq!(*lock(&m.url), V1);
        s.disable();
        assert_eq!(*lock(&m.url), CORP);
    }

    #[test]
    fn privileged_change_is_not_put_back() {
        let (_g, m, _d) = setup("", true);
        let s = SystemProxy::with_backend(m.clone(), V1);
        s.enable().unwrap();
        *lock(&m.url) = String::new();
        assert_eq!(s.verify(), Err(ProxyError::Changed));
        assert_eq!(*lock(&m.url), "");
    }

    #[test]
    fn leaves_someone_elses_change_alone() {
        let (_g, m, _d) = setup("", false);
        let s = SystemProxy::with_backend(m.clone(), V1);
        s.enable().unwrap();
        *lock(&m.url) = "http://someone-else/x.pac".into();
        s.disable();
        assert_eq!(*lock(&m.url), "http://someone-else/x.pac");
    }
}
