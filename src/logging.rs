//! Logs to tailnet-link.log in the config folder (a windowed app has no
//! console), keeping one old file. Panics are written there too, with a
//! backtrace, so a crash always leaves its reason behind. On Windows, a
//! windowed start has no stderr, so stderr is pointed at the log file too:
//! otherwise a crash inside libtailscale (Go prints its panics to stderr) would
//! end the app without a trace.

use crate::sync::lock;
use std::io::Write;
use std::sync::Mutex;
use std::time::{SystemTime, UNIX_EPOCH};

struct FileLogger {
    file: Mutex<Option<std::fs::File>>,
    /// Also copy each line to stderr (not when stderr is the log file itself).
    echo_stderr: bool,
}

impl log::Log for FileLogger {
    fn enabled(&self, m: &log::Metadata<'_>) -> bool {
        m.level() <= log::Level::Info || m.target().starts_with("tailnet_link")
    }

    fn log(&self, r: &log::Record<'_>) {
        if !self.enabled(r.metadata()) || !r.target().starts_with("tailnet_link") && r.level() > log::Level::Warn {
            return;
        }
        let line = format!("{} {:5} {}\n", timestamp(), r.level(), r.args());
        if let Some(f) = lock(&self.file).as_mut() {
            let _ = f.write_all(line.as_bytes());
        }
        if self.echo_stderr {
            let _ = std::io::stderr().write_all(line.as_bytes());
        }
    }

    fn flush(&self) {
        if let Some(f) = lock(&self.file).as_mut() {
            let _ = f.flush();
        }
    }
}

/// UTC "YYYY-MM-DD HH:MM:SS" without pulling in a date library.
pub fn timestamp() -> String {
    let secs = SystemTime::now().duration_since(UNIX_EPOCH).map_or(0, |d| d.as_secs()) as i64;
    let (days, rem) = (secs.div_euclid(86_400), secs.rem_euclid(86_400));
    // Civil-from-days (Howard Hinnant).
    let z = days + 719_468;
    let era = z.div_euclid(146_097);
    let doe = z - era * 146_097;
    let yoe = (doe - doe / 1460 + doe / 36_524 - doe / 146_096) / 365;
    let doy = doe - (365 * yoe + yoe / 4 - yoe / 100);
    let mp = (5 * doy + 2) / 153;
    let d = doy - (153 * mp + 2) / 5 + 1;
    let m = if mp < 10 { mp + 3 } else { mp - 9 };
    let y = yoe + era * 400 + i64::from(m <= 2);
    format!("{y:04}-{m:02}-{d:02} {:02}:{:02}:{:02}Z", rem / 3600, rem % 3600 / 60, rem % 60)
}

pub fn init() {
    let dir = crate::config::config_dir();
    let _ = std::fs::create_dir_all(&dir);
    let path = crate::config::log_path();
    if std::fs::metadata(&path).is_ok_and(|m| m.len() > 2 << 20) {
        let _ = std::fs::rename(&path, path.with_extension("log.old"));
    }
    let file = std::fs::OpenOptions::new().create(true).append(true).open(&path).ok();
    let stderr_is_log = capture_stderr(&path);
    let logger: &'static FileLogger =
        Box::leak(Box::new(FileLogger { file: Mutex::new(file), echo_stderr: !stderr_is_log }));
    if log::set_logger(logger).is_ok() {
        log::set_max_level(log::LevelFilter::Info);
    }

    let default = std::panic::take_hook();
    std::panic::set_hook(Box::new(move |info| {
        let bt = std::backtrace::Backtrace::force_capture();
        log::error!("CRASH: {info}\n{bt}");
        log::logger().flush();
        default(info);
    }));
}

/// If this process has no stderr (a windowed app started normally), makes the
/// log file its stderr, so whatever native code prints there (notably the Go
/// runtime's panic messages, which bypass Rust's panic hook) is kept. Leaves a
/// real stderr (console, redirect) alone. Returns true if stderr is now the log.
#[cfg(windows)]
fn capture_stderr(path: &std::path::Path) -> bool {
    use std::os::windows::io::IntoRawHandle;
    use windows_sys::Win32::Foundation::INVALID_HANDLE_VALUE;
    use windows_sys::Win32::System::Console::{GetStdHandle, STD_ERROR_HANDLE, SetStdHandle};

    // SAFETY: reads a process-wide handle; no pointers involved.
    let current = unsafe { GetStdHandle(STD_ERROR_HANDLE) };
    if !current.is_null() && current != INVALID_HANDLE_VALUE {
        return false;
    }
    let Ok(f) = std::fs::OpenOptions::new().create(true).append(true).open(path) else {
        return false;
    };
    // The handle is deliberately leaked: it's stderr for the rest of the process.
    let h = f.into_raw_handle();
    // SAFETY: `h` is an open file handle we own and never close.
    unsafe { SetStdHandle(STD_ERROR_HANDLE, h.cast()) != 0 }
}

#[cfg(not(windows))]
fn capture_stderr(_path: &std::path::Path) -> bool {
    false
}

#[cfg(test)]
mod tests {
    #[test]
    fn timestamp_shape() {
        let t = super::timestamp();
        assert_eq!(t.len(), 20, "{t}");
        assert!(t.starts_with("20") && t.ends_with('Z'));
    }
}
