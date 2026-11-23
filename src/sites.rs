//! Finds the machines that serve a website over HTTPS, for the tiles on the
//! Tailnets tab.
//!
//! It's meant to go unnoticed. Each machine is asked at most once a day, and the
//! answer, yes or no, is saved, so restarting the app doesn't ask again. Machines
//! are asked one at a time, only while they're online, and only through the
//! app's own proxy. That proxy refuses every name outside the routing tailnets,
//! and redirects and icon links to other hosts are never followed, so nothing
//! here reaches beyond the tailnets.

use std::collections::{BTreeMap, HashMap};
use std::io::{self, Read as _};
use std::sync::Arc;
use std::time::{Duration, SystemTime, UNIX_EPOCH};

use base64::Engine as _;
use serde::{Deserialize, Serialize};

use crate::config;

/// How long an answer is kept before the machine is asked again.
pub const RECHECK_AFTER: Duration = Duration::from_hours(24);
/// A machine that couldn't be reached at all is asked again sooner.
const RETRY_UNSURE_AFTER: Duration = Duration::from_hours(6);
/// Machines that haven't been asked for this long (gone, or offline for weeks) are dropped.
const FORGET_AFTER: Duration = Duration::from_hours(24 * 30);
/// Icons larger than this (in pixels, either side) are scaled down to it.
pub const ICON_SIZE: u32 = 64;
const MAX_PAGE: u64 = 256 * 1024;
const MAX_ICON: u64 = 512 * 1024;
const MAX_REDIRECTS: usize = 5;
/// Icon links tried per site, before /favicon.ico.
const MAX_ICON_TRIES: usize = 2;
const MAX_TITLE_CHARS: usize = 80;

/// A website one machine serves.
#[derive(Clone, Debug, Default, PartialEq, Eq, Serialize, Deserialize)]
#[serde(default)]
pub struct Site {
    /// Its name: the app name it declares, else its page title ("" if neither).
    pub title: String,
    /// Its certificate checked out. When it didn't, the browser will warn.
    pub trusted: bool,
    /// Its `theme-color`.
    pub color: Option<[u8; 3]>,
    /// Its icon as a PNG, base64 ("" if none could be read).
    #[serde(skip_serializing_if = "String::is_empty")]
    pub icon: String,
}

/// What asking one machine found out.
#[derive(Debug, PartialEq, Eq)]
pub enum Outcome {
    Site(Site),
    /// Nothing serves HTTPS there.
    None,
    /// Couldn't tell (unreachable, timed out). Asked again sooner.
    Unsure,
}

/// A decoded icon, ready to become a texture.
#[derive(Debug, PartialEq, Eq)]
pub struct Icon {
    pub size: [usize; 2],
    pub rgba: Vec<u8>,
}

#[derive(Clone, Debug, Default, Serialize, Deserialize)]
#[serde(default)]
struct Answer {
    /// When the machine was last asked (Unix seconds).
    checked: u64,
    /// When to ask it again.
    due: u64,
    site: Option<Site>,
}

/// Every machine's answer, saved in sites.json, keyed by full MagicDNS name.
#[derive(Default, Serialize, Deserialize)]
#[serde(default)]
pub struct Cache {
    machines: BTreeMap<String, Answer>,
    #[serde(skip)]
    icons: HashMap<String, Arc<Icon>>,
}

impl Cache {
    /// The saved answers (none if there's no file or it can't be read).
    pub fn load() -> Cache {
        let mut c: Cache = std::fs::read(path()).ok().and_then(|b| serde_json::from_slice(&b).ok()).unwrap_or_default();
        let now = now();
        c.machines.retain(|_, a| a.checked + FORGET_AFTER.as_secs() > now);
        let hosts: Vec<String> = c.machines.keys().cloned().collect();
        for h in hosts {
            c.decode_icon(&h);
        }
        c
    }

    pub fn save(&self) {
        let path = path();
        let tmp = path.with_extension("json.tmp");
        let res = serde_json::to_vec_pretty(self)
            .map_err(io::Error::other)
            .and_then(|b| std::fs::write(&tmp, b))
            .and_then(|()| std::fs::rename(&tmp, &path));
        if let Err(e) = res {
            log::warn!("saving {}: {e}", path.display());
        }
    }

    /// The machine hasn't been asked yet, or its answer is old enough to ask again.
    pub fn is_due(&self, host: &str, now: u64) -> bool {
        self.machines.get(host).is_none_or(|a| now >= a.due)
    }

    pub fn record(&mut self, host: &str, outcome: Outcome, now: u64) {
        let previous = self.machines.remove(host).and_then(|a| a.site);
        let (after, site) = match outcome {
            Outcome::Site(s) => (RECHECK_AFTER, Some(s)),
            Outcome::None => (RECHECK_AFTER, None),
            // A machine that's briefly unreachable keeps what it had.
            Outcome::Unsure => (RETRY_UNSURE_AFTER, previous),
        };
        self.machines.insert(host.to_owned(), Answer { checked: now, due: now + after.as_secs(), site });
        self.decode_icon(host);
    }

    pub fn site(&self, host: &str) -> Option<&Site> {
        self.machines.get(host)?.site.as_ref()
    }

    pub fn icon(&self, host: &str) -> Option<Arc<Icon>> {
        self.icons.get(host).cloned()
    }

    /// Makes every machine due, for "Check again".
    pub fn recheck_all(&mut self) {
        for a in self.machines.values_mut() {
            a.due = 0;
        }
    }

    fn decode_icon(&mut self, host: &str) {
        let icon = self.site(host).and_then(|s| decode_png(&s.icon));
        match icon {
            Some(i) => {
                // Keep the same Arc when nothing changed, so the UI keeps its texture.
                if self.icons.get(host).is_none_or(|old| **old != i) {
                    self.icons.insert(host.to_owned(), Arc::new(i));
                }
            }
            None => {
                self.icons.remove(host);
            }
        }
    }
}

fn path() -> std::path::PathBuf {
    config::config_dir().join("sites.json")
}

pub fn now() -> u64 {
    SystemTime::now().duration_since(UNIX_EPOCH).map_or(0, |d| d.as_secs())
}

fn decode_png(b64: &str) -> Option<Icon> {
    if b64.is_empty() {
        return None;
    }
    let bytes = base64::engine::general_purpose::STANDARD.decode(b64).ok()?;
    let img = image::load_from_memory_with_format(&bytes, image::ImageFormat::Png).ok()?.to_rgba8();
    Some(Icon { size: [img.width() as usize, img.height() as usize], rgba: img.into_raw() })
}

// ---- Asking a machine ----

/// Asks one machine whether it serves a website on port 443.
///
/// `reach` opens a connection to the machine's port 443 through its tailnet,
/// which tells a closed port (no site, for sure) from an unreachable machine
/// (ask again later). `proxy` is the app's own proxy (host:port), which
/// carries the HTTPS requests.
pub fn probe(proxy: &str, host: &str, reach: impl FnOnce() -> io::Result<()>) -> Outcome {
    match reach() {
        Ok(()) => {}
        // Closed, refused by the tailnet's rules, or dropped by a firewall (the machine
        // is online, so silence means the port is filtered): no site, for a day.
        Err(e)
            if matches!(
                e.kind(),
                io::ErrorKind::ConnectionRefused | io::ErrorKind::PermissionDenied | io::ErrorKind::TimedOut
            ) =>
        {
            log::debug!("[sites] {host}: {e}");
            return Outcome::None;
        }
        Err(e) => {
            log::debug!("[sites] {host}: {e}");
            return Outcome::Unsure;
        }
    }
    let Some(verified) = agent(proxy, true) else { return Outcome::Unsure };
    let origin = format!("https://{host}");
    let mut url = format!("{origin}/");
    let mut agent = verified;
    let mut trusted = true;
    for _ in 0..=MAX_REDIRECTS {
        let mut resp = match agent.get(&url).header("Accept", "text/html,application/xhtml+xml,*/*;q=0.8").call() {
            Ok(r) => r,
            Err(e) => {
                let tls = matches!(e, ureq::Error::Tls(_) | ureq::Error::Rustls(_));
                // Usually a certificate the system doesn't trust (self-signed): look
                // again without checking it, and say so on the tile.
                if trusted && tls {
                    let Some(a) = self::agent(proxy, false) else { return Outcome::Unsure };
                    (agent, trusted) = (a, false);
                    continue;
                }
                log::debug!("[sites] {url}: {e}");
                // Port 443 is open but doesn't speak HTTPS: no site. Anything else (the
                // proxy, a timeout, a dropped connection) says nothing either way.
                return if tls || matches!(e, ureq::Error::Protocol(_)) { Outcome::None } else { Outcome::Unsure };
            }
        };
        let status = resp.status().as_u16();
        if (300..400).contains(&status) {
            let location = resp.headers().get("location").and_then(|v| v.to_str().ok()).unwrap_or("");
            match resolve(&url, &origin, location) {
                Some(next) => {
                    url = next;
                    continue;
                }
                // Off to a sign-in page elsewhere, say: still a website.
                None => return Outcome::Site(Site { trusted, ..Site::default() }),
            }
        }
        // A sign-in wall counts; a missing page or a broken backend doesn't.
        if !(status < 300 || status == 401 || status == 403) {
            return Outcome::None;
        }
        let html = resp
            .headers()
            .get("content-type")
            .and_then(|v| v.to_str().ok())
            .is_none_or(|t| t.to_ascii_lowercase().contains("html"));
        let page = if html {
            let mut body = Vec::new();
            let _ = resp.body_mut().as_reader().take(MAX_PAGE).read_to_end(&mut body);
            Page::parse(&String::from_utf8_lossy(&body))
        } else {
            Page::default()
        };
        let mut site = Site { title: page.name(), trusted, color: page.color, icon: String::new() };
        let mut links: Vec<String> = page.icons.iter().take(MAX_ICON_TRIES).cloned().collect();
        links.push("/favicon.ico".into());
        links.dedup();
        for link in links {
            if let Some(icon) = fetch_icon(&agent, &url, &origin, &link) {
                site.icon = icon;
                break;
            }
        }
        return Outcome::Site(site);
    }
    // Redirects going round in circles on the machine itself: still a website.
    Outcome::Site(Site { trusted, ..Site::default() })
}

/// An HTTPS client that only talks through the app's proxy and follows no redirects.
fn agent(proxy: &str, verify: bool) -> Option<ureq::Agent> {
    let proxy = ureq::Proxy::new(&format!("http://{proxy}")).ok()?;
    let tls = ureq::tls::TlsConfig::builder().disable_verification(!verify).build();
    Some(
        ureq::Agent::config_builder()
            .proxy(Some(proxy))
            .max_redirects(0)
            .http_status_as_error(false)
            .timeout_global(Some(Duration::from_secs(15)))
            .user_agent(concat!("tailnet-link/", env!("CARGO_PKG_VERSION")))
            .tls_config(tls)
            .build()
            .into(),
    )
}

/// Downloads an icon (or reads a data: link) and returns it as a PNG, base64.
fn fetch_icon(agent: &ureq::Agent, base: &str, origin: &str, link: &str) -> Option<String> {
    let bytes = if let Some(data) = link.strip_prefix("data:") {
        let (meta, payload) = data.split_once(',')?;
        if !meta.ends_with(";base64") {
            return None;
        }
        base64::engine::general_purpose::STANDARD.decode(payload.trim()).ok()?
    } else {
        let url = resolve(base, origin, link)?;
        let mut resp = agent.get(&url).header("Accept", "image/png,image/x-icon,image/*;q=0.8").call().ok()?;
        if resp.status().as_u16() != 200 {
            return None;
        }
        let mut body = Vec::new();
        resp.body_mut().as_reader().take(MAX_ICON).read_to_end(&mut body).ok()?;
        body
    };
    icon_png(&bytes)
}

/// Decodes a PNG or ICO, scales it down to `ICON_SIZE` if larger, and re-encodes it as a PNG, base64.
fn icon_png(bytes: &[u8]) -> Option<String> {
    let mut img = image::load_from_memory(bytes).ok()?;
    if img.width() > ICON_SIZE || img.height() > ICON_SIZE {
        img = img.resize(ICON_SIZE, ICON_SIZE, image::imageops::FilterType::Triangle);
    }
    let mut out = io::Cursor::new(Vec::new());
    image::DynamicImage::ImageRgba8(img.to_rgba8()).write_to(&mut out, image::ImageFormat::Png).ok()?;
    Some(base64::engine::general_purpose::STANDARD.encode(out.into_inner()))
}

/// `href` resolved against `base`, if it stays on the same machine (`origin`, `https://host`).
fn resolve(base: &str, origin: &str, href: &str) -> Option<String> {
    let href = href.trim();
    let href = href.split('#').next().unwrap_or("");
    if href.is_empty() {
        return None;
    }
    let absolute = if href.starts_with("//") {
        Some(format!("https:{href}"))
    } else if href.len() >= 8 && href[..8].eq_ignore_ascii_case("https://") {
        Some(href.to_owned())
    } else {
        None
    };
    if let Some(abs) = absolute {
        let rest = &abs[8..];
        let end = rest.find(['/', '?']).unwrap_or(rest.len());
        let authority = rest[..end].rsplit('@').next().unwrap_or("");
        let host = authority.strip_suffix(":443").unwrap_or(authority);
        if !host.eq_ignore_ascii_case(&origin[8..]) {
            return None;
        }
        let path = &rest[end..];
        return Some(if path.starts_with('/') { format!("{origin}{path}") } else { format!("{origin}/{path}") });
    }
    // Another scheme (http:, data:, javascript:, ...).
    if href.find(':').is_some_and(|i| !href[..i].contains(['/', '?'])) {
        return None;
    }
    if href.starts_with('/') {
        return Some(format!("{origin}{href}"));
    }
    let base = base.split(['?', '#']).next().unwrap_or(base);
    let dir = base.get(origin.len()..).and_then(|p| p.rfind('/').map(|i| &p[..=i])).unwrap_or("/");
    Some(format!("{origin}{dir}{href}"))
}

// ---- Reading the page ----

/// What a page's head says about the site.
#[derive(Debug, Default, PartialEq, Eq)]
struct Page {
    title: String,
    /// The app name it declares (`application-name`, `og:site_name`, ...).
    app_name: String,
    color: Option<[u8; 3]>,
    /// Icon links, best first.
    icons: Vec<String>,
}

impl Page {
    fn parse(html: &str) -> Page {
        // Same length and character boundaries as `html`: only ASCII letters change.
        let lower = html.to_ascii_lowercase();
        let mut page = Page::default();
        let mut icons: Vec<(String, u32)> = Vec::new();
        let mut dark_color = None;
        let mut at = 0;
        while let Some(i) = lower[at..].find('<') {
            let start = at + i + 1;
            let Some(len) = lower[start..].find('>') else { break };
            let end = start + len;
            at = end + 1;
            let tag = &lower[start..end];
            let name_end = tag.find(|c: char| c.is_ascii_whitespace() || c == '/').unwrap_or(tag.len());
            match &tag[..name_end] {
                "title" if page.title.is_empty() => {
                    let close = lower[at..].find("</title").map_or(lower.len(), |e| at + e);
                    page.title = clean_text(&html[at..close]);
                    at = close;
                }
                "meta" => {
                    let a = attrs(&html[start + name_end..end]);
                    let get = |k: &str| a.iter().find(|(n, _)| n == k).map_or("", |(_, v)| v.as_str());
                    let key = if get("name").is_empty() { get("property") } else { get("name") };
                    let content = get("content");
                    match key.to_ascii_lowercase().as_str() {
                        "application-name" | "apple-mobile-web-app-title" | "og:site_name"
                            if page.app_name.is_empty() =>
                        {
                            page.app_name = clean_text(content);
                        }
                        "theme-color" => {
                            let c = parse_color(content);
                            if get("media").contains("dark") {
                                dark_color = dark_color.or(c);
                            } else {
                                page.color = page.color.or(c);
                            }
                        }
                        _ => {}
                    }
                }
                "link" => {
                    let a = attrs(&html[start + name_end..end]);
                    let get = |k: &str| a.iter().find(|(n, _)| n == k).map_or("", |(_, v)| v.as_str());
                    let rel = get("rel").to_ascii_lowercase();
                    let href = get("href");
                    let svg = get("type").contains("svg")
                        || href.split(['?', '#']).next().unwrap_or("").to_ascii_lowercase().ends_with(".svg");
                    if href.is_empty() || svg {
                        continue;
                    }
                    let touch = rel.split_whitespace().any(|r| r.starts_with("apple-touch-icon"));
                    if !touch && !rel.split_whitespace().any(|r| r == "icon") {
                        continue;
                    }
                    let declared = get("sizes")
                        .split_whitespace()
                        .filter_map(|s| s.split_once(['x', 'X']).and_then(|(w, _)| w.parse::<u32>().ok()))
                        .max();
                    let size = declared.unwrap_or(if touch { 180 } else { 16 });
                    icons.push((href.to_owned(), size));
                }
                "body" => break,
                _ => {}
            }
        }
        // The window is dark, so a dark-mode colour suits it better.
        page.color = dark_color.or(page.color);
        icons.sort_by_key(|(_, size)| std::cmp::Reverse(*size));
        page.icons = icons.into_iter().map(|(h, _)| h).collect();
        page
    }

    /// The site's name for its tile.
    fn name(&self) -> String {
        if self.app_name.is_empty() { self.title.clone() } else { self.app_name.clone() }
    }
}

/// A tag's attributes as (lowercase name, value) pairs.
fn attrs(s: &str) -> Vec<(String, String)> {
    let mut out = Vec::new();
    let mut it = s.char_indices().peekable();
    loop {
        while it.next_if(|(_, c)| c.is_whitespace() || *c == '/').is_some() {}
        let Some(&(start, _)) = it.peek() else { break };
        let mut end = s.len();
        while let Some(&(i, c)) = it.peek() {
            if c.is_whitespace() || c == '=' {
                end = i;
                break;
            }
            it.next();
        }
        let name = s[start..end].to_ascii_lowercase();
        while it.next_if(|(_, c)| c.is_whitespace()).is_some() {}
        let mut value = String::new();
        if it.next_if(|(_, c)| *c == '=').is_some() {
            while it.next_if(|(_, c)| c.is_whitespace()).is_some() {}
            if let Some((_, q)) = it.next_if(|(_, c)| *c == '"' || *c == '\'') {
                for (_, c) in it.by_ref() {
                    if c == q {
                        break;
                    }
                    value.push(c);
                }
            } else {
                while let Some((_, c)) = it.next_if(|(_, c)| !c.is_whitespace()) {
                    value.push(c);
                }
            }
        }
        if !name.is_empty() {
            out.push((name, decode_entities(&value)));
        }
    }
    out
}

/// "#abc" or "#aabbcc".
fn parse_color(s: &str) -> Option<[u8; 3]> {
    let hex = s.trim().strip_prefix('#')?;
    if !hex.bytes().all(|b| b.is_ascii_hexdigit()) {
        return None;
    }
    let digit = |i: usize| u8::from_str_radix(&hex[i..=i], 16).ok();
    match hex.len() {
        3 => Some([digit(0)? * 17, digit(1)? * 17, digit(2)? * 17]),
        6 => {
            let byte = |i: usize| u8::from_str_radix(&hex[i..i + 2], 16).ok();
            Some([byte(0)?, byte(2)?, byte(4)?])
        }
        _ => None,
    }
}

/// Entities decoded, whitespace collapsed, and cut to a tile-sized length.
fn clean_text(s: &str) -> String {
    let text = decode_entities(s).split_whitespace().collect::<Vec<_>>().join(" ");
    if text.chars().count() > MAX_TITLE_CHARS {
        let cut: String = text.chars().take(MAX_TITLE_CHARS - 1).collect();
        format!("{}…", cut.trim_end())
    } else {
        text
    }
}

fn decode_entities(s: &str) -> String {
    if !s.contains('&') {
        return s.to_owned();
    }
    let mut out = String::with_capacity(s.len());
    let mut rest = s;
    while let Some(i) = rest.find('&') {
        out.push_str(&rest[..i]);
        rest = &rest[i..];
        // (the character, where its ';' is)
        let decoded = rest.find(';').filter(|&e| e <= 10).and_then(|e| {
            let c = match &rest[1..e] {
                "amp" => '&',
                "lt" => '<',
                "gt" => '>',
                "quot" => '"',
                "apos" => '\'',
                "nbsp" => ' ',
                name => {
                    let n = name.strip_prefix('#')?;
                    let code = match n.strip_prefix(['x', 'X']) {
                        Some(h) => u32::from_str_radix(h, 16).ok()?,
                        None => n.parse().ok()?,
                    };
                    char::from_u32(code)?
                }
            };
            Some((c, e))
        });
        if let Some((c, e)) = decoded {
            out.push(c);
            rest = &rest[e + 1..];
        } else {
            out.push('&');
            rest = &rest[1..];
        }
    }
    out.push_str(rest);
    out
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn reads_a_page_head() {
        let page = Page::parse(
            r##"<!doctype html><html><head>
            <meta charset="utf-8">
            <TITLE>  Sign in &amp;
              more · Grafana </TITLE>
            <meta name="theme-color" content="#123">
            <meta name="theme-color" media="(prefers-color-scheme: dark)" content="#0a0b0c">
            <meta property="og:site_name" content='Grafana'>
            <link rel="icon" type="image/svg+xml" href="/logo.svg">
            <link rel="shortcut icon" href="/favicon-32.png" sizes="32x32">
            <link rel="apple-touch-icon" href="touch.png">
            <link rel=icon href=/fav16.png>
            <link rel="mask-icon" href="/mask.png">
            </head><body><link rel="icon" href="/late.png" sizes="512x512"></body></html>"##,
        );
        assert_eq!(page.title, "Sign in & more · Grafana");
        assert_eq!(page.app_name, "Grafana");
        assert_eq!(page.name(), "Grafana");
        assert_eq!(page.color, Some([10, 11, 12]), "dark-mode colour preferred");
        assert_eq!(page.icons, ["touch.png", "/favicon-32.png", "/fav16.png"], "largest first; no SVG, no body");
    }

    #[test]
    fn page_without_head_parts() {
        let page = Page::parse("<html><head><title>Home Assistant</title></head></html>");
        assert_eq!(page.name(), "Home Assistant");
        assert_eq!(page.color, None);
        assert_eq!(page.icons.len(), 0);
        assert_eq!(Page::parse("not html at all <").name(), "");
        let long = format!("<title>{}</title>", "x".repeat(200));
        assert_eq!(Page::parse(&long).title.chars().count(), MAX_TITLE_CHARS);
    }

    #[test]
    fn links_stay_on_the_machine() {
        let o = "https://wiki.example.ts.net";
        let base = "https://wiki.example.ts.net/app/login?next=/";
        for (href, want) in [
            ("/favicon.ico", Some("https://wiki.example.ts.net/favicon.ico")),
            ("icon.png", Some("https://wiki.example.ts.net/app/icon.png")),
            ("icon.png#x", Some("https://wiki.example.ts.net/app/icon.png")),
            ("https://WIKI.example.ts.net:443/a?b=1", Some("https://wiki.example.ts.net/a?b=1")),
            ("//wiki.example.ts.net/x", Some("https://wiki.example.ts.net/x")),
            ("https://wiki.example.ts.net", Some("https://wiki.example.ts.net/")),
            ("https://login.example.com/sso", None),
            ("https://wiki.example.ts.net.evil.com/", None),
            ("http://wiki.example.ts.net/", None),
            ("javascript:alert(1)", None),
            ("", None),
        ] {
            assert_eq!(resolve(base, o, href).as_deref(), want, "{href}");
        }
        assert_eq!(resolve(o, o, "x.png").as_deref(), Some("https://wiki.example.ts.net/x.png"));
    }

    #[test]
    fn attributes_and_entities() {
        let a = attrs(r#" rel="icon" HREF='/a b.png' sizes=32x32 hidden data-x = "&lt;&#65;&#x42;&bogus;&""#);
        let want: Vec<(String, String)> =
            [("rel", "icon"), ("href", "/a b.png"), ("sizes", "32x32"), ("hidden", ""), ("data-x", "<AB&bogus;&")]
                .iter()
                .map(|(k, v)| ((*k).to_owned(), (*v).to_owned()))
                .collect();
        assert_eq!(a, want);
        assert_eq!(parse_color("#FfF"), Some([255, 255, 255]));
        assert_eq!(parse_color(" #102030 "), Some([16, 32, 48]));
        assert_eq!(parse_color("red"), None);
        assert_eq!(parse_color("#12345"), None);
    }

    #[test]
    fn icons_are_scaled_and_kept_as_png() {
        let mut big = image::RgbaImage::new(180, 90);
        big.put_pixel(0, 0, image::Rgba([255, 0, 0, 255]));
        let mut png = io::Cursor::new(Vec::new());
        image::DynamicImage::ImageRgba8(big).write_to(&mut png, image::ImageFormat::Png).unwrap();
        let icon = decode_png(&icon_png(png.get_ref()).unwrap()).unwrap();
        assert_eq!(icon.size, [64, 32], "fits ICON_SIZE, keeps its shape");
        assert_eq!(icon.rgba.len(), 64 * 32 * 4);
        assert!(icon_png(b"<svg></svg>").is_none());
    }

    #[test]
    fn closed_ports_and_unreachable_machines() {
        let refused = || Err(io::Error::from(io::ErrorKind::ConnectionRefused));
        assert_eq!(probe("127.0.0.1:1", "a.example.ts.net", refused), Outcome::None);
        let denied = || Err(io::Error::from(io::ErrorKind::PermissionDenied));
        assert_eq!(probe("127.0.0.1:1", "a.example.ts.net", denied), Outcome::None);
        let dropped = || Err(io::Error::from(io::ErrorKind::TimedOut));
        assert_eq!(probe("127.0.0.1:1", "a.example.ts.net", dropped), Outcome::None);
        let unreachable = || Err(io::Error::from(io::ErrorKind::HostUnreachable));
        assert_eq!(probe("127.0.0.1:1", "a.example.ts.net", unreachable), Outcome::Unsure);
        // Reachable, but the proxy isn't there: can't tell.
        assert_eq!(probe("127.0.0.1:1", "a.example.ts.net", || Ok(())), Outcome::Unsure);
    }

    #[test]
    fn answers_last_a_day_and_unsure_keeps_the_site() {
        let mut c = Cache::default();
        let site = Site { title: "Wiki".into(), trusted: true, ..Site::default() };
        assert!(c.is_due("wiki.x.ts.net", 1000));
        c.record("wiki.x.ts.net", Outcome::Site(site.clone()), 1000);
        assert!(!c.is_due("wiki.x.ts.net", 1000 + RECHECK_AFTER.as_secs() - 1));
        assert!(c.is_due("wiki.x.ts.net", 1000 + RECHECK_AFTER.as_secs()));
        c.record("wiki.x.ts.net", Outcome::Unsure, 2000);
        assert_eq!(c.site("wiki.x.ts.net"), Some(&site), "a brief outage keeps the tile");
        assert!(c.is_due("wiki.x.ts.net", 2000 + RETRY_UNSURE_AFTER.as_secs()));
        c.record("wiki.x.ts.net", Outcome::None, 3000);
        assert_eq!(c.site("wiki.x.ts.net"), None);
        c.recheck_all();
        assert!(c.is_due("wiki.x.ts.net", 3001));
    }
}
