# Building and development

## Requirements

- **Rust 1.95 or newer.** `rust-toolchain.toml` pins a newer development toolchain
  for consistent formatting and linting; `rustup` fetches it automatically. Use
  `cargo +1.95.0 check --workspace --all-targets --locked` to check against the
  minimum supported version.
- **Go 1.27 or newer**, at build time only. `build.rs` compiles the vendored
  libtailscale in `tsbridge/` with `go build -buildmode=c-archive` (cgo) and links
  it statically into the app.
- **A C compiler for cgo:**
  - **Windows:** MinGW-w64 (for example MSYS2's `mingw-w64-x86_64-gcc`). Go's cgo
    archives need the GNU linker, so Windows builds use the
    `x86_64-pc-windows-gnu` target. Run `rustup target add x86_64-pc-windows-gnu`
    once.
  - **macOS:** the Xcode command line tools.
  - **Linux:** `build-essential`, plus the tray and window dependencies:
    `sudo apt install build-essential libgtk-3-dev libxdo-dev libayatana-appindicator3-dev libxkbcommon-dev libwayland-dev`

Go and gcc must be on `PATH`. On Windows with the default install locations, in Git
Bash:

```sh
export PATH="/c/Program Files/Go/bin:/c/msys64/mingw64/bin:$PATH"
```

## Commands

On Windows add `--target x86_64-pc-windows-gnu` to each command, or set
`CARGO_BUILD_TARGET=x86_64-pc-windows-gnu` once for the shell.

```sh
cargo run --locked                                              # start the app
cargo build --workspace --locked                                # debug build
cargo build --release --locked                                  # release build
cargo test --workspace --locked                                 # tests
cargo clippy --workspace --all-targets --locked -- -D warnings  # strict lints
cargo fmt --all                                                 # format
```

The tests start a real libtailscale node (no sign-in needed). On Windows they also
exercise the proxy-setting code against the real registry, saving and restoring
your settings.

Set `TAILNET_LINK_CONFIG_DIR` to a scratch folder to run a development copy
without touching your real logins and settings.

## VS Code

Install the recommended extensions when prompted (rust-analyzer, CodeLLDB, Go,
Fluent). **Tasks: Run Task** lists the `Tailnet Link: …` tasks: Run, Build, Test
workspace, Clippy, Format, Check formatting, **Check all** (formatting, Clippy and
tests in sequence) and the release commands. The launch configurations
**Tailnet Link: App** and **Tailnet Link: App (release)** build and debug the app
with CodeLLDB. On Windows both use the MinGW target automatically.

Start VS Code from a shell where Go and gcc are on `PATH`, or add them to your user
`PATH`.

## Packaging

The release workflow runs these scripts; they also work locally. Each takes the
version tag and an output folder.

| Platform | Command | Needs |
| --- | --- | --- |
| Windows installer (built on Linux) | `bash packaging/windows/build-installer.sh v1.0.0 dist` | `rustup target add x86_64-pc-windows-gnu`, `sudo apt install nsis gcc-mingw-w64-x86-64` |
| Linux `.deb` | `bash packaging/linux/package-deb.sh v1.0.0 dist` | the Linux build dependencies above |
| macOS `.dmg` and `.zip` (on a Mac) | `bash packaging/macos/package-macos.sh v1.0.0 dist` | `rustup target add aarch64-apple-darwin x86_64-apple-darwin` |

On Windows, `build.rs` embeds the icon, version information and an application
manifest (`packaging/windows/tailnet-link.exe.manifest`). The manifest is required:
without it Windows reports an old version to the program, and Tailscale's Windows
code panics with "incoherent Windows version" when a node starts.

## Layout

| Path | Contents |
| --- | --- |
| `src/main.rs` | Startup, single-instance handling, watchdog and crash cleanup |
| `src/ui.rs` | The egui window and the tray menu |
| `src/core.rs` | Tailnet nodes, routing state and port forwards |
| `src/proxy.rs`, `src/socks.rs` | The local HTTP proxy, PAC file and SOCKS5 client |
| `src/sysproxy/` | Setting and restoring the system proxy on each platform |
| `src/tsnet.rs` | Safe wrapper over libtailscale's C API |
| `src/config.rs` | Settings, the config folder and migration from the old name |
| `src/icon.rs` | The app and tray icons, drawn in code |
| `tsbridge/` | Vendored libtailscale (Go) |
| `packaging/` | Installer and package scripts per platform |
| `xtask/` | Release tooling (`cargo xtask release …`) |

### libtailscale (`tsbridge/`)

Vendored from [tailscale/libtailscale](https://github.com/tailscale/libtailscale)
(BSD-3-Clause, see `tsbridge/LICENSE`). The only change moves its socketpair-based
`dial`/`listen`/`accept` into `sockets_unix.go`, with stubs in `sockets_windows.go`,
because upstream doesn't build on Windows. This app only uses the portable parts:
start/close, status, and `tailscale_loopback` (a SOCKS5 proxy and the LocalAPI on
127.0.0.1, protected by random credentials).

### Icons

The icons are drawn in code (`src/icon.rs`). `assets/icons/` holds exported copies
for the installers, and a test fails if they drift. Regenerate them with:

```sh
cargo run --locked -- --export-icon assets/icons/tailnet-link.ico
```
