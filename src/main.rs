//! Tailnet Link: a tray app that keeps you on your own tailnet while letting
//! you reach machines on other tailnets, without them fighting.
//!
//! Your normal Tailscale app stays on your own tailnet. For each extra tailnet
//! this app runs a Tailscale node inside itself (libtailscale: userspace, no
//! VPN adapter, routes or DNS changes) with shields up, runs a local proxy,
//! and points the system proxy setting at a PAC script so that ONLY those
//! tailnets' names go through it, and only while it's running and connected.

#![cfg_attr(windows, windows_subsystem = "windows")]

mod autostart;
mod config;
mod core;
#[cfg(feature = "screenshots")]
mod demo;
mod i18n;
mod icon;
mod logging;
mod proxy;
mod socks;
mod sync;
mod sysproxy;
mod theme;
mod tsnet;
mod ui;
mod update;

use std::sync::Arc;
use std::time::Duration;

/// Serialises tests that change the config folder (an environment variable).
#[cfg(test)]
pub static TEST_LOCK: std::sync::Mutex<()> = std::sync::Mutex::new(());

#[derive(Default)]
struct Args {
    cleanup: bool,
    logout_all: bool,
    watchdog_pid: Option<u32>,
    export_icon: Option<String>,
    background: bool,
    version: bool,
}

fn parse_args() -> Args {
    let mut a = Args::default();
    let mut it = std::env::args().skip(1);
    while let Some(arg) = it.next() {
        match arg.trim_start_matches('-') {
            "version" | "V" => a.version = true,
            "cleanup" => a.cleanup = true,
            "logout-all" => a.logout_all = true,
            "background" => a.background = true,
            "watchdog-pid" => a.watchdog_pid = it.next().and_then(|v| v.parse().ok()),
            "export-icon" => a.export_icon = it.next(),
            _ => {}
        }
    }
    a
}

/// Prints a line where whoever started the app can see it. On Windows the app is a GUI program,
/// which gets no console, so unless its output is piped somewhere it joins the terminal it was
/// started from first.
fn print_line(text: &str) {
    #[cfg(windows)]
    {
        use windows_sys::Win32::System::Console::{
            ATTACH_PARENT_PROCESS, AttachConsole, GetStdHandle, STD_OUTPUT_HANDLE,
        };
        // SAFETY: takes no pointers; a null handle just means no stdout.
        if unsafe { GetStdHandle(STD_OUTPUT_HANDLE) }.is_null() {
            // SAFETY: takes no pointers; failing (no parent console) leaves nothing to print to.
            unsafe { AttachConsole(ATTACH_PARENT_PROCESS) };
        }
    }
    println!("{text}");
}

fn main() {
    let args = parse_args();

    // Before anything touches settings, the log or the system proxy.
    if args.version {
        print_line(&format!("Tailnet Link {}", env!("CARGO_PKG_VERSION")));
        return;
    }

    // Build tool: write the app icon, then exit.
    if let Some(path) = args.export_icon {
        if let Err(e) = icon::export(std::path::Path::new(&path)) {
            eprintln!("{e}");
            std::process::exit(1);
        }
        return;
    }

    // README screenshots: made-up tailnets, no engine, system proxy or tray.
    #[cfg(feature = "screenshots")]
    if demo::active() {
        logging::init();
        let core = core::Core::new(demo::config());
        window(&core, false);
        return;
    }

    // Before logging starts, since the log lives in the config folder.
    let migrated = config::migrate_legacy_dir();
    logging::init();
    let mut startup_error = None;
    match migrated {
        Ok(Some(old)) => log::info!("Moved settings from {} to {}", old.display(), config::config_dir().display()),
        Ok(None) => {}
        Err(e) => {
            log::warn!("Couldn't move settings from the old tailnet-proxy folder: {e}");
            startup_error = Some(i18n::tr!("migrate-failed", error = e.to_string()));
        }
    }

    // Hidden modes the app launches itself with (see sysproxy).
    if args.cleanup {
        sysproxy::cleanup_stale();
        return;
    }
    if let Some(pid) = args.watchdog_pid {
        sysproxy::run_watchdog(pid);
        return;
    }
    // The uninstaller, before deleting logins: sign out so no machine is left behind.
    if args.logout_all {
        core::logout_all();
        return;
    }

    // A previous run that crashed or was killed may have left the proxy setting on.
    sysproxy::cleanup_stale();

    let first_run = !config::config_path().exists();
    let cfg = match config::Config::load() {
        Ok(c) => c,
        Err(e) => {
            log::warn!("Settings problem, using defaults: {e}");
            config::Config::default()
        }
    };
    // Not while the old folder couldn't be moved: it can still move on the next start.
    if first_run && startup_error.is_none() {
        let _ = cfg.save();
    }

    // Already running (maybe hidden in the tray)? Bring that window forward instead.
    if ask_running_copy_to_show(&cfg.listen) {
        log::info!("Already running; asked it to show its window.");
        return;
    }

    log::info!("Tailnet Link {} starting (settings: {})", env!("CARGO_PKG_VERSION"), config::config_path().display());
    let core = core::Core::new(cfg);

    let start_hidden = args.background && !first_run && startup_error.is_none();
    window(&core, start_hidden, startup_error);
    core.shutdown();
}

/// Runs the window until it closes. `start_hidden`: stay in the tray.
/// `startup_error`: shown in a dialog once the window is up.
fn window(core: &Arc<core::Core>, start_hidden: bool, startup_error: Option<String>) {
    let icon = egui::IconData { rgba: icon::app(256), width: 256, height: 256 };
    let options = eframe::NativeOptions {
        viewport: egui::ViewportBuilder::default()
            .with_title("Tailnet Link")
            .with_app_id("tailnet-link")
            .with_inner_size([720.0, 760.0])
            .with_min_inner_size([520.0, 480.0])
            .with_icon(Arc::new(icon)),
        wgpu_options: wgpu_options(),
        ..Default::default()
    };
    let core2 = core.clone();
    if let Err(e) = eframe::run_native(
        "Tailnet Link",
        options,
        Box::new(move |cc| Ok(Box::new(ui::Gui::new(cc, core2, start_hidden, startup_error)))),
    ) {
        log::error!("UI failed: {e}");
    }
}

/// GPU setup for the window. On Windows wgpu would otherwise pick Vulkan when the
/// driver offers it, and some drivers' Vulkan swapchains flash the whole window
/// on redraw (seen on hover); DX12 is the well-trodden path there. A tray app
/// needs no discrete GPU either. Setting `WGPU_BACKEND` or `WGPU_POWER_PREF`
/// restores wgpu's own choice.
fn wgpu_options() -> eframe::WgpuConfiguration {
    use eframe::egui_wgpu::{WgpuSetup, wgpu};
    let mut options = eframe::WgpuConfiguration::default();
    let overridden = wgpu::Backends::from_env().is_some() || wgpu::PowerPreference::from_env().is_some();
    if let WgpuSetup::CreateNew(setup) = &mut options.wgpu_setup
        && !overridden
    {
        setup.native_adapter_selector = Some(Arc::new(|adapters, surface| {
            let rank = |a: &wgpu::Adapter| {
                let info = a.get_info();
                let device = match info.device_type {
                    wgpu::DeviceType::IntegratedGpu => 0,
                    wgpu::DeviceType::DiscreteGpu => 1,
                    wgpu::DeviceType::VirtualGpu | wgpu::DeviceType::Other => 2,
                    wgpu::DeviceType::Cpu => 3,
                };
                (cfg!(windows) && info.backend != wgpu::Backend::Dx12, device)
            };
            adapters
                .iter()
                .filter(|a| surface.is_none_or(|s| a.is_surface_supported(s)))
                .min_by_key(|a| rank(a))
                .cloned()
                .ok_or_else(|| "no graphics adapter can draw to the window".to_owned())
        }));
    }
    options
}

/// True if another copy is running (it's asked to show its window).
fn ask_running_copy_to_show(listen: &str) -> bool {
    let agent: ureq::Agent = ureq::Agent::config_builder()
        .proxy(None)
        .timeout_global(Some(Duration::from_secs(2)))
        .http_status_as_error(false)
        .build()
        .into();
    let running = agent
        .get(format!("http://{listen}/"))
        .call()
        .ok()
        .and_then(|mut r| r.body_mut().read_to_string().ok())
        .is_some_and(|b| b.starts_with("Tailnet Link is running"));
    if running {
        let _ = agent.post(format!("http://{listen}/show")).header("X-Tailnet-Link", "show").send_empty();
    }
    running
}
