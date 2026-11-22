//! The system proxy setting ("use this setup script"), managed so that it is
//! ONLY on while the app is running and routing:
//!
//! - enable / pause follow the connection,
//! - quit calls disable,
//! - crash or kill: a detached watchdog (this program with --watchdog-pid)
//!   waits for the app to exit, then restores,
//! - power cut: a login item runs "--cleanup" at next login, and every start
//!   of the app cleans up leftovers.
//!
//! Cleanup only touches the setting if it is still ours, puts back whatever
//! was there before, and never acts while the owning process is alive.

#[cfg(windows)]
mod windows;
#[cfg(windows)]
pub use self::windows::*;

#[cfg(unix)]
pub mod backend;
#[cfg(unix)]
mod unix;
#[cfg(unix)]
pub use self::unix::*;

/// Why the system proxy setting doesn't point at this app.
#[derive(Clone, Debug, PartialEq, Eq)]
pub enum ProxyError {
    /// Another program's setup script is in place (its address), and the
    /// user hasn't chosen to replace it.
    Taken(String),
    /// Another running copy of Tailnet Link has the setting.
    OtherCopy,
    /// Something else changed the setting after we set it. Not put back
    /// automatically, so we don't fight it (or ask for a password over and over).
    Changed,
    /// Changing the setting failed.
    Failed(String),
}

/// Whether we may point the setting at `ours` while it's `cur`.
/// `other_copy_running`: the recorded owner is another live copy of this app.
fn may_take(cur: &str, ours: &str, force: bool, other_copy_running: impl FnOnce() -> bool) -> Result<(), ProxyError> {
    if cur.is_empty() || crate::proxy::is_our_pac(cur, ours) {
        Ok(())
    } else if crate::proxy::is_tailnet_link_pac(cur) {
        // An earlier copy's address on another port: take it over once that copy is gone.
        if other_copy_running() { Err(ProxyError::OtherCopy) } else { Ok(()) }
    } else if force {
        Ok(())
    } else {
        Err(ProxyError::Taken(cur.to_owned()))
    }
}

/// How soon after putting the setting back we stop doing it automatically.
const REAPPLY_GAP: std::time::Duration = std::time::Duration::from_secs(60);

/// Starts a detached copy of this program that outlives us and restores the
/// proxy setting the moment we exit for any reason.
pub fn start_watchdog() -> std::io::Result<()> {
    let exe = std::env::current_exe()?;
    let mut cmd = std::process::Command::new(exe);
    cmd.arg("--watchdog-pid").arg(std::process::id().to_string());
    cmd.stdin(std::process::Stdio::null()).stdout(std::process::Stdio::null()).stderr(std::process::Stdio::null());
    #[cfg(windows)]
    {
        use std::os::windows::process::CommandExt;
        const DETACHED_PROCESS: u32 = 0x0000_0008;
        const CREATE_NEW_PROCESS_GROUP: u32 = 0x0000_0200;
        cmd.creation_flags(DETACHED_PROCESS | CREATE_NEW_PROCESS_GROUP);
    }
    #[cfg(unix)]
    {
        use std::os::unix::process::CommandExt;
        cmd.process_group(0); // not killed with our process group
    }
    cmd.spawn().map(|_| ())
}

/// The hidden --watchdog-pid mode: wait for the app to exit, then undo its
/// proxy setting if it didn't get the chance.
pub fn run_watchdog(pid: u32) {
    wait_for_exit(pid);
    restore_proxy_state(pid);
}
