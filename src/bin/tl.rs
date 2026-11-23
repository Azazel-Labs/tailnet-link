//! `tl`: runs a command, or opens a shell, where the names and addresses in
//! your other tailnets work, through Tailnet Link.
//!
//! ```text
//! tl curl http://wiki.example.ts.net/
//! tl ssh admin@build.example.ts.net
//! tl ping build.example.ts.net
//! tl                   (a shell where every command works that way)
//! ```
//!
//! It points the standard proxy variables (`HTTPS_PROXY` and the rest) at the
//! app's terminal proxy, which sends tailnet names through their tailnet and
//! everything else directly. It sends `ssh`, `scp`, `sftp` and git's SSH
//! through `tl --connect`, and answers `ping` with Tailscale's own ping.
//! Nothing outside that command or shell changes, and nothing is passed on to
//! the machines you connect to.
//!
//! It's a console program of its own, installed next to the app: on Windows
//! the app is a windowed program, which terminals don't wait for.

use std::ffi::{OsStr, OsString};
use std::fmt::Write as _;
use std::io::{Read, Write};
use std::net::{Shutdown, TcpStream, ToSocketAddrs};
use std::path::{Path, PathBuf};
use std::process::Command;
use std::time::Duration;

const USAGE: &str = "\
tl runs commands where the names in your other tailnets work (Tailnet Link).

  tl                       open a shell where they work (exit leaves it)
  tl <command> [args...]   run one command, e.g. tl curl http://wiki.example.ts.net/
  tl ping <host>           ping a machine with Tailscale's ping
                           (-c N: N pings, -t: until Ctrl+C)
  tl --env [shell]         print the setup for a shell: eval \"$(tl --env)\" in
                           bash or zsh, tl --env | Invoke-Expression in PowerShell
  tl --connect <host> <port>
                           connect stdin and stdout to host:port (an SSH ProxyCommand)
  tl --version

Tools that follow the standard proxy settings (curl, git, npm, pip and most
others) work, and so do ssh, scp and sftp. Tailnet Link must be running.
";

/// Set in the commands and shells `tl` starts: where the terminal proxy is.
const PROXY_VAR: &str = "TAILNET_LINK_PROXY";
/// What a shell started by `tl` runs through `tl`.
const WRAPPED: [&str; 4] = ["ssh", "scp", "sftp", "ping"];
const NOT_RUNNING: &str = "Tailnet Link isn't running. Start it, then try again.";
const TOO_OLD: &str = "this Tailnet Link is older than tl. Update it, or restart it if you just did.";

fn main() {
    let args: Vec<OsString> = std::env::args_os().skip(1).collect();
    let code = match run(&args) {
        Ok(code) => code,
        Err(e) => {
            eprintln!("tl: {e}");
            1
        }
    };
    std::process::exit(code);
}

fn run(args: &[OsString]) -> Result<i32, String> {
    let Some(first) = args.first() else { return shell() };
    let name = first.to_string_lossy();
    let tool = name.strip_suffix(".exe").unwrap_or(&name).to_ascii_lowercase();
    match tool.as_str() {
        "-h" | "--help" => {
            print!("{USAGE}");
            Ok(0)
        }
        "-v" | "--version" => {
            println!("tl (Tailnet Link) {}", env!("CARGO_PKG_VERSION"));
            Ok(0)
        }
        "--connect" => connect(&args[1..]),
        "--env" => print_env(args.get(1).map(|a| a.to_string_lossy()).as_deref()),
        "ping" => ping(&args[1..]),
        "ssh" | "scp" | "sftp" => run_ssh(&tool, &args[1..]),
        _ if name.starts_with('-') => Err(format!("unknown option {name} (see tl --help)")),
        _ => {
            let proxy = app_proxy()?;
            let mut cmd = Command::new(resolve(first));
            cmd.args(&args[1..]).envs(env_for(&proxy));
            exec(cmd, first)
        }
    }
}

// ---- The app ----

/// Where the app keeps its settings (the same as `config::config_dir`).
fn config_dir() -> PathBuf {
    if let Some(d) = std::env::var_os("TAILNET_LINK_CONFIG_DIR") {
        return PathBuf::from(d);
    }
    let name = if cfg!(any(windows, target_os = "macos")) { "Tailnet Link" } else { "tailnet-link" };
    dirs::config_dir().unwrap_or_else(|| PathBuf::from(".")).join(name)
}

/// The app's main proxy, from its settings.
fn listen() -> String {
    std::fs::read_to_string(config_dir().join("config.json"))
        .ok()
        .and_then(|t| serde_json::from_str::<serde_json::Value>(&t).ok())
        .and_then(|v| v.get("listen")?.as_str().map(str::to_owned))
        .filter(|s| !s.is_empty())
        .unwrap_or_else(|| "127.0.0.1:1055".to_owned())
}

/// Asks the running app a question (`/tl/...`) and returns its JSON answer.
fn ask(path: &str, timeout: Duration) -> Result<serde_json::Value, String> {
    let listen = listen();
    let addr = listen
        .to_socket_addrs()
        .ok()
        .and_then(|mut a| a.next())
        .ok_or_else(|| format!("Tailnet Link's settings have a bad address: {listen}"))?;
    let mut s = TcpStream::connect_timeout(&addr, Duration::from_secs(2)).map_err(|_| NOT_RUNNING.to_owned())?;
    let _ = s.set_read_timeout(Some(timeout));
    write!(s, "GET {path} HTTP/1.1\r\nHost: 127.0.0.1\r\nX-Tailnet-Link: tl\r\nConnection: close\r\n\r\n")
        .map_err(|e| format!("asking Tailnet Link: {e}"))?;
    let mut resp = Vec::new();
    s.read_to_end(&mut resp).map_err(|e| format!("Tailnet Link didn't answer: {e}"))?;
    let text = String::from_utf8_lossy(&resp);
    let (head, body) = text.split_once("\r\n\r\n").unwrap_or((&text, ""));
    if !head.starts_with("HTTP/1.1 200") || !head.to_ascii_lowercase().contains("application/json") {
        return Err(TOO_OLD.to_owned());
    }
    serde_json::from_str(body).map_err(|e| format!("reading Tailnet Link's answer: {e}"))
}

/// The app's terminal proxy: tailnet names through their tailnet, anything else direct.
fn app_proxy() -> Result<String, String> {
    let info = ask("/tl/info", Duration::from_secs(5))?;
    info.get("terminal_proxy")
        .and_then(|v| v.as_str())
        .filter(|s| !s.is_empty())
        .map(str::to_owned)
        .ok_or_else(|| "Tailnet Link has no terminal proxy (its log says why).".to_owned())
}

// ---- Environment ----

/// This program, for commands and scripts to call back.
fn tl_exe() -> PathBuf {
    let p = std::env::current_exe().unwrap_or_else(|_| PathBuf::from("tl"));
    // A \\?\ path confuses shells.
    match p.to_str().and_then(|s| s.strip_prefix(r"\\?\")) {
        Some(plain) => PathBuf::from(plain),
        None => p,
    }
}

/// [`tl_exe`] with forward slashes, which Windows, POSIX shells and SSH all accept.
fn tl_slashed() -> String {
    let p = tl_exe().to_string_lossy().into_owned();
    if cfg!(windows) { p.replace('\\', "/") } else { p }
}

/// The `ssh` option that sends the connection through `tl --connect`.
fn proxy_command() -> String {
    format!("ProxyCommand=\"{}\" --connect %h %p", tl_slashed())
}

/// The variables a command or shell gets, for the terminal proxy at `proxy`.
fn env_for(proxy: &str) -> Vec<(String, String)> {
    let url = format!("http://{proxy}");
    let mut vars: Vec<(String, String)> =
        ["HTTP_PROXY", "HTTPS_PROXY", "ALL_PROXY", "http_proxy", "https_proxy", "all_proxy"]
            .iter()
            .map(|k| ((*k).to_owned(), url.clone()))
            .collect();
    // Node.js's own fetch follows the variables only when asked.
    vars.push(("NODE_USE_ENV_PROXY".to_owned(), "1".to_owned()));
    let existing = ["NO_PROXY", "no_proxy"].iter().filter_map(|k| std::env::var(k).ok()).collect::<Vec<_>>().join(",");
    let no_proxy = merge_no_proxy(&existing);
    vars.push(("NO_PROXY".to_owned(), no_proxy.clone()));
    vars.push(("no_proxy".to_owned(), no_proxy));
    vars.push((PROXY_VAR.to_owned(), proxy.to_owned()));
    // git's SSH through `tl ssh`, unless something else is set up for it.
    if std::env::var_os("GIT_SSH_COMMAND").is_none() && std::env::var_os("GIT_SSH").is_none() {
        vars.push(("GIT_SSH_COMMAND".to_owned(), format!("{} ssh", sh_quote(&tl_slashed()))));
        vars.push(("GIT_SSH_VARIANT".to_owned(), "ssh".to_owned()));
    }
    vars
}

/// `existing` (comma-separated) plus this computer's own names, each once.
fn merge_no_proxy(existing: &str) -> String {
    let mut out: Vec<&str> = Vec::new();
    for p in existing.split(',').map(str::trim).chain(["localhost", "127.0.0.1", "::1"]) {
        if !p.is_empty() && !out.contains(&p) {
            out.push(p);
        }
    }
    out.join(",")
}

/// Quoted for POSIX shells.
fn sh_quote(s: &str) -> String {
    format!("'{}'", s.replace('\'', r"'\''"))
}

/// Quoted for fish.
fn fish_quote(s: &str) -> String {
    format!("'{}'", s.replace('\\', r"\\").replace('\'', r"\'"))
}

/// Quoted for `PowerShell`.
fn ps_quote(s: &str) -> String {
    format!("'{}'", s.replace('\'', "''"))
}

// ---- Running things ----

/// The program to start for a command name. On Windows that searches `PATH`
/// with `PATHEXT` too, so `npm` finds npm.cmd as a terminal would.
fn resolve(program: &OsStr) -> PathBuf {
    let p = Path::new(program);
    if !cfg!(windows) || p.components().count() > 1 || p.extension().is_some() {
        return p.to_path_buf();
    }
    let exts = std::env::var("PATHEXT").unwrap_or_else(|_| ".COM;.EXE;.BAT;.CMD".to_owned());
    let path = std::env::var_os("PATH").unwrap_or_default();
    for dir in std::env::split_paths(&path) {
        for ext in exts.split(';').filter(|e| !e.is_empty()) {
            let mut name = program.to_os_string();
            name.push(ext.to_ascii_lowercase());
            let candidate = dir.join(name);
            if candidate.is_file() {
                return candidate;
            }
        }
    }
    p.to_path_buf()
}

/// Runs `cmd` in place of `tl` (on Windows: waits for it, leaving Ctrl+C to it)
/// and returns its exit code.
#[cfg(unix)]
fn exec(mut cmd: Command, name: &OsStr) -> Result<i32, String> {
    use std::os::unix::process::CommandExt as _;
    let e = cmd.exec();
    Err(format!("{}: {e}", name.to_string_lossy()))
}

#[cfg(not(unix))]
fn exec(mut cmd: Command, name: &OsStr) -> Result<i32, String> {
    leave_ctrl_c_to_child();
    let status = cmd.status().map_err(|e| format!("{}: {e}", name.to_string_lossy()))?;
    Ok(status.code().unwrap_or(1))
}

/// Ctrl+C reaches every program in the console; the one `tl` runs decides
/// what it means, and `tl` waits for it.
#[cfg(windows)]
fn leave_ctrl_c_to_child() {
    use windows_sys::Win32::System::Console::SetConsoleCtrlHandler;
    unsafe extern "system" fn handled(_: u32) -> windows_sys::core::BOOL {
        1
    }
    // SAFETY: registers a function that lives as long as the program. (A
    // handler, unlike ignoring Ctrl+C outright, isn't inherited by the child.)
    unsafe { SetConsoleCtrlHandler(Some(handled), 1) };
}

#[cfg(not(any(unix, windows)))]
fn leave_ctrl_c_to_child() {}

// ---- ssh, scp, sftp ----

/// Runs ssh, scp or sftp with its connection through `tl --connect`, unless
/// the command or the SSH config already says how to get there (`-J`, a
/// `ProxyJump` or `ProxyCommand`).
fn run_ssh(tool: &str, args: &[OsString]) -> Result<i32, String> {
    let proxy = match std::env::var(PROXY_VAR) {
        Ok(p) => Some(p),
        Err(_) => match app_proxy() {
            Ok(p) => Some(p),
            Err(e) => {
                eprintln!("tl: {e} Running {tool} without it.");
                None
            }
        },
    };
    let strs: Vec<String> = args.iter().map(|a| a.to_string_lossy().into_owned()).collect();
    let mut cmd = Command::new(resolve(OsStr::new(tool)));
    if let Some(proxy) = &proxy {
        if !own_route(tool, &strs) && !config_route(tool, &strs) {
            cmd.arg("-o").arg(proxy_command());
        }
        cmd.envs(env_for(proxy));
    }
    cmd.args(args);
    exec(cmd, OsStr::new(tool))
}

/// The options of ssh, scp and sftp that take a value.
fn valued_options(tool: &str) -> &'static str {
    match tool {
        "scp" => "cDFiJloPSX",
        "sftp" => "BbcDFiJlPoRSsX",
        _ => "BbcDEeFIiJLlmOoPpQRSWw",
    }
}

/// The command line says how to get there: -J, -G (just print the config),
/// or `-o ProxyCommand=` / `-o ProxyJump=`.
fn own_route(tool: &str, args: &[String]) -> bool {
    let valued = valued_options(tool);
    let mut i = 0;
    while i < args.len() {
        let a = &args[i];
        if a == "--" || !a.starts_with('-') || a.len() < 2 {
            // Options come first (ssh stops at the destination).
            if tool == "ssh" {
                return false;
            }
            i += 1;
            continue;
        }
        let flags = &a[1..];
        for (n, c) in flags.char_indices() {
            if c == 'J' || (c == 'G' && tool == "ssh") {
                return true;
            }
            if valued.contains(c) {
                let rest = &flags[n + c.len_utf8()..];
                let value = if rest.is_empty() {
                    i += 1;
                    args.get(i).map_or("", String::as_str)
                } else {
                    rest
                };
                let v = value.trim_start().to_ascii_lowercase();
                if c == 'o' && (v.starts_with("proxycommand") || v.starts_with("proxyjump")) {
                    return true;
                }
                break;
            }
        }
        i += 1;
    }
    false
}

/// The SSH config has a `ProxyJump` or `ProxyCommand` for where this goes
/// (asked with `ssh -G`).
fn config_route(tool: &str, args: &[String]) -> bool {
    let mut g = Command::new(resolve(OsStr::new("ssh")));
    g.arg("-G");
    if tool == "ssh" {
        g.args(args);
    } else {
        let Some(host) = destination(tool, args) else { return false };
        if let Some(file) = option_value(tool, args, 'F') {
            g.arg("-F").arg(file);
        }
        g.arg(host);
    }
    let Ok(out) = g.stdin(std::process::Stdio::null()).stderr(std::process::Stdio::null()).output() else {
        return false;
    };
    has_proxy(&String::from_utf8_lossy(&out.stdout))
}

/// `ssh -G` output names a jump host or proxy command.
fn has_proxy(config: &str) -> bool {
    config.lines().any(|l| {
        let mut parts = l.splitn(2, ' ');
        let key = parts.next().unwrap_or("").to_ascii_lowercase();
        let value = parts.next().unwrap_or("").trim();
        (key == "proxycommand" || key == "proxyjump") && !value.is_empty() && !value.eq_ignore_ascii_case("none")
    })
}

/// The value of option `-<opt>`.
fn option_value(tool: &str, args: &[String], opt: char) -> Option<String> {
    let valued = valued_options(tool);
    let mut i = 0;
    while i < args.len() {
        let a = &args[i];
        if a == "--" {
            return None;
        }
        if let Some(flags) = a.strip_prefix('-').filter(|f| !f.is_empty()) {
            for (n, c) in flags.char_indices() {
                if valued.contains(c) {
                    let rest = &flags[n + c.len_utf8()..];
                    let value = if rest.is_empty() {
                        i += 1;
                        args.get(i).cloned()
                    } else {
                        Some(rest.to_owned())
                    };
                    if c == opt {
                        return value;
                    }
                    break;
                }
            }
        }
        i += 1;
    }
    None
}

/// The remote host of an scp or sftp command line.
fn destination(tool: &str, args: &[String]) -> Option<String> {
    let valued = valued_options(tool);
    let mut positional = Vec::new();
    let mut i = 0;
    while i < args.len() {
        let a = &args[i];
        if a == "--" {
            positional.extend(args[i + 1..].iter().cloned());
            break;
        }
        match a.strip_prefix('-').filter(|f| !f.is_empty()) {
            Some(flags) => {
                if let Some(n) = flags.find(|c| valued.contains(c))
                    && n + 1 == flags.len()
                {
                    i += 1;
                }
            }
            None => positional.push(a.clone()),
        }
        i += 1;
    }
    if tool == "scp" {
        positional.iter().find_map(|p| remote_host(p, true))
    } else {
        remote_host(positional.first()?, false)
    }
}

/// The host in `[user@]host[:path]`, `[user@][v6]:path` or `scp://[user@]host[:port]/path`.
/// With `need_colon` (scp), something without `host:` is a local file.
fn remote_host(arg: &str, need_colon: bool) -> Option<String> {
    let (url, s) = match arg.strip_prefix("scp://").or_else(|| arg.strip_prefix("sftp://")) {
        Some(rest) => (true, rest.split('/').next().unwrap_or("")),
        None => (false, arg),
    };
    let end = s.find([':', '/', '\\']).unwrap_or(s.len());
    if !url && need_colon && !s[end..].starts_with(':') && !s.starts_with('[') {
        return None; // a local path
    }
    let s = match s[..end].rfind('@') {
        Some(at) => &s[at + 1..],
        None => s,
    };
    let host = match s.strip_prefix('[') {
        Some(rest) => rest.split(']').next().unwrap_or(""),
        None => s.split([':', '/', '\\']).next().unwrap_or(""),
    };
    // C:\file on Windows is a drive, not a host called C.
    let drive = cfg!(windows) && host.len() == 1 && !url;
    (!host.is_empty() && !drive).then(|| host.to_owned())
}

// ---- tl --connect ----

/// Connects stdin and stdout to host:port: through the terminal proxy, or
/// directly when Tailnet Link isn't running.
fn connect(args: &[OsString]) -> Result<i32, String> {
    let [host, port] = args else { return Err("usage: tl --connect <host> <port>".to_owned()) };
    let host = host.to_string_lossy();
    let port: u16 = port.to_str().and_then(|p| p.parse().ok()).ok_or("the port must be a number")?;
    let stream = open(&host, port)?;
    pipe(stream)
}

fn open(host: &str, port: u16) -> Result<TcpStream, String> {
    let mut proxies: Vec<String> = std::env::var(PROXY_VAR).into_iter().collect();
    for i in 0.. {
        let Some(proxy) = proxies.get(i).cloned() else { break };
        if let Ok(s) = TcpStream::connect(&proxy) {
            return proxy_connect(s, host, port);
        }
        // The app may have restarted on another port.
        if i == 0
            && let Ok(p) = app_proxy()
            && p != proxy
        {
            proxies.push(p);
        }
    }
    if proxies.is_empty()
        && let Ok(p) = app_proxy()
        && let Ok(s) = TcpStream::connect(&p)
    {
        return proxy_connect(s, host, port);
    }
    // Tailnet Link isn't running: straight there, as ssh would have gone.
    TcpStream::connect((host, port)).map_err(|e| format!("{host}:{port}: {e}"))
}

/// Asks the proxy on `s` to connect to host:port.
fn proxy_connect(mut s: TcpStream, host: &str, port: u16) -> Result<TcpStream, String> {
    let authority = if host.contains(':') { format!("[{host}]:{port}") } else { format!("{host}:{port}") };
    write!(s, "CONNECT {authority} HTTP/1.1\r\nHost: {authority}\r\n\r\n").map_err(|e| e.to_string())?;
    // The answer's head, a byte at a time: what follows it is the connection's.
    let mut head = Vec::new();
    let mut byte = [0u8; 1];
    while !head.ends_with(b"\r\n\r\n") {
        match s.read(&mut byte) {
            Ok(1) => head.push(byte[0]),
            _ => return Err(format!("Tailnet Link closed the connection to {authority}")),
        }
        if head.len() > 64 * 1024 {
            return Err("Tailnet Link's answer was too long".to_owned());
        }
    }
    let status = String::from_utf8_lossy(&head);
    if status.starts_with("HTTP/1.1 200") || status.starts_with("HTTP/1.0 200") {
        return Ok(s);
    }
    let mut body = String::new();
    let _ = s.read_to_string(&mut body);
    let body = body.trim();
    Err(if body.is_empty() { status.lines().next().unwrap_or("").to_owned() } else { body.to_owned() })
}

/// Copies stdin to the connection and the connection to stdout until it closes.
fn pipe(stream: TcpStream) -> Result<i32, String> {
    let mut up = stream.try_clone().map_err(|e| e.to_string())?;
    std::thread::spawn(move || {
        let _ = std::io::copy(&mut std::io::stdin().lock(), &mut up);
        let _ = up.shutdown(Shutdown::Write);
    });
    let mut down = stream;
    let mut out = std::io::stdout().lock();
    let mut buf = [0u8; 16 * 1024];
    loop {
        match down.read(&mut buf) {
            Ok(0) | Err(_) => break,
            Ok(n) => {
                if out.write_all(&buf[..n]).and_then(|()| out.flush()).is_err() {
                    break;
                }
            }
        }
    }
    Ok(0)
}

// ---- tl ping ----

/// Pings a machine in a tailnet with Tailscale's ping; anything else gets the
/// normal ping.
fn ping(args: &[OsString]) -> Result<i32, String> {
    let strs: Vec<String> = args.iter().map(|a| a.to_string_lossy().into_owned()).collect();
    let mut count = Some(4u32);
    let mut host = None;
    let mut i = 0;
    while i < strs.len() {
        match strs[i].as_str() {
            "-c" => {
                i += 1;
                count = Some(strs.get(i).and_then(|n| n.parse().ok()).ok_or("-c needs a number")?);
            }
            "-n" if cfg!(windows) => {
                i += 1;
                count = Some(strs.get(i).and_then(|n| n.parse().ok()).ok_or("-n needs a number")?);
            }
            "-t" => count = None,
            a if a.starts_with('-') => {}
            a => host = Some(a.to_owned()),
        }
        i += 1;
    }
    let Some(host) = host else { return system_ping(args) };
    let path = format!("/tl/ping?host={}", percent_encode(&host));
    let mut answered = false;
    let mut n = 0;
    loop {
        let answer = match ask(&path, Duration::from_secs(15)) {
            Ok(a) => a,
            Err(e) if n == 0 => {
                eprintln!("tl: {e} Using the normal ping.");
                return system_ping(args);
            }
            Err(e) => return Err(e),
        };
        let text = |k: &str| answer.get(k).and_then(|v| v.as_str()).unwrap_or("").to_owned();
        if !answer.get("routed").and_then(serde_json::Value::as_bool).unwrap_or(false) {
            // Not in a tailnet: the normal ping.
            return system_ping(args);
        }
        let error = text("error");
        if !error.is_empty() {
            return Err(error);
        }
        let (node, node_ip) = (text("node"), text("node_ip"));
        if n == 0 && host.parse::<std::net::IpAddr>().is_ok() && host != node_ip && !node.is_empty() {
            println!("{host} is behind {node} ({node_ip}) in {}, so {node} answers.", text("tailnet"));
        }
        if answer.get("timeout").and_then(serde_json::Value::as_bool).unwrap_or(false) {
            println!("no answer from {host} within 5 seconds");
        } else {
            let ms = answer.get("ms").and_then(serde_json::Value::as_f64).unwrap_or(0.0);
            let via = text("via");
            let via = if via.is_empty() { String::new() } else { format!(" via {via}") };
            println!("pong from {node} ({node_ip}){via} in {ms:.0}ms");
            answered = true;
        }
        n += 1;
        if count.is_some_and(|c| n >= c) {
            break;
        }
        std::thread::sleep(Duration::from_secs(1));
    }
    Ok(i32::from(!answered))
}

fn system_ping(args: &[OsString]) -> Result<i32, String> {
    let mut cmd = Command::new(resolve(OsStr::new("ping")));
    cmd.args(args);
    exec(cmd, OsStr::new("ping"))
}

fn percent_encode(s: &str) -> String {
    let mut out = String::new();
    for b in s.bytes() {
        if b.is_ascii_alphanumeric() || b"-._~".contains(&b) {
            out.push(b as char);
        } else {
            let _ = write!(out, "%{b:02X}");
        }
    }
    out
}

// ---- Shells ----

#[derive(Clone, Copy, Debug, PartialEq, Eq)]
enum Kind {
    Bash,
    Zsh,
    Fish,
    PowerShell,
    Cmd,
    /// Another shell: it gets the variables only.
    Other,
}

/// The kind of shell a program name or path is (a Windows path too, on any system).
fn kind_of(name: &str) -> Kind {
    let file = name.rsplit(['/', '\\']).next().unwrap_or(name).to_ascii_lowercase();
    let stem = file.strip_suffix(".exe").unwrap_or(&file);
    match stem {
        "bash" => Kind::Bash,
        "zsh" => Kind::Zsh,
        "fish" => Kind::Fish,
        "pwsh" | "powershell" => Kind::PowerShell,
        "cmd" => Kind::Cmd,
        _ => Kind::Other,
    }
}

/// The shell `tl` was typed in, or the usual one.
fn detect_shell() -> PathBuf {
    #[cfg(windows)]
    {
        const SHELLS: [&str; 9] = ["bash", "zsh", "fish", "pwsh", "powershell", "cmd", "nu", "sh", "elvish"];
        if let Some(parent) = parent_exe() {
            let stem = parent.file_stem().map(|s| s.to_string_lossy().to_ascii_lowercase()).unwrap_or_default();
            if SHELLS.contains(&stem.as_str()) {
                return parent;
            }
        }
        // Started from somewhere else (the app's Open terminal button): PowerShell.
        let pwsh = resolve(OsStr::new("pwsh"));
        if pwsh.is_absolute() {
            return pwsh;
        }
        let root = std::env::var_os("SystemRoot").map_or_else(|| PathBuf::from(r"C:\Windows"), PathBuf::from);
        root.join(r"System32\WindowsPowerShell\v1.0\powershell.exe")
    }
    #[cfg(not(windows))]
    {
        std::env::var_os("SHELL").filter(|s| !s.is_empty()).map_or_else(|| PathBuf::from("/bin/sh"), PathBuf::from)
    }
}

/// The program that started this one.
#[cfg(windows)]
fn parent_exe() -> Option<PathBuf> {
    use std::os::windows::ffi::OsStringExt as _;
    use windows_sys::Win32::Foundation::{CloseHandle, INVALID_HANDLE_VALUE};
    use windows_sys::Win32::System::Diagnostics::ToolHelp::{
        CreateToolhelp32Snapshot, PROCESSENTRY32W, Process32FirstW, Process32NextW, TH32CS_SNAPPROCESS,
    };
    use windows_sys::Win32::System::Threading::{
        GetCurrentProcessId, OpenProcess, PROCESS_QUERY_LIMITED_INFORMATION, QueryFullProcessImageNameW,
    };

    // SAFETY: takes no arguments.
    let me = unsafe { GetCurrentProcessId() };
    // SAFETY: plain flags; the handle is closed below.
    let snap = unsafe { CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0) };
    if snap == INVALID_HANDLE_VALUE {
        return None;
    }
    // SAFETY: PROCESSENTRY32W is plain data, for which all zeros is valid.
    let mut entry: PROCESSENTRY32W = unsafe { std::mem::zeroed() };
    entry.dwSize = u32::try_from(size_of::<PROCESSENTRY32W>()).unwrap_or(0);
    let mut parent = None;
    // SAFETY: a valid snapshot, and an entry with its size filled in.
    let mut more = unsafe { Process32FirstW(snap, &raw mut entry) } != 0;
    while more {
        if entry.th32ProcessID == me {
            parent = Some(entry.th32ParentProcessID);
            break;
        }
        // SAFETY: as above.
        more = unsafe { Process32NextW(snap, &raw mut entry) } != 0;
    }
    // SAFETY: the snapshot handle from above, closed once.
    unsafe { CloseHandle(snap) };
    // SAFETY: plain arguments; a null handle means it couldn't be opened.
    let process = unsafe { OpenProcess(PROCESS_QUERY_LIMITED_INFORMATION, 0, parent?) };
    if process.is_null() {
        return None;
    }
    let mut buf = [0u16; 1024];
    let mut len = u32::try_from(buf.len()).unwrap_or(0);
    // SAFETY: the buffer holds `len` UTF-16 units, and `len` is updated to the length written.
    let ok = unsafe { QueryFullProcessImageNameW(process, 0, buf.as_mut_ptr(), &raw mut len) } != 0;
    // SAFETY: the process handle from above, closed once.
    unsafe { CloseHandle(process) };
    ok.then(|| PathBuf::from(OsString::from_wide(&buf[..len as usize])))
}

/// Shell functions sending [`WRAPPED`] through `tl`, for POSIX shells.
fn posix_functions() -> String {
    let tl = sh_quote(&tl_slashed());
    WRAPPED.iter().fold(String::new(), |mut out, c| {
        let _ = writeln!(out, "{c}() {{ {tl} {c} \"$@\"; }}");
        out
    })
}

fn fish_functions() -> String {
    let tl = fish_quote(&tl_slashed());
    WRAPPED.iter().fold(String::new(), |mut out, c| {
        let _ = writeln!(out, "function {c}; {tl} {c} $argv; end");
        out
    })
}

fn powershell_functions() -> String {
    let tl = ps_quote(&tl_exe().to_string_lossy());
    WRAPPED.iter().fold(String::new(), |mut out, c| {
        let _ = writeln!(out, "function global:{c} {{ & {tl} {c} @args }}");
        out
    })
}

fn cmd_macros() -> Vec<String> {
    let tl = tl_exe().to_string_lossy().into_owned();
    WRAPPED.iter().map(|c| format!("doskey {c}=\"{tl}\" {c} $*")).collect()
}

/// Opens the shell `tl` was typed in (or the usual one) with everything set up,
/// and "(tl)" in front of its prompt.
fn shell() -> Result<i32, String> {
    if std::env::var_os(PROXY_VAR).is_some() {
        eprintln!("tl: this shell already works with your tailnets.");
        return Ok(0);
    }
    let proxy = app_proxy()?;
    let path = detect_shell();
    let kind = kind_of(&path.to_string_lossy());
    let mut cmd = Command::new(&path);
    cmd.envs(env_for(&proxy));
    let setup = config_dir().join("tl");
    let write = |name: &str, text: String| -> Result<PathBuf, String> {
        let file = setup.join(name);
        std::fs::create_dir_all(file.parent().unwrap_or(&setup))
            .and_then(|()| std::fs::write(&file, text))
            .map_err(|e| format!("writing {}: {e}", file.display()))?;
        Ok(file)
    };
    match kind {
        Kind::Bash => {
            // What bash reads without --rcfile, then Git Bash's prompt, which comes
            // from its login profile (skipped by a non-login shell).
            let rc = format!(
                "if [ -f /etc/bash.bashrc ]; then . /etc/bash.bashrc; fi\n\
                 if [ -n \"$MSYSTEM\" ] && [ -f /etc/profile.d/git-prompt.sh ]; then . /etc/profile.d/git-prompt.sh; fi\n\
                 if [ -f ~/.bashrc ]; then . ~/.bashrc; fi\n{}PS1=\"(tl) $PS1\"\n",
                posix_functions()
            );
            let file = write("bashrc", rc)?;
            let file = file.to_string_lossy().replace('\\', "/");
            cmd.arg("--rcfile").arg(file).arg("-i");
        }
        Kind::Zsh => {
            let original = std::env::var_os("ZDOTDIR").or_else(|| dirs::home_dir().map(PathBuf::into_os_string));
            write(
                "zsh/.zshenv",
                "TL_OWN_ZDOTDIR=\"$ZDOTDIR\"\nZDOTDIR=\"${TL_ZDOTDIR:-$HOME}\"\n\
                 [ -f \"$ZDOTDIR/.zshenv\" ] && . \"$ZDOTDIR/.zshenv\"\n\
                 TL_ZDOTDIR=\"$ZDOTDIR\"\nZDOTDIR=\"$TL_OWN_ZDOTDIR\"\n"
                    .to_owned(),
            )?;
            let rc = format!(
                "ZDOTDIR=\"${{TL_ZDOTDIR:-$HOME}}\"\n[ -f \"$ZDOTDIR/.zshrc\" ] && . \"$ZDOTDIR/.zshrc\"\n{}PROMPT=\"(tl) $PROMPT\"\n",
                posix_functions()
            );
            let file = write("zsh/.zshrc", rc)?;
            cmd.env("ZDOTDIR", file.parent().unwrap_or(&setup));
            if let Some(o) = original {
                cmd.env("TL_ZDOTDIR", o);
            }
            cmd.arg("-i");
        }
        Kind::Fish => {
            let init = format!(
                "{}if functions -q fish_prompt; functions -c fish_prompt __tl_fish_prompt; \
                 function fish_prompt; printf '(tl) '; __tl_fish_prompt; end; end",
                fish_functions()
            );
            cmd.arg("-C").arg(init);
        }
        Kind::PowerShell => {
            let script = format!(
                "{}$global:__tlPrompt = $function:prompt\nfunction global:prompt {{ '(tl) ' + (& $global:__tlPrompt) }}\n",
                powershell_functions()
            );
            cmd.args(["-NoLogo", "-NoExit", "-EncodedCommand", &encode_powershell(&script)]);
        }
        Kind::Cmd => {
            let prompt = std::env::var("PROMPT").unwrap_or_else(|_| "$P$G".to_owned());
            let line = format!("/k {} & prompt (tl) {prompt}", cmd_macros().join(" & "));
            raw_arg(&mut cmd, &line);
        }
        Kind::Other => {}
    }
    eprintln!(
        "Tailnet Link: the names and addresses in your tailnets work in this shell, for curl, git, ssh, ping and \
         most other tools. Type exit to leave."
    );
    exec(cmd, path.as_os_str())
}

/// A `PowerShell` script for `-EncodedCommand`: base64 of its UTF-16.
fn encode_powershell(script: &str) -> String {
    use base64::Engine as _;
    let bytes: Vec<u8> = script.encode_utf16().flat_map(u16::to_le_bytes).collect();
    base64::engine::general_purpose::STANDARD.encode(bytes)
}

/// cmd.exe reads its command line its own way, so it gets it unquoted.
#[cfg(windows)]
fn raw_arg(cmd: &mut Command, line: &str) {
    use std::os::windows::process::CommandExt as _;
    cmd.raw_arg(line);
}

#[cfg(not(windows))]
fn raw_arg(cmd: &mut Command, line: &str) {
    cmd.arg(line);
}

// ---- tl --env ----

/// Prints the setup for a shell, for its profile or to paste: the variables
/// and the functions (no prompt change). Prints nothing when the app isn't running.
fn print_env(shell: Option<&str>) -> Result<i32, String> {
    let proxy = app_proxy()?;
    let kind = match shell {
        Some("sh" | "dash" | "ksh") => Kind::Bash,
        Some(name) => kind_of(name),
        None => match kind_of(&detect_shell().to_string_lossy()) {
            Kind::Other => Kind::Bash,
            k => k,
        },
    };
    print!("{}", env_script(kind, &env_for(&proxy)));
    Ok(0)
}

fn env_script(kind: Kind, vars: &[(String, String)]) -> String {
    let mut s = String::new();
    for (k, v) in vars {
        let line = match kind {
            Kind::Fish => format!("set -gx {k} {}\n", fish_quote(v)),
            Kind::PowerShell => format!("$env:{k} = {}\n", ps_quote(v)),
            Kind::Cmd => format!("set \"{k}={v}\"\n"),
            _ => format!("export {k}={}\n", sh_quote(v)),
        };
        s.push_str(&line);
    }
    s.push_str(&match kind {
        Kind::Fish => fish_functions(),
        Kind::PowerShell => powershell_functions(),
        Kind::Cmd => cmd_macros().iter().map(|m| m.clone() + "\n").collect(),
        _ => posix_functions(),
    });
    s
}

#[cfg(test)]
mod tests {
    use super::*;
    use std::net::TcpListener;

    fn strings(args: &[&str]) -> Vec<String> {
        args.iter().map(|a| (*a).to_owned()).collect()
    }

    #[test]
    fn own_ssh_routes_are_kept() {
        assert!(!own_route("ssh", &strings(&["-p", "2222", "admin@build.example.ts.net"])));
        assert!(own_route("ssh", &strings(&["-J", "bastion", "db"])));
        assert!(own_route("ssh", &strings(&["-vJbastion", "db"])));
        assert!(own_route("ssh", &strings(&["-o", "ProxyJump=bastion", "db"])));
        assert!(own_route("ssh", &strings(&["-oProxyCommand=nc %h %p", "db"])));
        assert!(own_route("ssh", &strings(&["-G", "db"])), "git asking which ssh this is");
        assert!(!own_route("ssh", &strings(&["-o", "SendEnv=GIT_PROTOCOL", "db", "git-upload-pack 'x'"])));
        // After the destination it's the remote command, not options.
        assert!(!own_route("ssh", &strings(&["db", "-J", "x"])));
        assert!(own_route("scp", &strings(&["file", "-J", "bastion", "db:/tmp/"])));
        assert!(!own_route("scp", &strings(&["-P", "22", "file", "db:/tmp/"])));
    }

    #[test]
    fn scp_and_sftp_destinations() {
        assert_eq!(
            destination("scp", &strings(&["-i", "key", "a.txt", "me@db.example.ts.net:/tmp/"])).as_deref(),
            Some("db.example.ts.net")
        );
        assert_eq!(destination("scp", &strings(&["db:/x", "."])).as_deref(), Some("db"));
        assert_eq!(destination("scp", &strings(&["scp://me@db:2222/x", "."])).as_deref(), Some("db"));
        assert_eq!(destination("scp", &strings(&["[fd7a::1]:/x", "."])).as_deref(), Some("fd7a::1"));
        assert_eq!(destination("scp", &strings(&["./a:b", "dir/"])), None, "local paths only");
        assert_eq!(
            destination("sftp", &strings(&["-P", "22", "me@db.example.ts.net"])).as_deref(),
            Some("db.example.ts.net")
        );
        assert_eq!(destination("sftp", &strings(&["db:/home"])).as_deref(), Some("db"));
        assert_eq!(option_value("scp", &strings(&["-F", "my_config", "a", "db:"]), 'F').as_deref(), Some("my_config"));
        assert_eq!(option_value("scp", &strings(&["-Fmy_config", "a", "db:"]), 'F').as_deref(), Some("my_config"));
        if cfg!(windows) {
            assert_eq!(destination("scp", &strings(&[r"C:\a.txt", "db:/tmp/"])).as_deref(), Some("db"));
        }
    }

    #[test]
    fn ssh_config_proxies() {
        assert!(has_proxy("user me\nproxyjump bastion\nport 22\n"));
        assert!(has_proxy("proxycommand nc %h %p\n"));
        assert!(!has_proxy("user me\nproxycommand none\nport 22\n"));
        assert!(!has_proxy("user me\nport 22\n"));
    }

    #[test]
    fn variables_and_scripts() {
        assert_eq!(merge_no_proxy(""), "localhost,127.0.0.1,::1");
        assert_eq!(merge_no_proxy(" corp.example , localhost,"), "corp.example,localhost,127.0.0.1,::1");
        assert_eq!(sh_quote("it's"), r"'it'\''s'");
        assert_eq!(ps_quote("it's"), "'it''s'");
        assert_eq!(fish_quote(r"a\b'c"), r"'a\\b\'c'");
        assert_eq!(percent_encode("fd7a::1"), "fd7a%3A%3A1");
        assert_eq!(percent_encode("db.example.ts.net"), "db.example.ts.net");
        assert!(proxy_command().starts_with("ProxyCommand=\"") && proxy_command().ends_with("\" --connect %h %p"));

        let vars = vec![("HTTPS_PROXY".to_owned(), "http://127.0.0.1:1056".to_owned())];
        let bash = env_script(Kind::Bash, &vars);
        assert!(bash.starts_with("export HTTPS_PROXY='http://127.0.0.1:1056'\n"), "{bash}");
        assert!(bash.contains("ssh() {") && bash.contains(" ping \"$@\"; }"), "{bash}");
        let ps = env_script(Kind::PowerShell, &vars);
        assert!(ps.starts_with("$env:HTTPS_PROXY = 'http://127.0.0.1:1056'\n") && ps.contains("function global:scp"));
        let fish = env_script(Kind::Fish, &vars);
        assert!(fish.starts_with("set -gx HTTPS_PROXY 'http://127.0.0.1:1056'\n") && fish.contains("function sftp;"));
        let cmd = env_script(Kind::Cmd, &vars);
        assert!(cmd.starts_with("set \"HTTPS_PROXY=http://127.0.0.1:1056\"\n") && cmd.contains("doskey ssh="));

        assert_eq!(kind_of(r"C:\Program Files\Git\usr\bin\bash.exe"), Kind::Bash);
        assert_eq!(kind_of("/usr/bin/zsh"), Kind::Zsh);
        assert_eq!(kind_of("pwsh"), Kind::PowerShell);
        assert_eq!(kind_of("nu"), Kind::Other);
        // "ab" in UTF-16LE, base64.
        assert_eq!(encode_powershell("ab"), "YQBiAA==");
    }

    /// A proxy that answers CONNECT with `status` and then echoes (or, when
    /// refusing, closes the connection as the real one does).
    fn fake_proxy(status: &'static str) -> String {
        let ln = TcpListener::bind("127.0.0.1:0").unwrap();
        let addr = ln.local_addr().unwrap().to_string();
        std::thread::spawn(move || {
            let (mut c, _) = ln.accept().unwrap();
            let mut head = Vec::new();
            let mut b = [0u8; 1];
            while !head.ends_with(b"\r\n\r\n") {
                c.read_exact(&mut b).unwrap();
                head.push(b[0]);
            }
            assert!(head.starts_with(b"CONNECT db.example.ts.net:22 HTTP/1.1\r\n"));
            c.write_all(status.as_bytes()).unwrap();
            if !status.starts_with("HTTP/1.1 200") {
                return;
            }
            let mut r = c.try_clone().unwrap();
            let _ = std::io::copy(&mut r, &mut c);
        });
        addr
    }

    #[test]
    fn connects_through_the_proxy() {
        let s = TcpStream::connect(fake_proxy("HTTP/1.1 200 Connection Established\r\n\r\n")).unwrap();
        let mut s = proxy_connect(s, "db.example.ts.net", 22).unwrap();
        s.write_all(b"SSH-2.0-test\r\n").unwrap();
        let mut echo = [0u8; 14];
        s.read_exact(&mut echo).unwrap();
        assert_eq!(&echo, b"SSH-2.0-test\r\n");

        let refused = "HTTP/1.1 502 Bad Gateway\r\nContent-Length: 14\r\nConnection: close\r\n\r\nno such machine";
        let s = TcpStream::connect(fake_proxy(refused)).unwrap();
        let e = proxy_connect(s, "db.example.ts.net", 22).unwrap_err();
        assert!(e.contains("no such machine"), "{e}");
    }
}
