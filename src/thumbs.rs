//! Pictures of the starred websites, for their large tiles.
//!
//! A browser already on this computer (Edge, Chrome, Chromium or Brave) opens
//! the page headless, with no window, in a throwaway profile, and saves a
//! screenshot. It goes only through the app's own proxy, which refuses every
//! name outside the routing tailnets, so the page can't reach anything else
//! (anything it loads from the internet is simply missing from the picture).
//! The profile holds no sign-ins, so a site that needs one shows its sign-in page.
//!
//! Each picture is kept in the `thumbs` folder and taken again once a day.

use std::collections::HashMap;
use std::path::{Path, PathBuf};
use std::process::{Command, Stdio};
use std::sync::Arc;
use std::time::{Duration, Instant};

use crate::config;
use crate::sites::Icon;

/// How big the page is drawn.
const PAGE_SIZE: (u32, u32) = (1280, 800);
/// The picture is scaled down to this width (the height keeps the page's shape).
pub const WIDTH: u32 = 480;
/// A picture this old is taken again.
pub const RETAKE_AFTER: Duration = Duration::from_hours(24);
/// A site whose picture couldn't be taken is tried again after this.
const RETRY_AFTER: Duration = Duration::from_hours(1);
/// The browser gets this long to load the page and save the picture.
const TIMEOUT: Duration = Duration::from_secs(45);
/// How long the page may load (in the page's own time) before the picture.
const LOAD_BUDGET_MS: u32 = 8000;

/// The pictures in memory, and when each site was last tried.
#[derive(Default)]
pub struct Thumbs {
    pictures: HashMap<String, Arc<Icon>>,
    tried: HashMap<String, Instant>,
    /// The browser used, once looked for (`None` inside: there isn't one).
    browser: std::cell::OnceCell<Option<PathBuf>>,
}

impl Thumbs {
    /// The pictures saved earlier, for these sites.
    pub fn load(hosts: &[String]) -> Thumbs {
        let mut t = Thumbs::default();
        for h in hosts {
            if let Some(p) = read_picture(&file(h)) {
                t.pictures.insert(h.clone(), Arc::new(p));
            }
        }
        t
    }

    pub fn picture(&self, host: &str) -> Option<Arc<Icon>> {
        self.pictures.get(host).cloned()
    }

    /// The picture is missing or old, and the site wasn't tried just now.
    pub fn is_due(&self, host: &str) -> bool {
        if self.tried.get(host).is_some_and(|t| t.elapsed() < RETRY_AFTER) {
            return false;
        }
        let age = std::fs::metadata(file(host)).and_then(|m| m.modified()).ok().and_then(|m| m.elapsed().ok());
        age.is_none_or(|a| a >= RETAKE_AFTER)
    }

    /// The browser to use, looked for once.
    pub fn browser(&mut self) -> Option<PathBuf> {
        self.browser
            .get_or_init(|| {
                let b = find_browser();
                match &b {
                    Some(p) => log::info!("[thumbs] using {}", p.display()),
                    None => log::info!("[thumbs] no Edge, Chrome, Chromium or Brave found: no website pictures"),
                }
                b
            })
            .clone()
    }

    pub fn tried(&mut self, host: &str) {
        self.tried.insert(host.to_owned(), Instant::now());
    }

    pub fn store(&mut self, host: &str, picture: Icon) {
        // Keep the same Arc when nothing changed, so the UI keeps its texture.
        if self.pictures.get(host).is_none_or(|old| **old != picture) {
            self.pictures.insert(host.to_owned(), Arc::new(picture));
        }
    }

    /// Drops the pictures of sites that aren't starred any more.
    pub fn keep_only(&mut self, hosts: &[String]) {
        let gone: Vec<String> = self.pictures.keys().filter(|h| !hosts.contains(h)).cloned().collect();
        for h in gone {
            self.pictures.remove(&h);
            let _ = std::fs::remove_file(file(&h));
        }
    }
}

fn dir() -> PathBuf {
    config::config_dir().join("thumbs")
}

/// The saved picture of a site. Host names are letters, digits, dots and hyphens.
fn file(host: &str) -> PathBuf {
    dir().join(format!("{}.png", config::sanitize(host)))
}

fn read_picture(path: &Path) -> Option<Icon> {
    let img = image::open(path).ok()?.to_rgba8();
    Some(Icon { size: [img.width() as usize, img.height() as usize], rgba: img.into_raw() })
}

/// Opens `url` in `browser`, headless and through `proxy` (host:port), saves
/// a scaled-down picture of it, and returns it. Blocks for up to [`TIMEOUT`].
pub fn take(browser: &Path, proxy: &str, host: &str, url: &str) -> Result<Icon, String> {
    let work = std::env::temp_dir().join(format!("tailnet-link-thumb-{}", rand::random::<u64>()));
    std::fs::create_dir_all(&work).map_err(|e| format!("creating {}: {e}", work.display()))?;
    let shot = work.join("page.png");
    let res = run_browser(browser, proxy, url, &work, &shot).and_then(|()| {
        let img = image::open(&shot).map_err(|e| format!("reading the screenshot: {e}"))?;
        let h = WIDTH * img.height() / img.width().max(1);
        let img = img.resize_exact(WIDTH, h.max(1), image::imageops::FilterType::Triangle).to_rgba8();
        std::fs::create_dir_all(dir()).map_err(|e| format!("creating {}: {e}", dir().display()))?;
        let out = file(host);
        img.save_with_format(&out, image::ImageFormat::Png).map_err(|e| format!("saving {}: {e}", out.display()))?;
        Ok(Icon { size: [img.width() as usize, img.height() as usize], rgba: img.into_raw() })
    });
    // The browser may still be letting go of its profile.
    for _ in 0..10 {
        if std::fs::remove_dir_all(&work).is_ok() || !work.exists() {
            break;
        }
        std::thread::sleep(Duration::from_millis(300));
    }
    res
}

fn run_browser(browser: &Path, proxy: &str, url: &str, profile: &Path, shot: &Path) -> Result<(), String> {
    let mut cmd = Command::new(browser);
    cmd.args([
        "--headless=new",
        "--disable-gpu",
        "--hide-scrollbars",
        "--mute-audio",
        "--no-first-run",
        "--no-default-browser-check",
        "--disable-extensions",
        "--disable-sync",
        "--disable-background-networking",
        "--disable-component-update",
        "--disable-default-apps",
        // Self-signed certificates are common on home servers. The page only
        // becomes a picture, in a profile that's thrown away.
        "--ignore-certificate-errors",
    ])
    .arg(format!("--user-data-dir={}", profile.display()))
    .arg(format!("--proxy-server=http://{proxy}"))
    // Everything through the proxy, even names Chrome would otherwise send direct.
    .arg("--proxy-bypass-list=<-loopback>")
    .arg(format!("--window-size={},{}", PAGE_SIZE.0, PAGE_SIZE.1))
    .arg(format!("--virtual-time-budget={LOAD_BUDGET_MS}"))
    .arg(format!("--screenshot={}", shot.display()))
    .arg(url)
    .stdin(Stdio::null())
    .stdout(Stdio::null())
    .stderr(Stdio::null());
    #[cfg(windows)]
    {
        use std::os::windows::process::CommandExt as _;
        const CREATE_NO_WINDOW: u32 = 0x0800_0000;
        cmd.creation_flags(CREATE_NO_WINDOW);
    }
    let mut child = cmd.spawn().map_err(|e| format!("starting {}: {e}", browser.display()))?;
    let started = Instant::now();
    loop {
        match child.try_wait() {
            Ok(Some(_)) => break,
            Ok(None) if started.elapsed() > TIMEOUT => {
                let _ = child.kill();
                let _ = child.wait();
                return Err(format!("the page took longer than {}s", TIMEOUT.as_secs()));
            }
            Ok(None) => std::thread::sleep(Duration::from_millis(250)),
            Err(e) => return Err(format!("waiting for the browser: {e}")),
        }
    }
    if shot.exists() { Ok(()) } else { Err("the browser saved no screenshot".into()) }
}

/// A Chromium-based browser on this computer, which can take screenshots headless.
fn find_browser() -> Option<PathBuf> {
    candidates().into_iter().find(|p| p.is_file())
}

#[cfg(windows)]
fn candidates() -> Vec<PathBuf> {
    let roots: Vec<PathBuf> = ["ProgramFiles(x86)", "ProgramFiles", "LocalAppData"]
        .iter()
        .filter_map(|v| std::env::var_os(v).map(PathBuf::from))
        .collect();
    let apps = [
        r"Microsoft\Edge\Application\msedge.exe",
        r"Google\Chrome\Application\chrome.exe",
        r"Chromium\Application\chrome.exe",
        r"BraveSoftware\Brave-Browser\Application\brave.exe",
    ];
    apps.iter().flat_map(|a| roots.iter().map(move |r| r.join(a))).collect()
}

#[cfg(target_os = "macos")]
fn candidates() -> Vec<PathBuf> {
    let mut roots = vec![PathBuf::from("/Applications")];
    if let Some(home) = dirs::home_dir() {
        roots.push(home.join("Applications"));
    }
    let apps = [
        "Google Chrome.app/Contents/MacOS/Google Chrome",
        "Microsoft Edge.app/Contents/MacOS/Microsoft Edge",
        "Chromium.app/Contents/MacOS/Chromium",
        "Brave Browser.app/Contents/MacOS/Brave Browser",
    ];
    apps.iter().flat_map(|a| roots.iter().map(move |r| r.join(a))).collect()
}

#[cfg(not(any(windows, target_os = "macos")))]
fn candidates() -> Vec<PathBuf> {
    let names =
        ["google-chrome", "google-chrome-stable", "chromium", "chromium-browser", "microsoft-edge", "brave-browser"];
    let path = std::env::var_os("PATH").unwrap_or_default();
    names.iter().flat_map(|n| std::env::split_paths(&path).map(move |d| d.join(n))).collect()
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn pictures_are_kept_per_starred_site() {
        let (_g, _d) = crate::core::tests::test_dir();
        let host = "wiki.example.ts.net";
        let mut t = Thumbs::default();
        assert!(t.is_due(host), "no picture yet");
        // A picture saved by an earlier run loads, and isn't due again today.
        std::fs::create_dir_all(dir()).unwrap();
        image::RgbaImage::from_pixel(48, 30, image::Rgba([1, 2, 3, 255])).save(file(host)).unwrap();
        let t2 = Thumbs::load(&[host.to_owned()]);
        assert_eq!(t2.picture(host).unwrap().size, [48, 30]);
        assert!(!t2.is_due(host));
        // A failed try waits before the next one.
        t.tried("other.example.ts.net");
        assert!(!t.is_due("other.example.ts.net"));
        // Unstarred: forgotten, file and all.
        let mut t2 = t2;
        t2.keep_only(&[]);
        assert!(t2.picture(host).is_none() && !file(host).exists());
    }

    /// Takes a real picture of a local page when a browser is installed.
    #[test]
    fn real_browser_screenshot() {
        let Some(browser) = find_browser() else { return };
        let (_g, _d) = crate::core::tests::test_dir();
        let page = std::env::temp_dir().join(format!("tl-thumb-{}.html", rand::random::<u64>()));
        std::fs::write(&page, "<html><body style='background:#c00'><h1>Hello</h1></body></html>").unwrap();
        let url = format!("file:///{}", page.display().to_string().replace('\\', "/"));
        // No proxy is listening there; a file:// page doesn't need one.
        let pic = take(&browser, "127.0.0.1:9", "local.test", &url).expect("screenshot");
        assert_eq!(pic.size[0], WIDTH as usize);
        // Mostly red.
        let px = &pic.rgba[(pic.size[0] * pic.size[1] / 2) * 4..][..4];
        assert!(px[0] > 150 && px[1] < 80, "{px:?}");
        let _ = std::fs::remove_file(page);
    }
}
