//! Fictional data for README screenshots (`--features screenshots`).
//!
//! `cargo xtask screenshots` runs the app with `TAILNET_LINK_DEMO_CAPTURE` set to an
//! output file and `TAILNET_LINK_DEMO_VIEW` naming what to show. The app then skips
//! the engine, the system proxy and the tray, draws made-up tailnets, writes one
//! frame as a PPM and closes. Every name and address here is invented.

use std::io::Write as _;

use eframe::egui::{self, vec2};

use crate::config::{Config, parse_forwards};
use crate::core::{ForwardStatus, Machine, SiteStatus, Status, TailnetStatus};

/// What a capture shows.
#[derive(Clone, Copy, PartialEq, Eq)]
pub enum View {
    /// First run: no tailnets yet.
    Welcome,
    /// Two tailnets routing, with their machines.
    Tailnets,
    /// One tailnet waiting for its sign-in.
    SignIn,
    /// The Settings tab.
    Settings,
    /// The dialog after forwarding Remote Desktop to a machine.
    Forward,
}

pub fn active() -> bool {
    std::env::var_os("TAILNET_LINK_DEMO_CAPTURE").is_some()
}

pub fn view() -> View {
    match std::env::var("TAILNET_LINK_DEMO_VIEW").as_deref() {
        Ok("welcome") => View::Welcome,
        Ok("signin") => View::SignIn,
        Ok("settings") => View::Settings,
        Ok("forward") => View::Forward,
        _ => View::Tailnets,
    }
}

const HOME: &str = "capybara-iguana.ts.net";
const STUDIO: &str = "comet-bebop.ts.net";

pub const FORWARDS: &str = "50321 = build-pc.capybara-iguana.ts.net:3389\n\
                            54320 = db-staging.comet-bebop.ts.net:5432";

/// The settings the demo window starts with.
pub fn config() -> Config {
    Config {
        forwards: parse_forwards(FORWARDS).unwrap_or_default(),
        hostname: "ana-laptop".into(),
        machines_open: vec!["home".into(), "studio".into()],
        // English unless asked, so screenshots don't follow this computer's language.
        language: std::env::var("TAILNET_LINK_DEMO_LANGUAGE").unwrap_or_else(|_| "en".into()),
        ..Config::default()
    }
}

fn machine(name: &str, domain: &str, os: &str, online: bool, ip: &str) -> Machine {
    Machine { name: name.into(), dns_name: format!("{name}.{domain}"), os: os.into(), online, ip: ip.into() }
}

fn home() -> TailnetStatus {
    TailnetStatus {
        id: "home".into(),
        name: "Home lab".into(),
        backend: "Running".into(),
        tailnet: "ana@example.com".into(),
        self_name: format!("ana-laptop.{HOME}"),
        domains: vec![HOME.into()],
        connected: true,
        enabled: true,
        routing: true,
        machines: vec![
            machine("build-pc", HOME, "windows", true, "100.88.14.20"),
            machine("nas", HOME, "linux", true, "100.88.14.7"),
            machine("pi-hole", HOME, "linux", true, "100.88.14.3"),
            machine("media-mac", HOME, "macOS", false, "100.88.14.31"),
        ],
        ..TailnetStatus::default()
    }
}

fn studio() -> TailnetStatus {
    TailnetStatus {
        id: "studio".into(),
        name: "Lantern Studio".into(),
        backend: "Running".into(),
        tailnet: "lantern-studio@example.com".into(),
        self_name: format!("ana-laptop.{STUDIO}"),
        domains: vec![STUDIO.into()],
        connected: true,
        enabled: true,
        routing: true,
        machines: vec![
            machine("wiki", STUDIO, "linux", true, "100.101.7.12"),
            machine("db-staging", STUDIO, "linux", true, "100.101.7.40"),
            machine("render-01", STUDIO, "windows", true, "100.101.7.51"),
            machine("render-02", STUDIO, "windows", false, "100.101.7.52"),
        ],
        ..TailnetStatus::default()
    }
}

fn waiting() -> TailnetStatus {
    TailnetStatus {
        id: "client".into(),
        backend: "NeedsLogin".into(),
        login_wait: true,
        enabled: true,
        auth_url: "https://login.example.com/a/demo".into(),
        ..TailnetStatus::default()
    }
}

/// What the window shows instead of the engine's status.
pub fn status() -> Status {
    let tailnets = match view() {
        View::Welcome => Vec::new(),
        View::SignIn => vec![home(), waiting()],
        View::Tailnets | View::Settings | View::Forward => vec![home(), studio()],
    };
    let routing = tailnets.iter().any(|t| t.routing);
    Status {
        tailnets,
        enabled: true,
        routing,
        problem: String::new(),
        listen: "127.0.0.1:1055".into(),
        forwards: vec![
            ForwardStatus {
                local_port: 50321,
                target: format!("build-pc.{HOME}:3389"),
                via: "Home lab".into(),
                error: String::new(),
            },
            ForwardStatus {
                local_port: 54320,
                target: format!("db-staging.{STUDIO}:5432"),
                via: "Lantern Studio".into(),
                error: String::new(),
            },
        ],
        pac_url: "http://127.0.0.1:1055/proxy.pac?v=1".into(),
        system: crate::core::SystemProxyState::Active,
        system_setting: "http://127.0.0.1:1055/proxy.pac?v=1".into(),
        update: None,
        update_check: crate::core::UpdateCheck::Done,
        // The sign-in picture is about the new tailnet's card; tiles would push it out of frame.
        sites: if matches!(view(), View::Welcome | View::SignIn) { Vec::new() } else { sites() },
        sites_checking: None,
    }
}

fn site(machine: &str, domain: &str, tailnet: &str, title: &str, color: Option<[u8; 3]>, trusted: bool) -> SiteStatus {
    SiteStatus {
        host: format!("{machine}.{domain}"),
        machine: machine.into(),
        title: title.into(),
        trusted,
        color,
        icon: None,
        tailnet: tailnet.into(),
        routing: true,
    }
}

fn sites() -> Vec<SiteStatus> {
    vec![
        site("nas", HOME, "Home lab", "Storage Manager", Some([38, 99, 235]), true),
        site("pi-hole", HOME, "Home lab", "Pi-hole Admin", Some([150, 18, 30]), false),
        site("wiki", STUDIO, "Lantern Studio", "Lantern Wiki", Some([22, 128, 92]), true),
        site("render-01", STUDIO, "Lantern Studio", "", None, true),
    ]
}

/// Keeps the real mouse and keyboard out of the capture.
pub fn isolate_input(input: &mut egui::RawInput) {
    input.events.clear();
}

/// Sizes the window, then writes one settled frame and closes.
pub fn capture(ctx: &egui::Context) {
    let Some(destination) = std::env::var_os("TAILNET_LINK_DEMO_CAPTURE") else { return };
    ctx.request_repaint_after(std::time::Duration::from_millis(50));
    if ctx.cumulative_frame_nr() == 0 {
        let size = std::env::var("TAILNET_LINK_DEMO_SIZE")
            .ok()
            .and_then(|value| {
                let (width, height) = value.split_once('x')?;
                Some(vec2(width.parse().ok()?, height.parse().ok()?))
            })
            .unwrap_or(vec2(760.0, 860.0));
        ctx.send_viewport_cmd(egui::ViewportCommand::InnerSize(size));
    }
    if ctx.cumulative_frame_nr() == 40 {
        let ctx = ctx.clone();
        ctx.clone().request_screenshot(move |image| {
            let write = || -> std::io::Result<()> {
                let mut file = std::io::BufWriter::new(std::fs::File::create(&destination)?);
                write!(file, "P6\n{} {}\n255\n", image.size[0], image.size[1])?;
                let bytes: Vec<u8> = image.pixels.iter().flat_map(|p| [p.r(), p.g(), p.b()]).collect();
                file.write_all(&bytes)?;
                file.flush()
            };
            if let Err(e) = write() {
                log::error!("demo capture: {e}");
            }
            ctx.send_viewport_cmd(egui::ViewportCommand::Close);
        });
    }
}
