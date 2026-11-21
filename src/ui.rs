//! The window (egui) and the tray / menu-bar icon.
//!
//! The window can be hidden (closing it keeps the app in the tray); eframe
//! keeps calling `App::logic` while hidden, which is where tray clicks and
//! "show yourself" requests are handled.

use std::collections::HashMap;
use std::sync::atomic::{AtomicBool, Ordering};
use std::sync::mpsc::{Receiver, Sender, channel};
use std::sync::{Arc, Mutex};

use eframe::egui::{self, Margin, RichText, Stroke, vec2};
use tray_icon::menu::{CheckMenuItem, Menu, MenuEvent, MenuId, MenuItem, PredefinedMenuItem};
use tray_icon::{TrayIcon, TrayIconBuilder, TrayIconEvent};

use crate::config::{self, forwards_text, parse_domains, parse_forwards};
use crate::core::{Core, ForwardStatus, Machine, Status, TailnetStatus};
use crate::i18n::{self, tr};
use crate::icon;
use crate::sync::lock;
use crate::theme::{self, Tone, icons, muted, with_icon};

#[derive(Clone, Debug)]
pub(crate) enum Action {
    Open,
    Add,
    Login(String),
    ToggleMaster,
    Quit,
}

pub(crate) type ActionMap = Arc<Mutex<HashMap<MenuId, Action>>>;

#[derive(PartialEq, Clone, Copy)]
enum Tab {
    Tailnets,
    Settings,
}

enum Dialog {
    None,
    Info(String, String),
    Error(String),
    Edit {
        id: String,
        label: String,
        name: String,
        extra: String,
        enabled: bool,
    },
    ConfirmRemove {
        id: String,
        label: String,
    },
    ConfirmLogout {
        id: String,
        label: String,
    },
    /// Forward a local port to a machine (from its row in the machine list).
    AddForward {
        host: String,
        port: String,
    },
    ForwardAdded {
        local: u16,
        target: String,
    },
}

/// Results of work done on background threads.
enum Done {
    Error(String),
    Started,
    Check(Result<String, String>),
}

/// Common ports offered when forwarding to a machine. Only Remote Desktop's
/// name is translated (see `preset_name`); the others are product names.
const PORT_PRESETS: [(&str, u16); 6] =
    [("Remote Desktop", 3389), ("SSH", 22), ("VNC", 5900), ("PostgreSQL", 5432), ("MySQL", 3306), ("SQL Server", 1433)];

/// How long a toast ("Copied …") stays up.
const TOAST_FOR: std::time::Duration = std::time::Duration::from_millis(1800);

fn preset_name(name: &str, port: u16) -> String {
    if port == 3389 { tr!("port-preset-remote-desktop") } else { name.to_owned() }
}

/// The system proxy choices, in the order of `SYS_VALUES`.
fn sys_labels() -> [String; 3] {
    [tr!("proxy-on"), tr!("proxy-force"), tr!("proxy-off")]
}
const SYS_VALUES: [&str; 3] = ["on", "force", "off"];

pub struct Gui {
    core: Arc<Core>,
    tab: Tab,
    dialog: Dialog,
    started: bool,
    logo: egui::TextureHandle,
    // Settings tab (edited locally until Save)
    forwards: String,
    sys_mode: usize,
    autostart: bool,
    /// The language setting: a catalog code, or "auto". Applied as soon as it's picked.
    language: String,
    // "Test a name or address" (Settings)
    check_input: String,
    check_result: Option<Result<String, String>>,
    checking: bool,
    // Machine search (Tailnets tab)
    machine_query: String,
    /// A short note at the bottom of the window ("Copied …").
    toast: Option<(String, std::time::Instant)>,
    // Tray
    tray: Option<Tray>,
    tray_version: u64,
    actions: ActionMap,
    menu_rx: Receiver<MenuId>,
    show_rx: Receiver<()>,
    done_tx: Sender<Done>,
    done_rx: Receiver<Done>,
    hidden: bool,
    /// The window's close button was pressed; handled in `logic`.
    close_requested: bool,
    quitting: Arc<AtomicBool>,
}

impl Gui {
    /// `start_hidden`: launched at login (--background): stay in the tray.
    pub fn new(cc: &eframe::CreationContext<'_>, core: Arc<Core>, start_hidden: bool) -> Gui {
        let ctx = cc.egui_ctx.clone();
        let cfg = core.config();
        theme::apply(&ctx, i18n::set_language(&cfg.language));

        // Background changes (status, tray clicks, second launch) wake the UI.
        let c2 = ctx.clone();
        core.set_on_change(move || c2.request_repaint());

        let (show_tx, show_rx) = channel();
        let c3 = ctx.clone();
        core.set_on_show(move || {
            let _ = show_tx.send(());
            c3.request_repaint();
        });

        let (menu_tx, menu_rx) = channel();
        let c4 = ctx.clone();
        MenuEvent::set_event_handler(Some(move |e: MenuEvent| {
            let _ = menu_tx.send(e.id);
            c4.request_repaint();
        }));
        // Left-click on the tray icon opens the window.
        let core5 = core.clone();
        TrayIconEvent::set_event_handler(Some(move |e: TrayIconEvent| {
            if let TrayIconEvent::Click {
                button: tray_icon::MouseButton::Left,
                button_state: tray_icon::MouseButtonState::Up,
                ..
            } = e
            {
                core5.request_show();
            }
        }));

        let actions: ActionMap = Arc::default();
        #[cfg(target_os = "linux")]
        linux_tray::spawn(core.clone(), actions.clone());

        let (done_tx, done_rx) = channel();

        // Start the engine in the background (starting tailnets takes a moment).
        if !demo() {
            let (core2, tx2, c6) = (core.clone(), done_tx.clone(), ctx.clone());
            std::thread::spawn(move || {
                let r = core2.start();
                let _ = tx2.send(match r {
                    Ok(()) => Done::Started,
                    Err(e) => Done::Error(tr!("start-failed", error = e)),
                });
                c6.request_repaint();
            });
        }

        const LOGO: u32 = 128;
        let logo = ctx.load_texture(
            "logo",
            egui::ColorImage::from_rgba_unmultiplied([LOGO as usize; 2], &icon::app(LOGO)),
            egui::TextureOptions::LINEAR,
        );

        let mut gui = Gui {
            core,
            tab: Tab::Tailnets,
            dialog: Dialog::None,
            started: false,
            logo,
            forwards: forwards_text(&cfg.forwards),
            sys_mode: SYS_VALUES.iter().position(|v| *v == cfg.system_proxy).unwrap_or(0),
            autostart: crate::autostart::enabled(),
            language: cfg.language.clone(),
            check_input: String::new(),
            check_result: None,
            checking: false,
            machine_query: String::new(),
            toast: None,
            tray: None,
            tray_version: u64::MAX,
            actions,
            menu_rx,
            show_rx,
            done_tx,
            done_rx,
            hidden: false,
            close_requested: false,
            quitting: Arc::new(AtomicBool::new(false)),
        };
        if start_hidden {
            gui.hide_window(&ctx);
        }
        #[cfg(feature = "screenshots")]
        if crate::demo::active() {
            use crate::demo::View;
            gui.started = true;
            gui.autostart = true;
            match crate::demo::view() {
                View::Settings => gui.tab = Tab::Settings,
                View::Forward => {
                    gui.dialog = Dialog::ForwardAdded { local: 50321, target: "build-pc.home.example:3389".into() };
                }
                View::Welcome | View::Tailnets | View::SignIn => {}
            }
        }
        gui
    }

    /// The engine's status, or the made-up one in screenshot mode.
    fn status(&self) -> Status {
        #[cfg(feature = "screenshots")]
        if crate::demo::active() {
            return crate::demo::status();
        }
        self.core.status()
    }

    fn show_window(&mut self, ctx: &egui::Context) {
        self.hidden = false;
        ctx.send_viewport_cmd(egui::ViewportCommand::Visible(true));
        ctx.send_viewport_cmd(egui::ViewportCommand::Minimized(false));
        ctx.send_viewport_cmd(egui::ViewportCommand::Focus);
    }

    fn hide_window(&mut self, ctx: &egui::Context) {
        self.hidden = true;
        ctx.send_viewport_cmd(egui::ViewportCommand::Visible(false));
    }

    fn quit(&mut self, ctx: &egui::Context) {
        self.quitting.store(true, Ordering::SeqCst);
        self.core.shutdown();
        ctx.send_viewport_cmd(egui::ViewportCommand::Close);
        // Belt and braces if the window is hidden and the close doesn't arrive.
        std::thread::spawn(|| {
            std::thread::sleep(std::time::Duration::from_secs(2));
            std::process::exit(0);
        });
    }

    fn run(&mut self, ctx: &egui::Context, action: Action) {
        match action {
            Action::Open => self.show_window(ctx),
            Action::Add => self.add_tailnet(ctx),
            Action::Login(id) => self.core.login(&id),
            Action::ToggleMaster => self.core.set_enabled(!self.core.config().enabled),
            Action::Quit => self.quit(ctx),
        }
    }

    fn toast(&mut self, text: impl Into<String>) {
        self.toast = Some((text.into(), std::time::Instant::now()));
    }

    /// Copies an address and says so.
    fn copy(&mut self, ctx: &egui::Context, address: &str) {
        ctx.copy_text(address.to_owned());
        self.toast(tr!("copied-address", address = address));
    }

    /// The Settings tab has edits that aren't saved yet.
    fn settings_dirty(&self) -> bool {
        let cfg = self.core.config();
        parse_forwards(&self.forwards).map_or(true, |f| f != cfg.forwards)
            || SYS_VALUES[self.sys_mode] != cfg.system_proxy
    }

    fn revert_settings(&mut self) {
        let cfg = self.core.config();
        self.forwards = forwards_text(&cfg.forwards);
        self.sys_mode = SYS_VALUES.iter().position(|v| *v == cfg.system_proxy).unwrap_or(0);
    }

    /// Adds a forward right away (from the machine list) and shows its port.
    fn add_forward(&mut self, target: String) {
        let dirty = self.settings_dirty();
        match self.core.add_forward(&target) {
            Ok(local) => {
                if dirty {
                    // Keep the user's unsaved edits, plus the new line.
                    let line = format!("{local} = {target}");
                    if !self.forwards.lines().any(|l| l.trim() == line) {
                        if !self.forwards.is_empty() && !self.forwards.ends_with('\n') {
                            self.forwards.push('\n');
                        }
                        self.forwards.push_str(&line);
                    }
                } else {
                    self.forwards = forwards_text(&self.core.config().forwards);
                }
                self.dialog = Dialog::ForwardAdded { local, target };
            }
            Err(e) => self.dialog = Dialog::Error(tr!("add-forward-failed", error = e)),
        }
    }

    fn start_check(&mut self, ctx: &egui::Context) {
        if self.checking || self.check_input.trim().is_empty() {
            return;
        }
        self.checking = true;
        self.check_result = None;
        let (core, input, tx, c) = (self.core.clone(), self.check_input.clone(), self.done_tx.clone(), ctx.clone());
        std::thread::spawn(move || {
            let _ = tx.send(Done::Check(core.check(&input)));
            c.request_repaint();
        });
    }

    fn add_tailnet(&mut self, ctx: &egui::Context) {
        let (core, tx, c) = (self.core.clone(), self.done_tx.clone(), ctx.clone());
        std::thread::spawn(move || {
            if let Err(e) = core.add_tailnet() {
                let _ = tx.send(Done::Error(tr!("add-tailnet-failed", error = e)));
                c.request_repaint();
            }
        });
        self.dialog = Dialog::Info(tr!("sign-in-dialog-title"), tr!("sign-in-dialog-text"));
    }
}

impl eframe::App for Gui {
    /// Runs every frame, and also while the window is hidden.
    fn logic(&mut self, ctx: &egui::Context, _frame: &mut eframe::Frame) {
        // The tray lives on this (main) thread on Windows and macOS.
        #[cfg(not(target_os = "linux"))]
        if self.tray.is_none() && !demo() {
            match Tray::new(self.actions.clone()) {
                Ok(t) => self.tray = Some(t),
                Err(e) => log::warn!("tray icon: {e}"),
            }
        }
        let v = self.core.version();
        if v != self.tray_version {
            self.tray_version = v;
            if let Some(t) = self.tray.as_mut() {
                t.refresh(&self.core.status());
            }
        }

        while let Ok(id) = self.menu_rx.try_recv() {
            let action = lock(&self.actions).get(&id).cloned();
            if let Some(a) = action {
                self.run(ctx, a);
            }
        }
        while self.show_rx.try_recv().is_ok() {
            self.show_window(ctx);
        }
        while let Ok(d) = self.done_rx.try_recv() {
            match d {
                Done::Started => self.started = true,
                Done::Check(r) => {
                    self.checking = false;
                    self.check_result = Some(r);
                }
                Done::Error(e) => {
                    self.dialog = Dialog::Error(e);
                    self.show_window(ctx);
                }
            }
        }

        // Closing the window keeps the app running in the tray. The first time,
        // a system notification says where to find it.
        if std::mem::take(&mut self.close_requested) {
            // On Linux the tray lives on its own thread.
            if cfg!(target_os = "linux") || self.tray.is_some() {
                self.hide_window(ctx);
                if !self.core.config().background_hint_shown {
                    notify_still_running(self.tray.as_ref());
                    self.core.mark_background_hint_shown();
                }
            } else {
                // Without a tray icon a hidden window couldn't be brought back.
                ctx.send_viewport_cmd(egui::ViewportCommand::Minimized(true));
            }
        }

        // Keep status fresh while visible.
        if !self.hidden {
            ctx.request_repaint_after(std::time::Duration::from_secs(1));
        }
    }

    /// Takes the close button's event out of the input, so eframe never quits on
    /// it, and leaves it for `logic` to hide the window instead. (`logic` can't
    /// read it itself: while the window is minimized or covered, eframe holds the
    /// input back and hands it over again on the next frame.)
    fn raw_input_hook(&mut self, _ctx: &egui::Context, input: &mut egui::RawInput) {
        if !self.quitting.load(Ordering::SeqCst)
            && !demo()
            && let Some(viewport) = input.viewports.get_mut(&input.viewport_id)
            && viewport.close_requested()
        {
            viewport.events.retain(|e| *e != egui::ViewportEvent::Close);
            self.close_requested = true;
        }
        #[cfg(feature = "screenshots")]
        if crate::demo::active() {
            crate::demo::isolate_input(input);
        }
    }

    fn ui(&mut self, ui: &mut egui::Ui, _frame: &mut eframe::Frame) {
        let ctx = ui.ctx().clone();
        #[cfg(feature = "screenshots")]
        crate::demo::capture(&ctx);
        let status = self.status();
        self.header(ui);
        if self.tab == Tab::Settings && self.settings_dirty() {
            self.save_bar(ui);
        }
        egui::CentralPanel::default_margins()
            .frame(egui::Frame::new().fill(theme::BG).inner_margin(Margin { left: 16, right: 16, top: 14, bottom: 0 }))
            .show(ui, |ui| match self.tab {
                Tab::Tailnets => self.tailnets_tab(ui, &ctx, &status),
                Tab::Settings => self.settings_tab(ui, &status),
            });
        self.dialogs(&ctx);
        self.show_toast(&ctx);
    }

    fn on_exit(&mut self) {
        if !self.quitting.swap(true, Ordering::SeqCst) {
            self.core.shutdown();
        }
    }
}

// ---- Window chrome ----

impl Gui {
    fn header(&mut self, ui: &mut egui::Ui) {
        let panel = egui::Panel::top("header")
            .frame(egui::Frame::new().fill(theme::SURFACE).inner_margin(Margin::symmetric(16, 10)))
            .show(ui, |ui| {
                ui.horizontal(|ui| {
                    ui.add(egui::Image::from_texture(&self.logo).fit_to_exact_size(vec2(28.0, 28.0)));
                    ui.label(RichText::new("Tailnet Link").size(17.0).strong().color(theme::STRONG));
                    ui.with_layout(egui::Layout::right_to_left(egui::Align::Center), |ui| {
                        egui::Frame::new().fill(theme::RAISED).corner_radius(8).inner_margin(3).show(ui, |ui| {
                            ui.spacing_mut().item_spacing.x = 2.0;
                            // Right to left: Settings is added first so it sits on the right.
                            for (tab, symbol, label) in [
                                (Tab::Settings, icons::GEAR_SIX, tr!("tab-settings")),
                                (Tab::Tailnets, icons::SHARE_NETWORK, tr!("tab-tailnets")),
                            ] {
                                let selected = self.tab == tab;
                                let text = RichText::new(with_icon(symbol, &label)).color(if selected {
                                    theme::STRONG
                                } else {
                                    theme::MUTED
                                });
                                let button = egui::Button::selectable(selected, text)
                                    .min_size(vec2(0.0, 28.0))
                                    .corner_radius(6)
                                    .frame_when_inactive(selected);
                                if ui.add(button).clicked() {
                                    self.tab = tab;
                                }
                            }
                        });
                    });
                });
            });
        let rect = panel.response.rect;
        ui.painter().hline(rect.x_range(), rect.bottom(), Stroke::new(1.0, theme::BORDER));
    }

    /// Shown at the bottom of Settings while there are unsaved edits.
    fn save_bar(&mut self, ui: &mut egui::Ui) {
        let ctrl_s =
            ui.input_mut(|i| i.consume_shortcut(&egui::KeyboardShortcut::new(egui::Modifiers::COMMAND, egui::Key::S)));
        let mut save = ctrl_s;
        egui::Panel::bottom("save-bar")
            .frame(egui::Frame::new().fill(theme::NOTE_BG).inner_margin(Margin::symmetric(16, 10)))
            .show(ui, |ui| {
                ui.horizontal(|ui| {
                    ui.label(RichText::new(icons::INFO).size(16.0).color(theme::ACCENT));
                    ui.label(tr!("unsaved-changes"));
                    ui.with_layout(egui::Layout::right_to_left(egui::Align::Center), |ui| {
                        save |= ui.add(theme::primary_button(tr!("save"))).on_hover_text("Ctrl+S").clicked();
                        if ui.add(theme::secondary_button(tr!("revert"))).on_hover_text(tr!("revert-tooltip")).clicked()
                        {
                            self.revert_settings();
                        }
                    });
                });
            });
        if save {
            self.save_settings();
        }
    }

    fn show_toast(&mut self, ctx: &egui::Context) {
        let Some((msg, at)) = &self.toast else { return };
        if at.elapsed() > TOAST_FOR {
            self.toast = None;
            return;
        }
        egui::Area::new(egui::Id::unique("tailnet-link-toast"))
            .anchor(egui::Align2::CENTER_BOTTOM, vec2(0.0, -22.0))
            .order(egui::Order::Tooltip)
            .show(ctx, |ui| {
                egui::Frame::new()
                    .fill(theme::RAISED)
                    .stroke(Stroke::new(1.0, theme::PANEL_EDGE))
                    .corner_radius(18)
                    .inner_margin(Margin::symmetric(14, 8))
                    .shadow(egui::epaint::Shadow {
                        offset: [0, 6],
                        blur: 20,
                        spread: 0,
                        color: egui::Color32::from_black_alpha(110),
                    })
                    .show(ui, |ui| {
                        ui.horizontal(|ui| {
                            ui.label(RichText::new(icons::CHECK).color(Tone::Good.color()));
                            ui.label(msg.as_str());
                        });
                    });
            });
        ctx.request_repaint_after(std::time::Duration::from_millis(200));
    }
}

/// README screenshot mode (see demo.rs).
fn demo() -> bool {
    #[cfg(feature = "screenshots")]
    {
        crate::demo::active()
    }
    #[cfg(not(feature = "screenshots"))]
    {
        false
    }
}

/// Where the settings live, as Troubleshooting shows it. Screenshots show a made-up user's folder.
fn settings_dir_text() -> String {
    if demo() {
        r"C:\Users\ana\AppData\Roaming\Tailnet Link".to_owned()
    } else {
        config::config_dir().display().to_string()
    }
}

/// Remote Desktop to 127.0.0.1:port (Windows only).
fn remote_desktop(local: u16) -> Result<(), String> {
    #[cfg(windows)]
    {
        std::process::Command::new("mstsc")
            .arg(format!("/v:127.0.0.1:{local}"))
            .spawn()
            .map(|_| ())
            .map_err(|e| tr!("remote-desktop-failed", error = e.to_string()))
    }
    #[cfg(not(windows))]
    {
        let _ = local;
        Err(tr!("remote-desktop-windows-only"))
    }
}

/// The port part of host:port.
fn target_port(target: &str) -> u16 {
    crate::proxy::split_host_port(target, 0).1
}

/// Tailscale reports "windows", "linux", "macOS", "iOS"...: capitalise the lowercase ones.
fn os_name(os: &str) -> String {
    let mut chars = os.chars();
    match chars.next() {
        Some(first) if first.is_lowercase() && os.chars().skip(1).all(char::is_lowercase) => {
            first.to_uppercase().chain(chars).collect()
        }
        _ => os.to_owned(),
    }
}

// ---- Status wording ----

/// The app as a whole, as the tray icon shows it.
fn status_tone(s: &Status) -> Tone {
    if s.routing && !s.any_needs_login() {
        Tone::Good
    } else if s.any_needs_login() {
        Tone::Warn
    } else if !s.problem.is_empty() {
        Tone::Bad
    } else {
        Tone::Idle
    }
}

/// One tailnet's state as a short label.
fn tailnet_state(t: &TailnetStatus) -> (Tone, String) {
    if t.needs_login() && t.login_wait {
        (Tone::Warn, tr!("state-waiting-sign-in"))
    } else if t.needs_login() {
        (Tone::Warn, tr!("state-signed-out"))
    } else if !t.problem.is_empty() && !t.connected {
        (Tone::Bad, tr!("state-problem"))
    } else if !t.connected {
        (Tone::Idle, tr!("state-connecting"))
    } else if !t.enabled {
        (Tone::Idle, tr!("state-paused"))
    } else if t.domains.is_empty() {
        (Tone::Idle, tr!("state-no-domain"))
    } else if !t.routing {
        (Tone::Idle, tr!("state-not-routing"))
    } else {
        (Tone::Good, tr!("state-routing"))
    }
}

/// The status card's title and explanation.
fn hero_text(s: &Status, started: bool) -> (Tone, String, String) {
    if !started {
        return (Tone::Idle, tr!("hero-starting"), tr!("hero-connecting"));
    }
    if !s.enabled {
        return (Tone::Idle, tr!("summary-paused"), tr!("hero-paused"));
    }
    if let Some(t) = s.tailnets.iter().find(|t| t.needs_login()) {
        let detail = if t.login_wait {
            tr!("hero-finish-sign-in", tailnet = t.label())
        } else {
            tr!("hero-sign-in", tailnet = t.label())
        };
        return (Tone::Warn, s.summary(), detail);
    }
    let tone = status_tone(s);
    let detail = match tone {
        Tone::Good => {
            let example = s
                .tailnets
                .iter()
                .filter(|t| t.routing)
                .find_map(|t| t.machines.iter().find(|m| m.online).map(|m| m.dns_name.clone()))
                .or_else(|| {
                    s.tailnets.iter().find(|t| t.routing).and_then(|t| t.domains.first()).map(|d| format!("*.{d}"))
                });
            match example {
                Some(e) => tr!("hero-routing-example", address = e),
                None => tr!("hero-routing"),
            }
        }
        Tone::Bad => s.problem.clone(),
        _ => tr!("hero-connecting"),
    };
    (tone, s.summary(), detail)
}

// ---- Tailnets tab ----

impl Gui {
    fn tailnets_tab(&mut self, ui: &mut egui::Ui, ctx: &egui::Context, s: &Status) {
        if s.tailnets.is_empty() && self.started {
            egui::ScrollArea::vertical().auto_shrink([false, false]).show(ui, |ui| self.empty_state(ui, ctx));
            return;
        }
        self.status_card(ui, ctx, s);
        ui.add_space(4.0);
        if s.tailnets.iter().any(|t| !t.machines.is_empty()) {
            ui.horizontal(|ui| {
                let clear = !self.machine_query.is_empty();
                let w = ui.available_width() - if clear { 38.0 } else { 0.0 };
                ui.add(
                    egui::TextEdit::singleline(&mut self.machine_query)
                        .hint_text(with_icon(icons::MAGNIFYING_GLASS, &tr!("machine-search-hint")))
                        .margin(Margin::symmetric(10, 7))
                        .desired_width(w),
                );
                if clear && ui.add(theme::icon_button(icons::X)).on_hover_text(tr!("clear-search")).clicked() {
                    self.machine_query.clear();
                }
            });
            ui.add_space(4.0);
        }
        egui::ScrollArea::vertical().auto_shrink([false, false]).show(ui, |ui| {
            for t in &s.tailnets {
                self.tailnet_card(ui, t);
                ui.add_space(4.0);
            }
            ui.add_space(12.0);
        });
    }

    fn status_card(&mut self, ui: &mut egui::Ui, ctx: &egui::Context, s: &Status) {
        let (tone, title, detail) = hero_text(s, self.started);
        theme::card().show(ui, |ui| {
            ui.set_width(ui.available_width());
            ui.horizontal(|ui| {
                ui.label(RichText::new(tone.symbol()).size(30.0).color(tone.color()));
                ui.add_space(2.0);
                // The buttons' width from the last frame, so the text wraps beside them in
                // every language rather than under them.
                let actions_id = egui::Id::unique("status-actions-width");
                let actions_w = ui.data(|d| d.get_temp::<f32>(actions_id)).unwrap_or(250.0);
                ui.vertical(|ui| {
                    ui.set_max_width((ui.available_width() - actions_w - 12.0).max(160.0));
                    ui.label(RichText::new(title).size(18.0).strong().color(theme::STRONG));
                    ui.add(egui::Label::new(muted(detail)).wrap());
                });
                let actions = ui.with_layout(egui::Layout::right_to_left(egui::Align::Center), |ui| {
                    if ui.add(theme::primary_button(with_icon(icons::PLUS, &tr!("add-tailnet")))).clicked() {
                        self.add_tailnet(ctx);
                    }
                    let (symbol, label, tip) = if s.enabled {
                        (icons::PAUSE_CIRCLE, tr!("pause-all"), tr!("pause-all-tooltip"))
                    } else {
                        (icons::PLAY_CIRCLE, tr!("resume"), tr!("resume-tooltip"))
                    };
                    if ui.add(theme::secondary_button(with_icon(symbol, &label))).on_hover_text(tip).clicked() {
                        self.core.set_enabled(!s.enabled);
                    }
                });
                let width = actions.response.rect.width();
                if (width - actions_w).abs() > 0.5 {
                    ui.data_mut(|d| d.insert_temp(actions_id, width));
                    ui.ctx().request_repaint();
                }
            });
        });
    }

    fn empty_state(&mut self, ui: &mut egui::Ui, ctx: &egui::Context) {
        let steps = [
            (icons::SIGN_IN, tr!("welcome-sign-in"), tr!("welcome-sign-in-detail")),
            (icons::GLOBE, tr!("welcome-open"), tr!("welcome-open-detail", example = "build-pc.example.ts.net")),
            (icons::PLUGS_CONNECTED, tr!("welcome-forward"), tr!("welcome-forward-detail")),
        ];
        ui.add_space(20.0);
        ui.vertical_centered(|ui| {
            ui.set_max_width(540.0);
            theme::card().inner_margin(24).show(ui, |ui| {
                ui.with_layout(egui::Layout::top_down(egui::Align::Min), |ui| {
                    ui.set_width(ui.available_width());
                    ui.label(RichText::new(tr!("welcome-title")).size(20.0).strong().color(theme::STRONG));
                    ui.add(egui::Label::new(muted(tr!("welcome-text"))).wrap());
                    ui.add_space(10.0);
                    for (symbol, title, text) in steps {
                        ui.horizontal(|ui| {
                            let (rect, _) = ui.allocate_exact_size(vec2(34.0, 34.0), egui::Sense::hover());
                            ui.painter().circle_filled(rect.center(), 17.0, theme::NOTE_BG);
                            ui.painter().text(
                                rect.center(),
                                egui::Align2::CENTER_CENTER,
                                symbol,
                                egui::FontId::proportional(17.0),
                                theme::ACCENT,
                            );
                            ui.add_space(4.0);
                            ui.vertical(|ui| {
                                ui.spacing_mut().item_spacing.y = 2.0;
                                ui.label(RichText::new(title).strong().color(theme::STRONG));
                                ui.add(egui::Label::new(muted(text)).wrap());
                            });
                        });
                        ui.add_space(4.0);
                    }
                    ui.add_space(10.0);
                    if ui
                        .add(
                            theme::primary_button(with_icon(icons::PLUS, &tr!("add-tailnet")))
                                .min_size(vec2(160.0, 38.0)),
                        )
                        .clicked()
                    {
                        self.add_tailnet(ctx);
                    }
                });
            });
        });
    }

    fn tailnet_card(&mut self, ui: &mut egui::Ui, t: &TailnetStatus) {
        let (tone, state) = tailnet_state(t);
        theme::card().show(ui, |ui| {
            ui.set_width(ui.available_width());
            ui.horizontal(|ui| {
                ui.label(RichText::new(t.label()).size(16.0).strong().color(theme::STRONG));
                theme::pill(ui, tone, &state);
                ui.with_layout(egui::Layout::right_to_left(egui::Align::Center), |ui| {
                    egui::containers::menu::MenuButton::from_button(theme::icon_button(icons::DOTS_THREE))
                        .ui(ui, |ui| {
                            ui.set_min_width(200.0);
                            if ui.button(with_icon(icons::PENCIL_SIMPLE, &tr!("edit-tailnet-menu"))).clicked() {
                                self.dialog = Dialog::Edit {
                                    id: t.id.clone(),
                                    label: t.label(),
                                    name: t.name.clone(),
                                    extra: t.extra.join("\n"),
                                    enabled: t.enabled,
                                };
                            }
                            if t.connected && ui.button(with_icon(icons::SIGN_OUT, &tr!("log-out-menu"))).clicked() {
                                self.dialog = Dialog::ConfirmLogout { id: t.id.clone(), label: t.label() };
                            }
                            if ui
                                .button(
                                    RichText::new(with_icon(icons::TRASH, &tr!("remove-menu"))).color(theme::DANGER),
                                )
                                .clicked()
                            {
                                self.dialog = Dialog::ConfirmRemove { id: t.id.clone(), label: t.label() };
                            }
                        })
                        .0
                        .on_hover_text(tr!("more-actions"));
                    if t.needs_login() {
                        if ui.add(theme::primary_button(with_icon(icons::SIGN_IN, &tr!("sign-in")))).clicked() {
                            self.core.login(&t.id);
                        }
                    } else if t.connected {
                        let (symbol, tip) = if t.enabled {
                            (icons::PAUSE_CIRCLE, tr!("pause-tailnet"))
                        } else {
                            (icons::PLAY_CIRCLE, tr!("resume-tailnet"))
                        };
                        if ui.add(theme::icon_button(symbol)).on_hover_text(tip).clicked() {
                            let _ = self.core.set_tailnet_enabled(&t.id, !t.enabled);
                        }
                    }
                });
            });

            let routes = if t.domains.is_empty() {
                tr!("routes-after-sign-in")
            } else {
                t.domains.iter().map(|d| format!("*.{d}")).collect::<Vec<_>>().join(", ")
            };
            let self_name = if t.self_name.is_empty() {
                tr!("hostname-after-sign-in", hostname = self.core.config().hostname)
            } else {
                t.self_name.clone()
            };
            // (label, value, is a problem)
            let mut rows = Vec::new();
            if !t.name.is_empty() && !t.tailnet.is_empty() && t.name != t.tailnet {
                rows.push((tr!("detail-tailnet"), t.tailnet.clone(), false));
            }
            rows.push((tr!("detail-routes"), routes, false));
            rows.push((tr!("detail-this-computer"), self_name, false));
            if !t.problem.is_empty() && !t.connected {
                rows.push((tr!("detail-problem"), t.problem.clone(), true));
            }
            egui::Grid::new(("details", &t.id)).num_columns(2).spacing([16.0, 2.0]).min_row_height(20.0).show(
                ui,
                |ui| {
                    for (k, v, problem) in rows {
                        ui.label(muted(k));
                        let text = if problem { RichText::new(v).color(Tone::Bad.color()) } else { RichText::new(v) };
                        ui.add(egui::Label::new(text).wrap());
                        ui.end_row();
                    }
                },
            );

            if !t.auth_url.is_empty() {
                ui.add_space(2.0);
                theme::note_frame().show(ui, |ui| {
                    ui.set_width(ui.available_width());
                    ui.horizontal_wrapped(|ui| {
                        ui.label(RichText::new(icons::INFO).color(theme::ACCENT));
                        ui.label(tr!("sign-in-help"));
                        if ui.link(tr!("sign-in-open-again")).clicked() {
                            let _ = open::that_detached(&t.auth_url);
                        }
                        if ui.link(tr!("sign-in-copy-link")).on_hover_text(tr!("sign-in-copy-link-tooltip")).clicked() {
                            ui.ctx().copy_text(t.auth_url.clone());
                            self.toast(tr!("copied-sign-in-link"));
                        }
                    });
                });
            }
            if t.connected {
                self.machine_list(ui, t);
            }
        });
    }

    fn machine_list(&mut self, ui: &mut egui::Ui, t: &TailnetStatus) {
        let searching = !self.machine_query.trim().is_empty();
        let shown: Vec<&Machine> = t.machines.iter().filter(|m| m.matches(&self.machine_query)).collect();
        let online = t.machines.iter().filter(|m| m.online).count();
        let title = if searching {
            tr!("machines-matching", shown = shown.len(), total = t.machines.len())
        } else {
            tr!("machines-online", online = online, total = t.machines.len())
        };
        egui::CollapsingHeader::new(RichText::new(title).strong().color(theme::MUTED))
            .id_salt(("machines", &t.id))
            .default_open(true)
            .open(searching.then_some(!shown.is_empty()))
            .show(ui, |ui| {
                if t.machines.is_empty() {
                    ui.label(muted(tr!("no-machines")));
                    return;
                }
                if shown.is_empty() {
                    ui.label(muted(tr!("no-machine-matches")));
                    return;
                }
                egui::ScrollArea::vertical()
                    .id_salt(("machine-scroll", &t.id))
                    .max_height(320.0)
                    .auto_shrink([false, true])
                    .show(ui, |ui| {
                        ui.spacing_mut().item_spacing.y = 4.0;
                        for m in shown {
                            self.machine_row(ui, t, m);
                        }
                    });
            });
    }

    fn machine_row(&mut self, ui: &mut egui::Ui, t: &TailnetStatus, m: &Machine) {
        theme::row_frame(false).show(ui, |ui| {
            ui.set_width(ui.available_width());
            ui.horizontal(|ui| {
                theme::dot(ui, if m.online { Tone::Good } else { Tone::Idle });
                let name = RichText::new(&m.name).strong();
                ui.label(if m.online { name.color(theme::STRONG) } else { name.color(theme::MUTED) }).on_hover_text(
                    if m.online { m.dns_name.clone() } else { tr!("machine-offline", name = m.dns_name.as_str()) },
                );
                ui.label(muted(format!("{}  {}", os_name(&m.os), m.ip)).size(12.0));
                ui.with_layout(egui::Layout::right_to_left(egui::Align::Center), |ui| {
                    ui.spacing_mut().item_spacing.x = 2.0;
                    if ui
                        .add(theme::icon_button(icons::PLUGS_CONNECTED))
                        .on_hover_text(tr!("forward-port-tooltip"))
                        .clicked()
                    {
                        self.dialog = Dialog::AddForward { host: m.dns_name.clone(), port: String::new() };
                    }
                    if ui
                        .add(theme::icon_button(icons::COPY))
                        .on_hover_text(tr!("copy-address", address = m.dns_name.as_str()))
                        .clicked()
                    {
                        self.copy(ui.ctx(), &m.dns_name);
                    }
                    let url = format!("https://{}/", m.dns_name);
                    if ui
                        .add_enabled(t.routing, theme::icon_button(icons::ARROW_SQUARE_OUT))
                        .on_hover_text(tr!("open-in-browser", url = url.as_str()))
                        .on_disabled_hover_text(tr!("not-routing-tooltip"))
                        .clicked()
                    {
                        let _ = open::that_detached(&url);
                    }
                });
            });
        });
    }
}

// ---- Settings tab ----

impl Gui {
    fn settings_tab(&mut self, ui: &mut egui::Ui, s: &Status) {
        egui::ScrollArea::vertical().auto_shrink([false, false]).show(ui, |ui| {
            ui.spacing_mut().item_spacing.y = 8.0;
            self.forwards_section(ui, s);
            ui.add_space(4.0);
            self.proxy_section(ui);
            ui.add_space(4.0);
            self.general_section(ui);
            ui.add_space(4.0);
            self.troubleshooting_section(ui, s);
            ui.add_space(16.0);
        });
    }

    fn forwards_section(&mut self, ui: &mut egui::Ui, s: &Status) {
        theme::card().show(ui, |ui| {
            ui.set_width(ui.available_width());
            theme::section_heading(ui, icons::PLUGS_CONNECTED, &tr!("forwards-heading"), Some(&tr!("forwards-help")));
            if !s.forwards.is_empty() {
                ui.spacing_mut().item_spacing.y = 4.0;
                for f in &s.forwards {
                    self.forward_row(ui, f);
                }
                ui.spacing_mut().item_spacing.y = 8.0;
                ui.add_space(4.0);
            }
            ui.label(RichText::new(tr!("edit-forwards")).strong());
            ui.add(
                egui::TextEdit::multiline(&mut self.forwards)
                    .code_editor()
                    .desired_rows(3)
                    .desired_width(f32::INFINITY)
                    .margin(Margin::symmetric(10, 8))
                    .hint_text("auto = build-pc.example.ts.net:3389"),
            );
            ui.add(egui::Label::new(muted(tr!("forwards-format-help")).size(12.0)).wrap());
        });
    }

    fn proxy_section(&mut self, ui: &mut egui::Ui) {
        theme::card().show(ui, |ui| {
            ui.set_width(ui.available_width());
            theme::section_heading(ui, icons::GLOBE_SIMPLE, &tr!("proxy-heading"), Some(&proxy_help()));
            ui.spacing_mut().item_spacing.y = 2.0;
            for (i, label) in sys_labels().into_iter().enumerate() {
                ui.radio_value(&mut self.sys_mode, i, label);
            }
        });
    }

    fn general_section(&mut self, ui: &mut egui::Ui) {
        theme::card().show(ui, |ui| {
            ui.set_width(ui.available_width());
            theme::section_heading(ui, icons::GEAR_SIX, &tr!("general-heading"), None);
            let before = self.autostart;
            let start_at_login = tr!("start-at-login");
            ui.horizontal(|ui| {
                ui.add_enabled_ui(crate::autostart::supported(), |ui| {
                    theme::toggle(ui, &mut self.autostart, &start_at_login);
                });
                ui.label(&start_at_login);
            });
            if self.autostart != before
                && let Err(e) = crate::autostart::set(self.autostart)
            {
                self.autostart = before;
                self.dialog = Dialog::Error(e);
            }
            ui.add_space(4.0);
            self.language_picker(ui);
        });
    }

    /// Applies the new language straight away, like the toggle above it.
    fn language_picker(&mut self, ui: &mut egui::Ui) {
        let before = self.language.clone();
        ui.horizontal(|ui| {
            ui.label(tr!("language"));
            let name = |code: &str| if code == "auto" { tr!("system-default") } else { i18n::language_name(code) };
            egui::ComboBox::from_id_salt("language").selected_text(name(&self.language)).width(260.0).show_ui(
                ui,
                |ui| {
                    for code in std::iter::once("auto").chain(i18n::languages()) {
                        ui.selectable_value(&mut self.language, code.to_owned(), name(code));
                    }
                },
            );
        });
        if self.language != before {
            theme::set_fonts(ui.ctx(), i18n::set_language(&self.language));
            if let Err(e) = self.core.set_language(&self.language) {
                self.dialog = Dialog::Error(e);
            }
        }
    }

    fn troubleshooting_section(&mut self, ui: &mut egui::Ui, s: &Status) {
        theme::card().show(ui, |ui| {
            ui.set_width(ui.available_width());
            theme::section_heading(
                ui,
                icons::STETHOSCOPE,
                &tr!("troubleshooting-heading"),
                Some(&tr!("troubleshooting-help")),
            );
            ui.horizontal(|ui| {
                let r = ui.add(
                    egui::TextEdit::singleline(&mut self.check_input)
                        .hint_text("https://wiki.example.ts.net/")
                        .margin(Margin::symmetric(10, 7))
                        .desired_width(ui.available_width() - 84.0),
                );
                let enter = r.lost_focus() && ui.input(|i| i.key_pressed(egui::Key::Enter));
                let ctx = ui.ctx().clone();
                if ui
                    .add_enabled(
                        !self.checking && !self.check_input.trim().is_empty(),
                        egui::Button::new(tr!("test")).min_size(vec2(76.0, 30.0)),
                    )
                    .clicked()
                    || enter
                {
                    self.start_check(&ctx);
                }
            });
            if self.checking {
                ui.horizontal(|ui| {
                    ui.spinner();
                    ui.label(tr!("testing"));
                });
            } else if let Some(r) = &self.check_result {
                let (symbol, text, tone) = match r {
                    Ok(m) => (icons::CHECK_CIRCLE, m.clone(), Tone::Good),
                    Err(e) => (icons::WARNING_CIRCLE, e.clone(), Tone::Bad),
                };
                ui.add(egui::Label::new(RichText::new(with_icon(symbol, &text)).color(tone.color())).wrap());
            }
            ui.add_space(4.0);
            ui.horizontal(|ui| {
                if ui.button(with_icon(icons::FILE_TEXT, &tr!("open-log"))).clicked() {
                    let _ = open::that_detached(config::log_path());
                }
                if ui.button(with_icon(icons::FOLDER_OPEN, &tr!("open-settings-folder"))).clicked() {
                    let _ = open::that_detached(config::config_dir());
                }
            });
            ui.add(
                egui::Label::new(
                    muted(format!(
                        "{}\n{}",
                        tr!(
                            "about-line",
                            version = env!("CARGO_PKG_VERSION"),
                            proxy = s.listen.as_str(),
                            pac = self.core.pac_url()
                        ),
                        tr!("settings-location", path = settings_dir_text())
                    ))
                    .size(12.0),
                )
                .wrap(),
            );
        });
    }

    fn forward_row(&mut self, ui: &mut egui::Ui, f: &ForwardStatus) {
        let addr = format!("127.0.0.1:{}", f.local_port);
        let (tone, note) = if !f.error.is_empty() {
            (Tone::Bad, tr!("forward-cant-listen", error = f.error.as_str()))
        } else if f.local_port == 0 {
            (Tone::Idle, tr!("forward-port-on-save"))
        } else if f.via.is_empty() {
            (Tone::Warn, tr!("forward-no-tailnet"))
        } else {
            // Shown beside the target instead ("via …").
            (Tone::Good, String::new())
        };
        theme::row_frame(false).show(ui, |ui| {
            ui.set_width(ui.available_width());
            ui.spacing_mut().item_spacing.y = 0.0;
            ui.horizontal(|ui| {
                theme::dot(ui, tone);
                let shown = if f.local_port == 0 { "127.0.0.1:auto".to_owned() } else { addr.clone() };
                ui.label(RichText::new(shown).monospace().strong().color(theme::STRONG));
                ui.label(muted(icons::ARROW_RIGHT));
                ui.with_layout(egui::Layout::right_to_left(egui::Align::Center), |ui| {
                    ui.spacing_mut().item_spacing.x = 2.0;
                    if f.local_port != 0 {
                        if ui
                            .add(theme::icon_button(icons::COPY))
                            .on_hover_text(tr!("copy-address", address = addr.as_str()))
                            .clicked()
                        {
                            self.copy(ui.ctx(), &addr);
                        }
                        if cfg!(windows)
                            && target_port(&f.target) == 3389
                            && ui
                                .add(theme::icon_button(icons::MONITOR))
                                .on_hover_text(tr!("open-remote-desktop-to", address = addr.as_str()))
                                .clicked()
                            && let Err(e) = remote_desktop(f.local_port)
                        {
                            self.dialog = Dialog::Error(e);
                        }
                    }
                    if tone == Tone::Good {
                        ui.add_space(8.0);
                        ui.label(muted(tr!("forward-via", tailnet = f.via.as_str())).size(12.0));
                    }
                    ui.with_layout(egui::Layout::left_to_right(egui::Align::Center), |ui| {
                        ui.add(egui::Label::new(RichText::new(&f.target).monospace()).truncate());
                    });
                });
            });
            if tone != Tone::Good {
                ui.horizontal(|ui| {
                    ui.add_space(18.0);
                    ui.add(egui::Label::new(RichText::new(note).size(12.0).color(tone.color())).wrap());
                });
            }
        });
    }

    fn save_settings(&mut self) {
        match parse_forwards(&self.forwards) {
            Err(e) => self.dialog = Dialog::Error(e),
            Ok(fwds) => {
                if let Err(e) = self.core.apply_global(fwds, SYS_VALUES[self.sys_mode]) {
                    self.dialog = Dialog::Error(e);
                } else {
                    // "auto" ports were just assigned: show them.
                    self.forwards = forwards_text(&self.core.config().forwards);
                    self.toast(tr!("settings-saved"));
                }
            }
        }
    }
}

// ---- Dialogs ----

impl Gui {
    fn dialogs(&mut self, ctx: &egui::Context) {
        let mut close = false;
        let mut next: Option<Dialog> = None;
        let mut add_forward: Option<String> = None;
        let mut copy: Option<String> = None;
        let esc = !matches!(self.dialog, Dialog::None)
            && ctx.input_mut(|i| i.consume_key(egui::Modifiers::NONE, egui::Key::Escape));
        match &mut self.dialog {
            Dialog::None => return,
            Dialog::Info(title, text) => {
                dialog(ctx, Some((icons::INFO, Tone::Good)), title, |ui| {
                    ui.add(egui::Label::new(text.as_str()).wrap());
                    actions(ui, |ui| {
                        close |= ui
                            .add(theme::primary_button(tr!("ok")).min_size(vec2(88.0, theme::BUTTON_HEIGHT)))
                            .clicked();
                    });
                });
            }
            Dialog::Error(text) => {
                dialog(ctx, Some((icons::WARNING_CIRCLE, Tone::Bad)), &tr!("error-title"), |ui| {
                    ui.add(egui::Label::new(text.as_str()).wrap());
                    ui.add(
                        egui::Label::new(
                            muted(tr!("error-details", path = config::log_path().display().to_string())).size(12.0),
                        )
                        .wrap(),
                    );
                    actions(ui, |ui| {
                        close |= ui
                            .add(theme::primary_button(tr!("ok")).min_size(vec2(88.0, theme::BUTTON_HEIGHT)))
                            .clicked();
                        if ui.add(theme::secondary_button(tr!("open-log"))).clicked() {
                            let _ = open::that_detached(config::log_path());
                        }
                    });
                });
            }
            Dialog::Edit { id, label, name, extra, enabled } => {
                let title = tr!("edit-title", tailnet = label.as_str());
                let mut save = false;
                dialog(ctx, None, &title, |ui| {
                    ui.label(RichText::new(tr!("tailnet-name")).strong());
                    let r = ui.add(
                        egui::TextEdit::singleline(name)
                            .desired_width(f32::INFINITY)
                            .margin(Margin::symmetric(10, 7))
                            .hint_text(tr!("tailnet-name-hint")),
                    );
                    save |= r.lost_focus() && ui.input(|i| i.key_pressed(egui::Key::Enter));
                    ui.add_space(4.0);
                    ui.label(RichText::new(tr!("extra-domains")).strong());
                    ui.add(egui::Label::new(muted(tr!("extra-domains-help")).size(12.0)).wrap());
                    ui.add(
                        egui::TextEdit::multiline(extra)
                            .desired_rows(3)
                            .desired_width(f32::INFINITY)
                            .margin(Margin::symmetric(10, 8))
                            .hint_text("internal.example.com"),
                    );
                    actions(ui, |ui| {
                        save |= ui
                            .add(theme::primary_button(tr!("save")).min_size(vec2(88.0, theme::BUTTON_HEIGHT)))
                            .clicked();
                        close |= ui.add(theme::secondary_button(tr!("cancel"))).clicked();
                    });
                });
                if save {
                    match parse_domains(extra).and_then(|d| self.core.update_tailnet(id, name, *enabled, d)) {
                        Ok(()) => close = true,
                        Err(e) => next = Some(Dialog::Error(e)),
                    }
                }
            }
            Dialog::AddForward { host, port } => {
                let mut add = false;
                dialog(ctx, Some((icons::PLUGS_CONNECTED, Tone::Good)), &tr!("forward-dialog-title"), |ui| {
                    ui.add(egui::Label::new(tr!("forward-dialog-text", host = host.as_str())).wrap());
                    ui.horizontal_wrapped(|ui| {
                        for (name, p) in PORT_PRESETS {
                            let on = port.trim() == p.to_string();
                            if ui
                                .add(egui::Button::selectable(on, preset_name(name, p)).corner_radius(14))
                                .on_hover_text(tr!("port-tooltip", port = p.to_string()))
                                .clicked()
                            {
                                *port = p.to_string();
                            }
                        }
                    });
                    ui.horizontal(|ui| {
                        ui.label(tr!("port"));
                        let r = ui.add(
                            egui::TextEdit::singleline(port)
                                .desired_width(90.0)
                                .margin(Margin::symmetric(10, 7))
                                .hint_text(tr!("port-hint")),
                        );
                        add |= r.lost_focus() && ui.input(|i| i.key_pressed(egui::Key::Enter));
                    });
                    actions(ui, |ui| {
                        add |= ui
                            .add_enabled(!port.trim().is_empty(), theme::primary_button(tr!("add-forward")))
                            .clicked();
                        close |= ui.add(theme::secondary_button(tr!("cancel"))).clicked();
                    });
                });
                if add {
                    match port.trim().parse::<u16>() {
                        Ok(p) if p > 0 => add_forward = Some(format!("{host}:{p}")),
                        _ => next = Some(Dialog::Error(tr!("not-a-port", value = port.trim()))),
                    }
                }
            }
            Dialog::ForwardAdded { local, target } => {
                let addr = format!("127.0.0.1:{local}");
                dialog(ctx, Some((icons::CHECK_CIRCLE, Tone::Good)), &tr!("forward-ready-title"), |ui| {
                    ui.add(egui::Label::new(tr!("forward-ready-text", target = target.as_str())).wrap());
                    theme::row_frame(false).show(ui, |ui| {
                        ui.set_width(ui.available_width());
                        ui.horizontal(|ui| {
                            ui.label(RichText::new(&addr).monospace().size(16.0).strong().color(theme::STRONG));
                            ui.with_layout(egui::Layout::right_to_left(egui::Align::Center), |ui| {
                                if ui.add(theme::icon_button(icons::COPY)).on_hover_text(tr!("copy")).clicked() {
                                    copy = Some(addr.clone());
                                }
                            });
                        });
                    });
                    ui.add(egui::Label::new(muted(tr!("forward-ready-note")).size(12.0)).wrap());
                    actions(ui, |ui| {
                        close |= ui
                            .add(theme::primary_button(tr!("done")).min_size(vec2(88.0, theme::BUTTON_HEIGHT)))
                            .clicked();
                        if cfg!(windows)
                            && target_port(target) == 3389
                            && ui
                                .add(theme::secondary_button(with_icon(icons::MONITOR, &tr!("open-remote-desktop"))))
                                .clicked()
                        {
                            match remote_desktop(*local) {
                                Ok(()) => close = true,
                                Err(e) => next = Some(Dialog::Error(e)),
                            }
                        }
                    });
                });
            }
            Dialog::ConfirmRemove { id, label } => {
                dialog(ctx, Some((icons::TRASH, Tone::Bad)), &tr!("remove-title"), |ui| {
                    ui.add(egui::Label::new(tr!("remove-text", tailnet = label.as_str())).wrap());
                    actions(ui, |ui| {
                        if ui.add(theme::danger_button(tr!("remove"))).clicked() {
                            let (core, id, tx) = (self.core.clone(), id.clone(), self.done_tx.clone());
                            std::thread::spawn(move || {
                                if let Err(e) = core.remove_tailnet(&id) {
                                    let _ = tx.send(Done::Error(e));
                                }
                            });
                            close = true;
                        }
                        close |= ui.add(theme::secondary_button(tr!("cancel"))).clicked();
                    });
                });
            }
            Dialog::ConfirmLogout { id, label } => {
                dialog(ctx, Some((icons::SIGN_OUT, Tone::Warn)), &tr!("log-out-title"), |ui| {
                    ui.add(egui::Label::new(tr!("log-out-text", tailnet = label.as_str())).wrap());
                    actions(ui, |ui| {
                        if ui.add(theme::primary_button(tr!("log-out"))).clicked() {
                            let (core, id) = (self.core.clone(), id.clone());
                            std::thread::spawn(move || core.logout(&id));
                            close = true;
                        }
                        close |= ui.add(theme::secondary_button(tr!("cancel"))).clicked();
                    });
                });
            }
        }
        if let Some(addr) = copy {
            self.copy(ctx, &addr);
        }
        if let Some(n) = next {
            self.dialog = n;
        } else if close || esc {
            self.dialog = Dialog::None;
        }
        if let Some(target) = add_forward {
            self.add_forward(target);
        }
    }
}

/// A modal dialog: optional coloured icon, title, then `body`.
fn dialog(ctx: &egui::Context, symbol: Option<(&str, Tone)>, title: &str, body: impl FnOnce(&mut egui::Ui)) {
    theme::modal("tailnet-link-dialog").show(ctx, |ui| {
        ui.set_width(420.0);
        ui.spacing_mut().item_spacing.y = 10.0;
        ui.horizontal(|ui| {
            if let Some((symbol, tone)) = symbol {
                ui.label(RichText::new(symbol).size(22.0).color(tone.color()));
            }
            ui.label(RichText::new(title).size(18.0).strong().color(theme::STRONG));
        });
        body(ui);
    });
}

/// A dialog's buttons, right-aligned. Add the main action first.
fn actions(ui: &mut egui::Ui, add: impl FnOnce(&mut egui::Ui)) {
    ui.add_space(6.0);
    ui.allocate_ui_with_layout(
        vec2(ui.available_width(), theme::BUTTON_HEIGHT),
        egui::Layout::right_to_left(egui::Align::Center),
        add,
    );
}

fn proxy_help() -> String {
    if cfg!(windows) {
        tr!("proxy-help-windows")
    } else if cfg!(target_os = "macos") {
        tr!("proxy-help-macos")
    } else {
        tr!("proxy-help-linux")
    }
}

// ---- Tray / menu bar ----

pub struct Tray {
    icon: TrayIcon,
    actions: ActionMap,
    tone: Tone,
}

fn tray_image(tone: Tone) -> tray_icon::Icon {
    tray_icon::Icon::from_rgba(icon::tray(tone.tray(), 32), 32, 32).expect("tray icon")
}

impl Tray {
    pub fn new(actions: ActionMap) -> Result<Tray, String> {
        let icon = TrayIconBuilder::new()
            .with_menu(Box::new(Menu::new()))
            .with_icon(tray_image(Tone::Idle))
            .with_tooltip("Tailnet Link")
            .with_menu_on_left_click(false)
            .build()
            .map_err(|e| e.to_string())?;
        Ok(Tray { icon, actions, tone: Tone::Idle })
    }

    /// Shows a notification from the tray icon. Windows 10 and 11 show it as a
    /// toast by the clock that goes away on its own.
    #[cfg(windows)]
    fn notify(&self, title: &str, text: &str) -> bool {
        use windows_sys::Win32::UI::Shell::{
            NIF_INFO, NIIF_NONE, NIIF_RESPECT_QUIET_TIME, NIM_MODIFY, NOTIFYICONDATAW, Shell_NotifyIconW,
        };
        fn fill<const N: usize>(dst: &mut [u16; N], s: &str) {
            for (d, c) in dst.iter_mut().take(N - 1).zip(s.encode_utf16()) {
                *d = c;
            }
        }
        let mut nid = NOTIFYICONDATAW {
            cbSize: size_of::<NOTIFYICONDATAW>() as u32,
            hWnd: self.icon.window_handle(),
            uFlags: NIF_INFO,
            dwInfoFlags: NIIF_NONE | NIIF_RESPECT_QUIET_TIME,
            ..Default::default()
        };
        fill(&mut nid.szInfoTitle, title);
        fill(&mut nid.szInfo, text);
        // tray-icon keeps the icon's id to itself, but each icon has its own
        // hidden window, so only the right id matches.
        (1..=16).any(|id| {
            nid.uID = id;
            // SAFETY: `nid` is a fully initialised NOTIFYICONDATAW with its size set.
            unsafe { Shell_NotifyIconW(NIM_MODIFY, &raw const nid) != 0 }
        })
    }

    pub fn refresh(&mut self, s: &Status) {
        let menu = Menu::new();
        let mut map = HashMap::new();
        let summary = MenuItem::new(s.summary(), false, None);
        let _ = menu.append(&summary);
        let _ = menu.append(&PredefinedMenuItem::separator());
        for t in &s.tailnets {
            let label = if t.needs_login() {
                tr!("tray-sign-in", tailnet = t.label())
            } else {
                tr!("tray-tailnet", tailnet = t.label(), state = tailnet_state(t).1)
            };
            let item = CheckMenuItem::new(label, true, t.routing, None);
            map.insert(item.id().clone(), if t.needs_login() { Action::Login(t.id.clone()) } else { Action::Open });
            let _ = menu.append(&item);
        }
        let add = MenuItem::new(tr!("tray-add-tailnet"), true, None);
        map.insert(add.id().clone(), Action::Add);
        let _ = menu.append(&add);
        let _ = menu.append(&PredefinedMenuItem::separator());
        let route = CheckMenuItem::new(tr!("tray-route"), true, s.enabled, None);
        map.insert(route.id().clone(), Action::ToggleMaster);
        let open = MenuItem::new(tr!("tray-open"), true, None);
        map.insert(open.id().clone(), Action::Open);
        let quit = MenuItem::new(tr!("tray-quit"), true, None);
        map.insert(quit.id().clone(), Action::Quit);
        for i in [&route as &dyn tray_icon::menu::IsMenuItem, &open, &PredefinedMenuItem::separator(), &quit] {
            let _ = menu.append(i);
        }
        *lock(&self.actions) = map;
        self.icon.set_menu(Some(Box::new(menu)));

        let tone = status_tone(s);
        if tone != self.tone {
            self.tone = tone;
            let _ = self.icon.set_icon(Some(tray_image(tone)));
        }
        let _ = self.icon.set_tooltip(Some(tr!("tray-tooltip", summary = s.summary())));
    }
}

/// Linux: the tray needs its own GTK main loop on its own thread.
/// Tells the user, once, that closing the window left the app running.
fn notify_still_running(tray: Option<&Tray>) {
    let title = tr!("still-running-title");
    #[cfg(windows)]
    {
        if !tray.is_some_and(|t| t.notify(&title, &tr!("still-running-windows"))) {
            log::warn!("couldn't show the still-running notification");
        }
    }
    #[cfg(not(windows))]
    {
        let _ = tray;
        let text = if cfg!(target_os = "macos") { tr!("still-running-macos") } else { tr!("still-running-linux") };
        let mut cmd = if cfg!(target_os = "macos") {
            let mut c = std::process::Command::new("osascript");
            c.arg("-e").arg(format!("display notification {text:?} with title {title:?}"));
            c
        } else {
            let mut c = std::process::Command::new("notify-send");
            c.args(["--app-name=Tailnet Link", "--expire-time=6000", &title, &text]);
            c
        };
        std::thread::spawn(move || {
            if let Err(e) = cmd.status() {
                log::warn!("couldn't show the still-running notification: {e}");
            }
        });
    }
}

#[cfg(target_os = "linux")]
mod linux_tray {
    use super::{ActionMap, Arc, Core, Tray};
    use gtk::glib;

    pub fn spawn(core: Arc<Core>, actions: ActionMap) {
        std::thread::Builder::new()
            .name("tray".into())
            .spawn(move || {
                if let Err(e) = gtk::init() {
                    log::warn!("tray icon unavailable (GTK): {e}");
                    return;
                }
                let mut tray = match Tray::new(actions) {
                    Ok(t) => t,
                    Err(e) => {
                        log::warn!("tray icon: {e}");
                        return;
                    }
                };
                let mut last = u64::MAX;
                glib::timeout_add_local(std::time::Duration::from_millis(500), move || {
                    let v = core.version();
                    if v != last {
                        last = v;
                        tray.refresh(&core.status());
                    }
                    glib::ControlFlow::Continue
                });
                gtk::main();
            })
            .ok();
    }
}

#[cfg(test)]
mod tests {
    use super::os_name;

    #[test]
    fn os_names_read_naturally() {
        assert_eq!(os_name("windows"), "Windows");
        assert_eq!(os_name("linux"), "Linux");
        assert_eq!(os_name("macOS"), "macOS");
        assert_eq!(os_name("iOS"), "iOS");
        assert_eq!(os_name(""), "");
    }
}
