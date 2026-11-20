# Tailnet Link

[![CI](https://github.com/Azazel-Labs/tailnet-link/actions/workflows/ci.yml/badge.svg)](https://github.com/Azazel-Labs/tailnet-link/actions/workflows/ci.yml)
[![Release](https://img.shields.io/github/v/release/Azazel-Labs/tailnet-link)](https://github.com/Azazel-Labs/tailnet-link/releases)
[![License: MIT-0](https://img.shields.io/badge/license-MIT--0-blue.svg)](LICENSE)
[![Rust: 1.95+](https://img.shields.io/badge/rust-1.95%2B-orange.svg)](Cargo.toml)
[![Edition: 2024](https://img.shields.io/badge/edition-2024-orange.svg)](Cargo.toml)
[![Platforms](https://img.shields.io/badge/platforms-Windows%20%7C%20macOS%20%7C%20Linux-lightgrey.svg)](#download)

Tailnet Link is a tray app that keeps you on **your own tailnet** while letting you reach machines on
**any number of other tailnets** at the same time (for example
`https://wiki.example.ts.net/`). You don't switch accounts, and nothing conflicts.

[Releases](https://github.com/Azazel-Labs/tailnet-link/releases) · [Building](docs/development.md) · [Releasing](docs/releases.md) · [License (MIT-0)](LICENSE)

It's written in Rust with an [egui](https://github.com/emilk/egui) window, on top of Tailscale's
[libtailscale](https://github.com/tailscale/libtailscale). It is not made by or affiliated with
Tailscale Inc.

## How it works

- Your normal Tailscale app stays exactly as it is, on your tailnet.
- For each other tailnet you add, the app runs a **separate Tailscale node inside itself**
  (libtailscale, userspace). There's no VPN adapter, no routes and no DNS changes, so nothing clashes
  with the real Tailscale app or with the other nodes. Each node logs in with **shields up**, so
  nothing in those tailnets can connect to your computer.
- **Domains are detected automatically.** After you sign in to a tailnet, the app reads its MagicDNS
  name (e.g. `example.ts.net`) and routes `*.example.ts.net` to it. You can add extra
  domains per tailnet.
- **One local port serves them all** (127.0.0.1:1055, or a free one if that's taken). The proxy reads
  the name in each request and sends it through the tailnet that owns it, via that node's SOCKS5 proxy.
- The **system proxy setting** points at a PAC file that lists only those domains, and only while
  something is routing. Everything else goes direct, through your normal network and tailnet.
- HTTPS works end to end with the real certificates; the proxy never sees inside it.

## Use

1. Start the app. Its window opens, and an icon appears in the tray or menu bar.
2. Click **Add a tailnet** and sign in with your account for that tailnet. Tailscale's sign-in page
   opens in your browser, as it does with the Tailscale app. The tailnet's domain is picked up
   automatically.
3. Repeat for any other tailnets.
4. Open `https://wiki.example.ts.net/` in your browser.

Closing the window leaves Tailnet Link running in the system tray (the menu bar on macOS); the first
time, a notification says where to find it. Quit from the tray menu. Starting the app again while it's
running brings its window back.

**Tailnets tab:**

- Overall status, **Pause all** and **Add a tailnet**.
- One card per tailnet, with:
  - its status, routed domains and this computer's name there
  - Log in / Log out, Pause / Resume, edit (name, extra domains) and remove
- Each signed-in tailnet lists its **machines**, online first. A search box above the cards filters
  them. For each machine you can **Open** it in your browser, **copy** its name, or **Forward a port…**
  to it (Remote Desktop, SSH, databases and so on; a free local port is picked and shown).
- If the sign-in page didn't open, or opened in the wrong browser profile, the card offers to open it
  again or copy the link.

**Settings tab:**

- **Port forwards.** Each shows its local address with a copy button, and which tailnet carries it (or
  why it can't). On Windows, port 3389 forwards get a **Remote Desktop** button.
- The system proxy setting, start at login, and buttons to open the log and the settings folder.
- **Test a name or address** shows which tailnet routes a name and tries to connect through it. It's
  the quickest way to find out why a page won't load.
- Unsaved changes are flagged, with **Revert**. Ctrl+S saves, and Esc closes dialogs.

**Tray menu:** status; one line per tailnet (✓ = routing; click to sign in if needed);
Add a tailnet…; master on/off; Open Tailnet Link…; Quit. Left-click the icon to open the window.

**Icon colours:** green = routing, amber = a tailnet needs sign-in, grey = paused or connecting,
red = problem.

### Apps that ignore proxies

Browsers and most tools follow the system proxy setting. Remote Desktop, database clients and similar
apps don't. For those, add a **port forward** in Settings, e.g.
`auto = build-pc.example.ts.net:3389`. A free local port is picked, shown and kept. Connect
to `127.0.0.1:<that port>`.

## The proxy setting is only on while it should be

| What happens | Result |
|---|---|
| Quit, or log off normally | Setting restored immediately |
| Everything paused, logged out or disconnected | Setting switched off until something routes again, and the PAC falls back to "everything direct". On a Mac that needs a password for proxy changes, the setting stays until you quit to avoid repeated prompts, but the PAC is all-direct. |
| The app crashes or is killed | A small watchdog (the same program, hidden) notices and restores the setting |
| Power cut or forced reboot | Restored at your next login, and on the app's next start |

It never replaces a proxy script someone else set (e.g. your company's) unless you choose "replace"
in Settings. It always puts the previous one back, and leaves alone any change made in the meantime.

## Platforms

| | Windows | macOS | Linux |
|---|---|---|---|
| Window + tray | ✅ | ✅ (menu bar, no Dock icon) | ✅ (GNOME needs the AppIndicator extension; Ubuntu has it) |
| Sets the system proxy | ✅ | ✅ (may ask for an admin password at start and quit) | ✅ GNOME and KDE |
| Start at login | ✅ | ✅ | ✅ |

Firefox on any platform: Settings → Network Settings → **Use system proxy settings**.

## Download

Get the [latest release](https://github.com/Azazel-Labs/tailnet-link/releases/latest).

| File | For |
|---|---|
| **`tailnet-link-windows-setup.exe`** | **Windows installer** (x64; also runs on ARM64 Windows via emulation) |
| **`tailnet-link-macos-universal.dmg`** | **Mac** (Apple Silicon and Intel) |
| **`tailnet-link-linux-amd64.deb`** | **Ubuntu / Debian**: `sudo apt install ./tailnet-link-linux-amd64.deb` |
| `tailnet-link-windows-amd64.exe`, `-macos-universal.zip`, `-linux-amd64` | The app without an installer |

`SHA256SUMS.txt` lists checksums for every file.

**Not code-signed.** On Windows, at the SmartScreen warning choose **More info → Run anyway**. On
macOS, right-click the app and choose **Open** the first time.

### What the Windows installer does

- Installs for all users in `C:\Program Files\Tailnet Link`. It asks for admin once and needs nothing
  else installed.
- Adds a Windows Firewall rule for this app only (inbound UDP), so the other tailnets connect directly
  instead of through Tailscale's relays, without an "allow access" pop-up.
- Adds a Start menu shortcut, an optional desktop shortcut, and **Start at login** (on by default;
  starts quietly in the tray).
- Upgrades in place and keeps logins and settings.
- Uninstalling closes the app, restores the proxy setting, removes the firewall rule and login item,
  and asks before deleting logins.
- Silent install: `tailnet-link-windows-setup.exe /S`. Silent uninstall:
  `"C:\Program Files\Tailnet Link\uninstall.exe" /S`.

## Files

Everything lives in the app's config folder:

| Windows | macOS | Linux |
|---|---|---|
| `%AppData%\Tailnet Link` | `~/Library/Application Support/Tailnet Link` | `~/.config/tailnet-link` |

- `config.json`: your tailnets, port forwards and settings
- `nodes/<id>/`: each tailnet's login (Remove deletes it)
- `tailnet-link.log`: the log, including the details of any crash
- `proxy-state.json` (macOS/Linux, only while the proxy setting is on): what to restore

Set `TAILNET_LINK_CONFIG_DIR` to use a different folder.

Upgrading from **tailnet-proxy**, this app's earlier name? Your old `tailnet-proxy` config folder is
moved to the new location the first time Tailnet Link starts, so logins and settings carry over.

## Contributing

Build instructions and the project layout are in [docs/development.md](docs/development.md).
The release process is in [docs/releases.md](docs/releases.md).

## License

Copyright © 2026 Azazel Labs LLC. Released under [MIT-0](LICENSE).

`tsbridge/` is vendored from [tailscale/libtailscale](https://github.com/tailscale/libtailscale) and
keeps its BSD-3-Clause license (see [tsbridge/LICENSE](tsbridge/LICENSE)). Tailscale is a trademark of
Tailscale Inc.
