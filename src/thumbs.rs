//! Pictures of the starred websites, for their large tiles.
//!
//! A browser already on this computer (Edge, Chrome, Chromium or Brave) opens
//! the page headless, with no window, in a throwaway profile, and takes a
//! screenshot when asked over DevTools: once the page has loaded and gone
//! quiet (it has stopped asking for things, apart from requests that stay open
//! for live updates, which never end), or after a while if it doesn't.
//!
//! It goes only through the app's own proxy, which refuses every
//! name outside the routing tailnets, so the page can't reach anything else
//! (anything it loads from the internet is simply missing from the picture).
//! The profile holds no sign-ins, so a site that needs one shows its sign-in page.
//!
//! Each picture is kept in the `thumbs` folder and taken again once a day.

use std::collections::HashMap;
use std::net::{SocketAddr, TcpStream};
use std::path::{Path, PathBuf};
use std::process::{Child, Command, Stdio};
use std::sync::Arc;
use std::time::{Duration, Instant};

use base64::Engine as _;
use serde_json::{Value, json};
use tungstenite::Message;

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
/// The browser gets this long to start, load the page and take the picture.
const TIMEOUT: Duration = Duration::from_secs(60);
/// How long the browser gets to start and say where DevTools is.
const START_WAIT: Duration = Duration::from_secs(20);
/// How long the page may take to load before its picture is taken anyway.
const LOAD_WAIT: Duration = Duration::from_secs(15);
/// After loading, how long a page may keep asking for things (many fetch what
/// they show only once they've loaded) before its picture is taken anyway.
const SETTLE_WAIT: Duration = Duration::from_secs(10);
/// A page that has started and finished no request for this long is done.
const QUIET: Duration = Duration::from_millis(500);
/// A request still open after this is taken as one that stays open for live
/// updates, and isn't waited for.
const LONG_LIVED: Duration = Duration::from_secs(5);
/// How long the browser gets to close before it's stopped.
const CLOSE_WAIT: Duration = Duration::from_secs(5);

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
    let res = run_browser(browser, proxy, url, &work).and_then(|png| {
        let img = image::load_from_memory(&png).map_err(|e| format!("reading the screenshot: {e}"))?;
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

/// Starts `browser` headless with DevTools on, opens `url` through `proxy`, and
/// returns a PNG screenshot of it.
fn run_browser(browser: &Path, proxy: &str, url: &str, profile: &Path) -> Result<Vec<u8>, String> {
    let deadline = Instant::now() + TIMEOUT;
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
        // DevTools on a port of its choosing, written to the profile. Only this
        // computer can reach it, and a web page can't (it sends an Origin).
        "--remote-debugging-port=0",
    ])
    .arg(format!("--user-data-dir={}", profile.display()))
    .arg(format!("--proxy-server=http://{proxy}"))
    // Everything through the proxy, even names Chrome would otherwise send direct.
    .arg("--proxy-bypass-list=<-loopback>")
    .arg(format!("--window-size={},{}", PAGE_SIZE.0, PAGE_SIZE.1))
    .arg("about:blank")
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
    let mut devtools = None;
    let res = devtools_address(&mut child, profile, Instant::now() + START_WAIT)
        .and_then(|(port, path)| Devtools::connect(port, &path, deadline))
        .and_then(|d| devtools.insert(d).screenshot(url));
    if let Some(mut d) = devtools {
        d.close_browser();
    }
    let closing = Instant::now();
    while child.try_wait().is_ok_and(|done| done.is_none()) && closing.elapsed() < CLOSE_WAIT {
        std::thread::sleep(Duration::from_millis(100));
    }
    let _ = child.kill();
    let _ = child.wait();
    res
}

/// The DevTools port and browser path, from the file the browser writes in its
/// profile once it's listening.
fn devtools_address(child: &mut Child, profile: &Path, until: Instant) -> Result<(u16, String), String> {
    let file = profile.join("DevToolsActivePort");
    loop {
        if let Ok(text) = std::fs::read_to_string(&file) {
            let mut lines = text.lines();
            if let (Some(Ok(port)), Some(path)) = (lines.next().map(str::parse), lines.next())
                && path.starts_with('/')
            {
                return Ok((port, path.to_owned()));
            }
        }
        if let Ok(Some(status)) = child.try_wait() {
            return Err(format!("the browser closed at once ({status})"));
        }
        if Instant::now() >= until {
            return Err(format!("the browser didn't start DevTools within {}s", START_WAIT.as_secs()));
        }
        std::thread::sleep(Duration::from_millis(100));
    }
}

/// A DevTools connection to the browser, driving one page.
struct Devtools {
    ws: tungstenite::WebSocket<TcpStream>,
    last_id: u64,
    /// The page's session, once attached.
    session: Option<String>,
    /// The page has fired its load event since this was last cleared.
    loaded: bool,
    /// The page's requests still open: when each started, and whether it's a
    /// stream of events (which never ends).
    open: HashMap<String, (Instant, bool)>,
    /// When one of the page's requests last started or ended.
    last_activity: Instant,
    deadline: Instant,
}

impl Devtools {
    fn connect(port: u16, path: &str, deadline: Instant) -> Result<Devtools, String> {
        let err = |e: &dyn std::fmt::Display| format!("connecting to the browser: {e}");
        let addr = SocketAddr::from(([127, 0, 0, 1], port));
        let stream = TcpStream::connect_timeout(&addr, Duration::from_secs(5)).map_err(|e| err(&e))?;
        stream.set_read_timeout(Some(Duration::from_secs(5))).map_err(|e| err(&e))?;
        let (ws, _) = tungstenite::client(format!("ws://{addr}{path}"), stream).map_err(|e| err(&e))?;
        // Short reads from here on, so waiting can watch the clock.
        ws.get_ref().set_read_timeout(Some(Duration::from_millis(100))).map_err(|e| err(&e))?;
        Ok(Devtools {
            ws,
            last_id: 0,
            session: None,
            loaded: false,
            open: HashMap::new(),
            last_activity: Instant::now(),
            deadline,
        })
    }

    /// Opens `url` in a new page and returns a PNG of it.
    fn screenshot(&mut self, url: &str) -> Result<Vec<u8>, String> {
        let page = self.call("Target.createTarget", json!({ "url": "about:blank" }))?;
        let page = page["targetId"].as_str().ok_or("the browser opened no page")?.to_owned();
        let session = self.call("Target.attachToTarget", json!({ "targetId": page, "flatten": true }))?;
        self.session = Some(session["sessionId"].as_str().ok_or("the browser gave no session")?.to_owned());
        self.call("Page.enable", json!({}))?;
        self.call("Network.enable", json!({}))?;
        self.call(
            "Emulation.setDeviceMetricsOverride",
            json!({ "width": PAGE_SIZE.0, "height": PAGE_SIZE.1, "deviceScaleFactor": 1, "mobile": false }),
        )?;
        self.loaded = false;
        self.open.clear();
        let opened_at = Instant::now();
        self.last_activity = opened_at;
        let opened = self.call("Page.navigate", json!({ "url": url }))?;
        if let Some(e) = opened["errorText"].as_str().filter(|e| !e.is_empty()) {
            return Err(format!("the page didn't open: {e}"));
        }
        let load_by = Instant::now() + LOAD_WAIT;
        while !self.loaded && self.next_message(load_by)?.is_some() {}
        if !self.loaded {
            log::debug!("[thumbs] {url} still loading after {}s; taking it as it is", LOAD_WAIT.as_secs());
        }
        // Then until it stops asking for things. Checked at least every 100ms,
        // as it can go quiet with no message to say so.
        let settle_by = Instant::now() + SETTLE_WAIT;
        while !self.is_quiet() && Instant::now() < settle_by {
            self.next_message((Instant::now() + Duration::from_millis(100)).min(settle_by))?;
        }
        log::debug!(
            "[thumbs] {url}: {} after {:.1}s",
            if self.is_quiet() { "done" } else { "still busy" },
            opened_at.elapsed().as_secs_f32()
        );
        let shot = self.call("Page.captureScreenshot", json!({ "format": "png" }))?;
        let data = shot["data"].as_str().ok_or("the browser sent no screenshot")?;
        base64::engine::general_purpose::STANDARD.decode(data).map_err(|e| format!("reading the screenshot: {e}"))
    }

    /// Asks the browser to close, without waiting for it.
    fn close_browser(&mut self) {
        self.last_id += 1;
        let ask = json!({ "id": self.last_id, "method": "Browser.close" });
        let _ = self.ws.send(Message::Text(ask.to_string().into()));
    }

    /// Sends a command (to the page, once attached) and returns its result.
    fn call(&mut self, method: &str, params: Value) -> Result<Value, String> {
        self.last_id += 1;
        let id = self.last_id;
        let mut ask = json!({ "id": id, "method": method });
        ask["params"] = params;
        if let Some(s) = &self.session {
            ask["sessionId"] = s.clone().into();
        }
        self.ws.send(Message::Text(ask.to_string().into())).map_err(|e| format!("talking to the browser: {e}"))?;
        loop {
            // Until the deadline, which ends it with an error.
            let Some(answer) = self.next_message(self.deadline)? else { continue };
            if answer["id"].as_u64() == Some(id) {
                if let Some(e) = answer.get("error") {
                    return Err(format!("{method}: {}", e["message"].as_str().unwrap_or("failed")));
                }
                return Ok(answer["result"].clone());
            }
        }
    }

    /// The page has started and finished no request for a moment, and the ones
    /// still open are streams or have been open long enough to be taken as such.
    fn is_quiet(&self) -> bool {
        self.last_activity.elapsed() >= QUIET
            && self.open.values().all(|(since, stream)| *stream || since.elapsed() >= LONG_LIVED)
    }

    /// Keeps track of the page's requests, from a message from the browser.
    fn note(&mut self, message: &Value) {
        let params = &message["params"];
        let request = || params["requestId"].as_str().unwrap_or_default().to_owned();
        match message["method"].as_str().unwrap_or_default() {
            "Page.loadEventFired" => self.loaded = true,
            "Network.requestWillBeSent" => {
                let stream = params["type"] == "EventSource";
                self.open.insert(request(), (Instant::now(), stream));
                self.last_activity = Instant::now();
            }
            "Network.loadingFinished" | "Network.loadingFailed" => {
                self.open.remove(&request());
                self.last_activity = Instant::now();
            }
            _ => {}
        }
    }

    /// The next message from the browser, or `None` once `until` passes.
    /// Notes the page's load and requests on the way.
    fn next_message(&mut self, until: Instant) -> Result<Option<Value>, String> {
        loop {
            if Instant::now() >= self.deadline {
                return Err(format!("the page took longer than {}s", TIMEOUT.as_secs()));
            }
            if Instant::now() >= until {
                return Ok(None);
            }
            match self.ws.read() {
                Ok(Message::Text(text)) => {
                    let message: Value =
                        serde_json::from_str(&text).map_err(|e| format!("reading the browser's answer: {e}"))?;
                    self.note(&message);
                    return Ok(Some(message));
                }
                Ok(Message::Close(_)) => return Err("the browser closed".into()),
                Ok(_) => {}
                Err(tungstenite::Error::Io(e))
                    if matches!(e.kind(), std::io::ErrorKind::WouldBlock | std::io::ErrorKind::TimedOut) => {}
                Err(e) => return Err(format!("talking to the browser: {e}")),
            }
        }
    }
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

    /// A page that leaves a request open for ever, as dashboards do, and draws
    /// itself only once its data comes, a while after loading, still gets its
    /// picture, drawn.
    #[test]
    fn real_browser_screenshot_of_a_page_that_never_settles() {
        use std::io::{Read as _, Write as _};
        use std::net::TcpStream;
        let Some(browser) = find_browser() else { return };
        let (_g, _d) = crate::core::tests::test_dir();
        // Plays both the app's proxy and the website.
        let listener = std::net::TcpListener::bind("127.0.0.1:0").unwrap();
        let proxy = listener.local_addr().unwrap().to_string();
        std::thread::spawn(move || {
            let mut never_answered = Vec::new();
            for stream in listener.incoming() {
                let Ok(mut s) = stream else { continue };
                let mut head = [0u8; 4096];
                let n = s.read(&mut head).unwrap_or(0);
                let head = String::from_utf8_lossy(&head[..n]);
                let answer = |mut s: TcpStream, ctype: &str, body: &str| {
                    let _ = write!(
                        s,
                        "HTTP/1.1 200 OK\r\nContent-Type: {ctype}\r\nContent-Length: {}\r\nConnection: close\r\n\r\n{body}",
                        body.len()
                    );
                };
                if head.starts_with("GET http://site.test/updates") {
                    never_answered.push(s);
                } else if head.starts_with("GET http://site.test/data") {
                    std::thread::spawn(move || {
                        std::thread::sleep(Duration::from_secs(4));
                        answer(s, "application/json", "{\"color\":\"#c00\"}");
                    });
                } else if head.starts_with("GET http://site.test/ ") {
                    let page = "<html><body style='background:#00c'><script>fetch('/updates');\
                        fetch('/data').then(r => r.json()).then(d => document.body.style.background = d.color)\
                        </script></body></html>";
                    answer(s, "text/html", page);
                }
            }
        });
        let started = Instant::now();
        let pic = take(&browser, &proxy, "site.test", "http://site.test/").expect("screenshot");
        // Drawn: red, not the blue it starts as.
        let px = &pic.rgba[(pic.size[0] * pic.size[1] / 2) * 4..][..4];
        assert!(px[0] > 150 && px[2] < 80, "{px:?}");
        assert!(started.elapsed() < TIMEOUT, "took {:?}", started.elapsed());
    }
}
