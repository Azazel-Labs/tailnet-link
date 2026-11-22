//! The app's engine: the tailnets (libtailscale nodes), routing by name, the
//! local proxy, port forwards and the system proxy setting. The UI only reads
//! `status()` and calls the action methods; everything here is thread-safe.

use std::collections::HashMap;
use std::fmt::Write as _;
use std::net::TcpListener as StdListener;
use std::sync::atomic::{AtomicU64, Ordering};
use std::sync::{Arc, Mutex};
use std::time::{Duration, Instant, SystemTime, UNIX_EPOCH};

use crate::config::{self, Config, Forward, TailnetConfig};
use crate::i18n::tr;
use crate::proxy::{self, PacState, Router};
use crate::sync::lock;
use crate::sysproxy::{ProxyError, SystemProxy};
use crate::tsnet::{Node, SocksTarget};

/// A machine in one of the tailnets.
#[derive(Clone, Debug, Default, PartialEq, Eq)]
pub struct Machine {
    /// Short name, e.g. build-pc.
    pub name: String,
    /// Full MagicDNS name, e.g. build-pc.example.ts.net.
    pub dns_name: String,
    pub os: String,
    pub online: bool,
    /// Its first Tailscale address (`IPv4` when it has one).
    pub ip: String,
}

impl Machine {
    /// Case-insensitive match on name, full name, OS or address.
    pub fn matches(&self, query: &str) -> bool {
        let q = query.trim().to_lowercase();
        q.is_empty() || [&self.dns_name, &self.os, &self.ip].iter().any(|f| f.to_lowercase().contains(&q))
    }
}

/// Machines from a Tailscale status: online first, then by name.
fn machines_of(st: &crate::tsnet::Status) -> Vec<Machine> {
    let mut out: Vec<Machine> = st
        .peers
        .iter()
        .flatten()
        .filter_map(|(_, p)| {
            let dns_name = p.dns_name.trim_end_matches('.').to_lowercase();
            if dns_name.is_empty() {
                return None;
            }
            let name = dns_name.split('.').next().unwrap_or(&dns_name).to_owned();
            let ips = p.ips.clone().unwrap_or_default();
            let ip = ips.iter().find(|i| !i.contains(':')).or(ips.first()).cloned().unwrap_or_default();
            Some(Machine { name, dns_name, os: p.os.clone(), online: p.online, ip })
        })
        .collect();
    out.sort_by(|a, b| b.online.cmp(&a.online).then_with(|| a.name.cmp(&b.name)));
    out
}

/// A port forward as the UI shows it.
#[derive(Clone, Debug, Default)]
pub struct ForwardStatus {
    pub local_port: u16,
    pub target: String,
    /// The tailnet that carries it right now ("" if none does).
    pub via: String,
    /// Why it isn't listening, if it isn't.
    pub error: String,
}

/// One tailnet as the UI shows it.
#[derive(Clone, Debug, Default)]
pub struct TailnetStatus {
    pub id: String,
    pub name: String,
    /// `NeedsLogin`, Starting, Running, ...
    pub backend: String,
    pub tailnet: String,
    /// This computer's name in that tailnet.
    pub self_name: String,
    pub domains: Vec<String>,
    pub extra: Vec<String>,
    pub connected: bool,
    pub enabled: bool,
    pub routing: bool,
    pub login_wait: bool,
    /// The sign-in page, while a sign-in is waiting.
    pub auth_url: String,
    pub machines: Vec<Machine>,
    pub problem: String,
}

impl TailnetStatus {
    pub fn needs_login(&self) -> bool {
        self.backend == "NeedsLogin" || self.backend == "NeedsMachineAuth"
    }

    pub fn label(&self) -> String {
        if !self.name.is_empty() {
            self.name.clone()
        } else if !self.tailnet.is_empty() {
            self.tailnet.clone()
        } else {
            tr!("new-tailnet")
        }
    }
}

/// Whether the system proxy setting sends these tailnets' names to the app,
/// as checked against the setting itself (not just what we last wrote).
#[derive(Clone, Debug, Default, PartialEq, Eq)]
pub enum SystemProxyState {
    /// Nothing routes, so the setting isn't needed.
    #[default]
    Idle,
    /// The setting points at this app.
    Active,
    /// The user chose "Off": only apps they set up themselves use the app.
    Manual,
    /// Another program's setup script is in place (its address).
    Taken(String),
    /// Another running copy of Tailnet Link has the setting.
    OtherCopy,
    /// Something else changed the setting after we set it.
    Changed,
    /// Changing the setting failed.
    Failed(String),
}

impl SystemProxyState {
    /// Routing is on, but browsers won't use it.
    pub fn is_problem(&self) -> bool {
        matches!(self, Self::Taken(_) | Self::OtherCopy | Self::Changed | Self::Failed(_))
    }
}

impl From<ProxyError> for SystemProxyState {
    fn from(e: ProxyError) -> Self {
        match e {
            ProxyError::Taken(s) => Self::Taken(s),
            ProxyError::OtherCopy => Self::OtherCopy,
            ProxyError::Changed => Self::Changed,
            ProxyError::Failed(s) => Self::Failed(s),
        }
    }
}

/// A newer release than this one.
#[derive(Clone, Debug, PartialEq, Eq)]
pub struct Update {
    pub version: String,
    pub url: String,
}

/// The whole app as the UI shows it.
#[derive(Clone, Debug, Default)]
pub struct Status {
    pub tailnets: Vec<TailnetStatus>,
    pub enabled: bool,
    pub routing: bool,
    pub problem: String,
    pub listen: String,
    pub forwards: Vec<ForwardStatus>,
    /// The address of our setup script, for apps set up by hand.
    pub pac_url: String,
    pub system: SystemProxyState,
    /// The system proxy setting as last read ("" for none).
    pub system_setting: String,
    pub update: Option<Update>,
}

impl Status {
    pub fn summary(&self) -> String {
        let routing = self.tailnets.iter().filter(|t| t.routing).count();
        let login = self.tailnets.iter().filter(|t| t.needs_login()).count();
        let n = self.tailnets.len();
        if n == 0 {
            tr!("summary-no-tailnets")
        } else if !self.enabled {
            tr!("summary-paused")
        } else if routing > 0 && self.system.is_problem() {
            tr!("summary-proxy-problem")
        } else if routing == n {
            if n == 1 {
                tr!("summary-routing-one", tailnet = self.tailnets[0].label())
            } else {
                tr!("summary-routing-all", count = n)
            }
        } else if routing > 0 {
            tr!("summary-routing-some", routing = routing, count = n)
        } else if login > 0 {
            tr!("summary-signed-out")
        } else if !self.problem.is_empty() {
            tr!("summary-problem", problem = self.problem.as_str())
        } else {
            tr!("summary-connecting")
        }
    }

    pub fn any_needs_login(&self) -> bool {
        self.tailnets.iter().any(TailnetStatus::needs_login)
    }
}

struct Entry {
    node: Option<Arc<Node>>,
    st: TailnetStatus,
    open_url: String,
    shields: bool,
}

struct Inner {
    cfg: Config,
    entries: HashMap<String, Entry>,
    sys: Option<SystemProxy>,
    pac: Vec<u8>,
    pac_ver: u64,
    routing: bool,
    problem: String,
    forwards: HashMap<String, tokio::task::AbortHandle>,
    /// Port forwards that couldn't listen, by local port.
    forward_errors: HashMap<u16, String>,
    system: SystemProxyState,
    system_setting: String,
    /// When the system proxy setting is next read back (None: on the next poll).
    system_check_at: Option<Instant>,
    /// Why the system proxy setting can't be managed at all here.
    system_unavailable: String,
    update: Option<Update>,
}

/// How often the system proxy setting is read back while routing.
const SYSTEM_CHECK_EVERY: Duration = Duration::from_secs(5);

type Callback = Box<dyn Fn() + Send + Sync>;

pub struct Core {
    inner: Mutex<Inner>,
    pac_state: Arc<PacState>,
    rt: tokio::runtime::Runtime,
    on_change: Mutex<Option<Callback>>,
    on_show: Mutex<Option<Callback>>,
    version: AtomicU64,
}

/// Lets the proxy ask the core which tailnet handles a name.
struct CoreRouter(std::sync::Weak<Core>);

impl Router for CoreRouter {
    fn route(&self, host: &str) -> Option<SocksTarget> {
        self.0.upgrade()?.socks_for(host)
    }
    fn show(&self) {
        if let Some(c) = self.0.upgrade() {
            c.request_show();
        }
    }
}

impl Core {
    pub fn new(cfg: Config) -> Arc<Core> {
        let pac_ver = SystemTime::now().duration_since(UNIX_EPOCH).map_or(1, |d| d.as_secs());
        Arc::new(Core {
            inner: Mutex::new(Inner {
                cfg,
                entries: HashMap::new(),
                sys: None,
                pac: Vec::new(),
                pac_ver,
                routing: false,
                problem: String::new(),
                forwards: HashMap::new(),
                forward_errors: HashMap::new(),
                system: SystemProxyState::Idle,
                system_setting: String::new(),
                system_check_at: None,
                system_unavailable: String::new(),
                update: None,
            }),
            pac_state: Arc::new(PacState::new()),
            rt: tokio::runtime::Builder::new_multi_thread()
                .worker_threads(2)
                .enable_all()
                .thread_name("proxy")
                .build()
                .expect("tokio runtime"),
            on_change: Mutex::new(None),
            on_show: Mutex::new(None),
            version: AtomicU64::new(0),
        })
    }

    pub fn set_on_change(&self, f: impl Fn() + Send + Sync + 'static) {
        *lock(&self.on_change) = Some(Box::new(f));
    }

    pub fn set_on_show(&self, f: impl Fn() + Send + Sync + 'static) {
        *lock(&self.on_show) = Some(Box::new(f));
    }

    /// Asks the UI to bring its window forward (tray click, second launch).
    pub fn request_show(&self) {
        if let Some(f) = lock(&self.on_show).as_ref() {
            f();
        }
    }

    /// Bumped whenever something visible changes.
    pub fn version(&self) -> u64 {
        self.version.load(Ordering::SeqCst)
    }

    fn changed(&self) {
        self.version.fetch_add(1, Ordering::SeqCst);
        if let Some(f) = lock(&self.on_change).as_ref() {
            f();
        }
    }

    pub fn config(&self) -> Config {
        lock(&self.inner).cfg.clone()
    }

    pub fn status(&self) -> Status {
        let g = lock(&self.inner);
        Status {
            tailnets: g.cfg.tailnets.iter().filter_map(|t| g.entries.get(&t.id).map(|e| e.st.clone())).collect(),
            enabled: g.cfg.enabled,
            routing: g.routing,
            problem: g.problem.clone(),
            listen: g.cfg.listen.clone(),
            forwards: g
                .cfg
                .forwards
                .iter()
                .map(|f| {
                    let (host, _) = proxy::split_host_port(&f.target, 0);
                    ForwardStatus {
                        local_port: f.local_port,
                        target: f.target.clone(),
                        via: node_for_in(&g, &host)
                            .and_then(|id| g.entries.get(&id))
                            .map(|e| e.st.label())
                            .unwrap_or_default(),
                        error: g.forward_errors.get(&f.local_port).cloned().unwrap_or_default(),
                    }
                })
                .collect(),
            pac_url: pac_url_of(&g),
            system: g.system.clone(),
            system_setting: g.system_setting.clone(),
            update: g.update.clone(),
        }
    }

    fn set_problem(&self, msg: String) {
        log::warn!("{msg}");
        lock(&self.inner).problem = msg;
        self.changed();
    }

    // ---- Start / stop ----

    /// Brings everything up. Errors only if the app can't run at all.
    pub fn start(self: &Arc<Self>) -> Result<(), String> {
        let ln = self.listen()?;
        ln.set_nonblocking(true).map_err(|e| e.to_string())?;
        let router: Arc<dyn Router> = Arc::new(CoreRouter(Arc::downgrade(self)));
        let pac = self.pac_state.clone();
        {
            let _g = self.rt.enter();
            let ln = tokio::net::TcpListener::from_std(ln).map_err(|e| e.to_string())?;
            self.rt.spawn(proxy::serve(ln, router, pac));
        }
        log::info!("Local proxy on {}", self.config().listen);

        for tc in self.config().tailnets {
            if let Err(e) = self.start_node(&tc) {
                log::warn!("[{}] {e}", tc.id);
            }
        }
        {
            let mut g = lock(&self.inner);
            apply_system_proxy_mode(&mut g);
            self.rebuild_pac(&mut g);
        }
        self.apply_forwards();

        let me = Arc::downgrade(self);
        std::thread::Builder::new()
            .name("monitor".into())
            .spawn(move || {
                loop {
                    let Some(core) = me.upgrade() else { return };
                    core.poll_all();
                    drop(core);
                    std::thread::sleep(Duration::from_secs(2));
                }
            })
            .map_err(|e| e.to_string())?;

        let me = Arc::downgrade(self);
        std::thread::Builder::new()
            .name("updates".into())
            .spawn(move || {
                std::thread::sleep(crate::update::FIRST_AFTER);
                let mut next = Instant::now();
                loop {
                    let Some(core) = me.upgrade() else { return };
                    if core.config().check_updates && Instant::now() >= next {
                        next = Instant::now() + crate::update::EVERY;
                        match crate::update::check() {
                            Ok(u) => core.set_update(u),
                            Err(e) => log::info!("Couldn't check for updates: {e}"),
                        }
                    }
                    drop(core);
                    std::thread::sleep(Duration::from_secs(60));
                }
            })
            .map_err(|e| e.to_string())?;
        Ok(())
    }

    fn set_update(&self, u: Option<Update>) {
        {
            let mut g = lock(&self.inner);
            if g.update == u {
                return;
            }
            if let Some(u) = &u {
                log::info!("Tailnet Link {} is available: {}", u.version, u.url);
            }
            g.update = u;
        }
        self.changed();
    }

    /// Turns the update check on or off.
    pub fn set_check_updates(&self, on: bool) -> Result<(), String> {
        let res = {
            let mut g = lock(&self.inner);
            g.cfg.check_updates = on;
            if !on {
                g.update = None;
            }
            g.cfg.save()
        };
        self.changed();
        res
    }

    /// Remembers that a notification has been shown for this version.
    pub fn mark_update_notified(&self, version: &str) {
        let mut g = lock(&self.inner);
        if g.cfg.update_notified != version {
            version.clone_into(&mut g.cfg.update_notified);
            let _ = g.cfg.save();
        }
    }

    /// Opens the proxy port. If another program has it, uses a free port instead (and saves it).
    fn listen(&self) -> Result<StdListener, String> {
        let want = self.config().listen;
        match StdListener::bind(&want) {
            Ok(l) => Ok(l),
            Err(e) => {
                let l = StdListener::bind("127.0.0.1:0")
                    .map_err(|e2| format!("can't open a local port: {e2} (and {want}: {e})"))?;
                let addr = l.local_addr().map_err(|e| e.to_string())?.to_string();
                log::info!("Port {want} is in use by another program; using {addr} instead");
                let mut g = lock(&self.inner);
                g.cfg.listen = addr;
                let _ = g.cfg.save();
                Ok(l)
            }
        }
    }

    fn start_node(&self, tc: &TailnetConfig) -> Result<(), String> {
        let hostname = self.config().hostname;
        let mut st = TailnetStatus {
            id: tc.id.clone(),
            name: tc.name.clone(),
            backend: "Starting".into(),
            enabled: tc.enabled,
            domains: tc.domains(),
            extra: tc.extra_domains.clone(),
            ..Default::default()
        };
        log::info!("[{}] starting its Tailscale node", tc.id);
        let node = match Node::start(&config::node_dir(&tc.id), &hostname) {
            Ok(n) => {
                log::info!("[{}] Tailscale node started", tc.id);
                Some(Arc::new(n))
            }
            Err(e) => {
                st.problem.clone_from(&e);
                lock(&self.inner)
                    .entries
                    .insert(tc.id.clone(), Entry { node: None, st, open_url: String::new(), shields: false });
                return Err(e);
            }
        };
        lock(&self.inner).entries.insert(tc.id.clone(), Entry { node, st, open_url: String::new(), shields: false });
        Ok(())
    }

    /// Turns routing off, restores the proxy setting and stops everything. Called on Quit.
    pub fn shutdown(&self) {
        let nodes: Vec<Arc<Node>> = {
            let mut g = lock(&self.inner);
            self.pac_state.set_active(false);
            if let Some(s) = g.sys.as_ref() {
                s.disable();
            }
            for (_, h) in g.forwards.drain() {
                h.abort();
            }
            g.entries.values_mut().filter_map(|e| e.node.take()).collect()
        };
        drop(nodes); // closes each node
        log::info!("Stopped.");
    }

    // ---- Routing ----

    /// The routing tailnet whose domain matches host (longest match wins).
    pub fn node_for(&self, host: &str) -> Option<String> {
        node_for_in(&lock(&self.inner), host)
    }

    fn socks_for(&self, host: &str) -> Option<SocksTarget> {
        let id = self.node_for(host)?;
        let g = lock(&self.inner);
        g.entries.get(&id)?.node.as_ref().map(|n| n.socks())
    }

    /// Decides which tailnets route, rebuilds the PAC if the domains changed,
    /// and turns the system proxy on only while something routes.
    fn update_routing(&self, g: &mut Inner) {
        let mut any = false;
        let mut claimed: HashMap<String, String> = HashMap::new();
        let master = g.cfg.enabled;
        for tc in g.cfg.tailnets.clone() {
            let Some(e) = g.entries.get_mut(&tc.id) else {
                continue;
            };
            e.st.enabled = tc.enabled;
            e.st.name.clone_from(&tc.name);
            e.st.extra.clone_from(&tc.extra_domains);
            e.st.domains = tc.domains();
            let want = master && tc.enabled && e.st.connected && !e.st.domains.is_empty();
            if want {
                for d in &e.st.domains {
                    if let Some(other) = claimed.get(d) {
                        e.st.problem = tr!("domain-conflict", domain = d.as_str(), tailnet = other.as_str());
                    } else {
                        claimed.insert(d.clone(), e.st.label());
                    }
                }
            }
            if want != e.st.routing {
                if want {
                    log::info!("[{}] routing ON for {:?}", tc.id, e.st.domains);
                } else {
                    log::info!("[{}] routing OFF", tc.id);
                }
            }
            e.st.routing = want;
            any |= want;
        }
        let flipped = any != g.routing;
        g.routing = any;
        self.rebuild_pac(g);
        self.pac_state.set_active(any);
        if flipped {
            g.system_check_at = None;
        }
        sync_system_proxy(g);
    }

    fn rebuild_pac(&self, g: &mut Inner) {
        let domains: Vec<String> = g
            .cfg
            .tailnets
            .iter()
            .filter_map(|t| g.entries.get(&t.id))
            .filter(|e| e.st.routing)
            .flat_map(|e| e.st.domains.clone())
            .collect();
        let pac = proxy::build_pac(&g.cfg.listen, &domains);
        if pac == g.pac {
            return;
        }
        g.pac.clone_from(&pac);
        g.pac_ver += 1;
        self.pac_state.set_pac(pac);
        let url = pac_url_of(g);
        if let Some(s) = g.sys.as_ref()
            && let Err(e) = s.update(&url)
        {
            log::warn!("updating system proxy setting: {e}");
        }
    }

    // ---- Watching the tailnets ----

    fn poll_all(&self) {
        let nodes: Vec<(String, Arc<Node>)> = {
            let g = lock(&self.inner);
            g.entries.iter().filter_map(|(id, e)| e.node.clone().map(|n| (id.clone(), n))).collect()
        };
        let mut changed = false;
        let mut to_open = Vec::new();
        for (id, node) in nodes {
            let (c, open) = self.poll(&id, &node);
            changed |= c;
            to_open.extend(open);
        }
        {
            let mut g = lock(&self.inner);
            let before = (g.routing, g.system.clone(), g.system_setting.clone());
            self.update_routing(&mut g);
            changed |= before != (g.routing, g.system.clone(), g.system_setting.clone());
        }
        for u in to_open {
            log::info!("Opening the sign-in page: {u}");
            if let Err(e) = open::that_detached(&u) {
                log::warn!("couldn't open the browser: {e}");
            }
        }
        if changed {
            self.changed();
        }
    }

    /// Refreshes one tailnet's state. Returns whether anything visible changed,
    /// and a sign-in page to open, if any.
    fn poll(&self, id: &str, node: &Node) -> (bool, Option<String>) {
        let st = match node.status() {
            Ok(st) => st,
            Err(e) => {
                let mut g = lock(&self.inner);
                let Some(en) = g.entries.get_mut(id) else {
                    return (false, None);
                };
                let changed = en.st.problem != e;
                en.st.problem = e;
                return (changed, None);
            }
        };
        let connected = st.backend_state == "Running";

        let needs_shields = connected && !lock(&self.inner).entries.get(id).is_some_and(|e| e.shields);
        if needs_shields {
            // Nothing in that tailnet may connect to this computer.
            match node.set_shields_up() {
                Ok(()) => {
                    if let Some(e) = lock(&self.inner).entries.get_mut(id) {
                        e.shields = true;
                    }
                }
                Err(e) => log::warn!("[{id}] couldn't enable shields-up: {e}"),
            }
        }

        let mut g = lock(&self.inner);
        let learned = st
            .current_tailnet
            .as_ref()
            .map(|t| (t.magic_dns_suffix.trim_end_matches('.').to_lowercase(), t.name.clone()));
        if let Some((suffix, name)) = &learned
            && !suffix.is_empty()
        {
            learn_domain(&mut g, id, suffix, name);
        }
        let Some(e) = g.entries.get_mut(id) else {
            return (false, None);
        };
        let prev = e.st.clone();
        if !connected {
            e.shields = false;
        }
        e.st.backend.clone_from(&st.backend_state);
        e.st.connected = connected;
        if let Some(s) = &st.self_node {
            s.dns_name.trim_end_matches('.').clone_into(&mut e.st.self_name);
        }
        if let Some((_, name)) = &learned {
            e.st.tailnet.clone_from(name);
        }
        if connected {
            e.st.login_wait = false;
            e.st.problem.clear();
        }
        e.st.machines = if connected { machines_of(&st) } else { Vec::new() };
        e.st.auth_url = if e.st.login_wait && !connected { st.auth_url.clone() } else { String::new() };
        let mut open = None;
        if e.st.login_wait && !st.auth_url.is_empty() && st.auth_url != e.open_url {
            e.open_url.clone_from(&st.auth_url);
            open = Some(st.auth_url.clone());
        }
        if prev.connected != connected {
            if connected {
                log::info!("[{id}] connected to {} as {}", e.st.tailnet, e.st.self_name);
            } else {
                log::info!("[{id}] not connected ({})", st.backend_state);
            }
        }
        let changed = prev.backend != e.st.backend
            || prev.connected != e.st.connected
            || prev.tailnet != e.st.tailnet
            || prev.self_name != e.st.self_name
            || prev.problem != e.st.problem
            || prev.login_wait != e.st.login_wait
            || prev.auth_url != e.st.auth_url
            || prev.machines != e.st.machines
            || prev.domains != e.st.domains;
        (changed, open)
    }

    // ---- Actions ----

    /// Creates a new tailnet slot and starts its login. Blocks while the node starts.
    pub fn add_tailnet(&self) -> Result<String, String> {
        let id = format!("t{}", hex(&rand::random::<[u8; 4]>()));
        log::info!("[{id}] adding a tailnet");
        let tc = TailnetConfig { id: id.clone(), enabled: true, ..Default::default() };
        {
            let mut g = lock(&self.inner);
            g.cfg.tailnets.push(tc.clone());
            g.cfg.save()?;
        }
        self.start_node(&tc)?;
        self.changed();
        self.login(&id);
        Ok(id)
    }

    /// Logs out of a tailnet, forgets its login and removes it.
    pub fn remove_tailnet(&self, id: &str) -> Result<(), String> {
        let node = lock(&self.inner).entries.get_mut(id).and_then(|e| e.node.take());
        if let Some(n) = node {
            let _ = n.logout();
            drop(n);
        }
        let res = {
            let mut g = lock(&self.inner);
            g.entries.remove(id);
            g.cfg.tailnets.retain(|t| t.id != id);
            let r = g.cfg.save();
            self.update_routing(&mut g);
            r
        };
        let _ = std::fs::remove_dir_all(config::node_dir(id));
        log::info!("[{id}] removed");
        self.changed();
        res
    }

    /// Starts a tailnet's login; the monitor opens the sign-in page when it's ready.
    pub fn login(&self, id: &str) {
        let node = {
            let mut g = lock(&self.inner);
            let Some(e) = g.entries.get_mut(id) else {
                return;
            };
            e.st.login_wait = true;
            e.open_url.clear();
            e.node.clone()
        };
        self.changed();
        let Some(node) = node else { return };
        let id = id.to_owned();
        std::thread::spawn(move || {
            log::info!("[{id}] starting login");
            match node.login_interactive() {
                Ok(()) => log::info!("[{id}] login started; waiting for the sign-in page address"),
                Err(e) => log::warn!("[{id}] starting login: {e}"),
            }
        });
    }

    pub fn logout(&self, id: &str) {
        let node = lock(&self.inner).entries.get(id).and_then(|e| e.node.clone());
        if let Some(n) = node {
            if let Err(e) = n.logout() {
                self.set_problem(format!("[{id}] logging out: {e}"));
            }
            log::info!("[{id}] logged out");
        }
        self.poll_all();
    }

    /// The master on/off switch.
    pub fn set_enabled(&self, on: bool) {
        {
            let mut g = lock(&self.inner);
            g.cfg.enabled = on;
            let _ = g.cfg.save();
            self.update_routing(&mut g);
        }
        self.changed();
    }

    /// Remembers that the "still running" notification has been shown.
    pub fn mark_background_hint_shown(&self) {
        let mut g = lock(&self.inner);
        if !g.cfg.background_hint_shown {
            g.cfg.background_hint_shown = true;
            let _ = g.cfg.save();
        }
    }

    /// Saves the UI language (already loaded with `i18n::set_language`) and
    /// redraws everything that shows text, including the tray menu.
    pub fn set_language(&self, code: &str) -> Result<(), String> {
        let res = {
            let mut g = lock(&self.inner);
            code.clone_into(&mut g.cfg.language);
            let r = g.cfg.save();
            // Rebuilds stored messages, such as a domain conflict, in the new language.
            self.update_routing(&mut g);
            r
        };
        self.changed();
        res
    }

    pub fn update_tailnet(&self, id: &str, name: &str, enabled: bool, extra: Vec<String>) -> Result<(), String> {
        let res = {
            let mut g = lock(&self.inner);
            let Some(tc) = g.cfg.tailnets.iter_mut().find(|t| t.id == id) else {
                return Err(format!("unknown tailnet {id}"));
            };
            name.trim().clone_into(&mut tc.name);
            tc.enabled = enabled;
            tc.extra_domains = extra;
            let r = g.cfg.save();
            self.update_routing(&mut g);
            r
        };
        self.changed();
        res
    }

    pub fn set_tailnet_enabled(&self, id: &str, on: bool) -> Result<(), String> {
        let tc = self.config().tailnets.into_iter().find(|t| t.id == id).ok_or("unknown tailnet")?;
        self.update_tailnet(id, &tc.name, on, tc.extra_domains)
    }

    /// Tries the system proxy setting again (after something else changed it).
    pub fn retry_system_proxy(&self) {
        {
            let mut g = lock(&self.inner);
            g.system = SystemProxyState::Idle;
            g.system_check_at = None;
            self.update_routing(&mut g);
        }
        self.changed();
    }

    /// Switches the system proxy mode ("on", "force", "off") and saves it.
    pub fn set_system_proxy_mode(&self, mode: &str) -> Result<(), String> {
        let res = {
            let mut g = lock(&self.inner);
            mode.clone_into(&mut g.cfg.system_proxy);
            let r = g.cfg.save();
            g.system = SystemProxyState::Idle;
            apply_system_proxy_mode(&mut g);
            self.update_routing(&mut g);
            r
        };
        self.changed();
        res
    }

    /// Saves port forwards and the system-proxy mode and applies them live.
    pub fn apply_global(self: &Arc<Self>, forwards: Vec<Forward>, sys_mode: &str) -> Result<(), String> {
        {
            let mut g = lock(&self.inner);
            g.cfg.forwards = forwards;
            sys_mode.clone_into(&mut g.cfg.system_proxy);
            g.cfg.validate()?;
            g.cfg.save()?;
            g.problem.clear();
            g.system = SystemProxyState::Idle;
            apply_system_proxy_mode(&mut g);
            self.update_routing(&mut g);
        }
        self.apply_forwards();
        self.changed();
        Ok(())
    }

    /// Adds a port forward to `target` (host:port) on a free local port, starts
    /// it, and returns that port. An existing forward to the same target is reused.
    pub fn add_forward(self: &Arc<Self>, target: &str) -> Result<u16, String> {
        let target = target.trim().to_owned();
        let mut fwds = self.config().forwards;
        if let Some(f) = fwds.iter().find(|f| f.target == target && f.local_port != 0) {
            return Ok(f.local_port);
        }
        fwds.push(Forward { local_port: 0, target: target.clone() });
        // Same checks as typing it into Settings.
        let fwds = config::parse_forwards(&config::forwards_text(&fwds))?;
        {
            let mut g = lock(&self.inner);
            g.cfg.forwards = fwds;
            g.cfg.save()?;
        }
        self.apply_forwards();
        self.changed();
        self.config()
            .forwards
            .iter()
            .find(|f| f.target == target)
            .map(|f| f.local_port)
            .filter(|p| *p != 0)
            .ok_or_else(|| tr!("no-free-port"))
    }

    /// Checks a name or address: which tailnet routes it, and whether a
    /// connection through that tailnet works. Blocks for up to 10 seconds.
    pub fn check(&self, input: &str) -> Result<String, String> {
        let (host, port) = parse_check_target(input)?;
        let Some(id) = self.node_for(&host) else {
            return Err(tr!("check-not-routed", host = host.as_str()));
        };
        let (label, target) = {
            let g = lock(&self.inner);
            let e = g.entries.get(&id).ok_or_else(|| tr!("check-gone"))?;
            (e.st.label(), e.node.as_ref().map(|n| n.socks()))
        };
        let target = target.ok_or_else(|| tr!("check-not-running", tailnet = label.as_str()))?;
        let started = Instant::now();
        let res = self.rt.block_on(async {
            tokio::time::timeout(Duration::from_secs(10), crate::socks::connect(&target, &host, port)).await
        });
        match res {
            Ok(Ok(_)) => Ok(tr!(
                "check-ok",
                address = format!("{host}:{port}"),
                tailnet = label,
                ms = u64::try_from(started.elapsed().as_millis()).unwrap_or(u64::MAX)
            )),
            Ok(Err(e)) => {
                Err(tr!("check-failed", host = host, tailnet = label, port = port.to_string(), error = e.to_string()))
            }
            Err(_) => Err(tr!("check-timeout", host = host, tailnet = label, port = port.to_string())),
        }
    }

    // ---- Port forwards ----

    /// Starts/stops forwards to match the settings. "auto" entries get a free
    /// port, which is saved so it stays the same.
    pub fn apply_forwards(self: &Arc<Self>) {
        let mut g = lock(&self.inner);
        let mut assigned = false;
        for f in &mut g.cfg.forwards {
            if f.local_port == 0
                && let Some(p) = free_port()
            {
                log::info!("Assigned local port {p} to {}", f.target);
                f.local_port = p;
                assigned = true;
            }
        }
        if assigned {
            let _ = g.cfg.save();
        }
        let want: HashMap<String, Forward> =
            g.cfg.forwards.iter().filter(|f| f.local_port != 0).map(|f| (f.to_string(), f.clone())).collect();
        g.forwards.retain(|k, h| {
            let keep = want.contains_key(k);
            if !keep {
                h.abort();
            }
            keep
        });
        let ports: Vec<u16> = want.values().map(|f| f.local_port).collect();
        g.forward_errors.retain(|p, _| ports.contains(p));
        let me = Arc::downgrade(self);
        for (key, f) in want {
            if g.forwards.contains_key(&key) {
                continue;
            }
            let addr = format!("127.0.0.1:{}", f.local_port);
            let ln = match StdListener::bind(&addr).and_then(|l| l.set_nonblocking(true).map(|()| l)) {
                Ok(l) => l,
                Err(e) => {
                    g.problem = format!("port forward {}: {e}", f.local_port);
                    g.forward_errors.insert(f.local_port, e.to_string());
                    continue;
                }
            };
            g.forward_errors.remove(&f.local_port);
            let _e = self.rt.enter();
            let Ok(ln) = tokio::net::TcpListener::from_std(ln) else {
                continue;
            };
            log::info!("Forwarding {addr} -> {}", f.target);
            let router: Arc<dyn Router> = Arc::new(CoreRouter(me.clone()));
            let h = self.rt.spawn(proxy::serve_forward(ln, f.target.clone(), router));
            g.forwards.insert(key, h.abort_handle());
        }
    }
}

/// Signs every saved tailnet out, for the uninstaller before it deletes the
/// logins: otherwise each tailnet keeps an abandoned machine with this
/// computer's name, and a later install's machine gets "-1" added to its name.
/// Each tailnet gets up to 30 seconds altogether.
pub fn logout_all() {
    let cfg = Config::load().unwrap_or_default();
    let jobs: Vec<_> = cfg
        .tailnets
        .iter()
        .filter(|tc| config::node_dir(&tc.id).is_dir())
        .map(|tc| {
            let (id, hostname) = (tc.id.clone(), cfg.hostname.clone());
            std::thread::spawn(move || match Node::start(&config::node_dir(&id), &hostname).and_then(|n| n.logout()) {
                Ok(()) => log::info!("[{id}] logged out"),
                Err(e) => log::warn!("[{id}] couldn't log out: {e}"),
            })
        })
        .collect();
    let deadline = Instant::now() + Duration::from_secs(30);
    for job in jobs {
        while !job.is_finished() && Instant::now() < deadline {
            std::thread::sleep(Duration::from_millis(200));
        }
    }
}

/// The routing tailnet whose domain matches host (longest match wins).
fn node_for_in(g: &Inner, host: &str) -> Option<String> {
    let host = host.trim_end_matches('.').to_lowercase();
    let mut best: Option<(&String, usize)> = None;
    for (id, e) in &g.entries {
        if !e.st.routing {
            continue;
        }
        for d in &e.st.domains {
            let matches = host == *d || host.ends_with(&format!(".{d}"));
            if matches && best.is_none_or(|(_, l)| d.len() > l) {
                best = Some((id, d.len()));
            }
        }
    }
    best.map(|(id, _)| id.clone())
}

/// "<https://name/path>", "name:port" or "name" -> (name, port). Without a port,
/// http:// means 80 and anything else 443.
pub fn parse_check_target(input: &str) -> Result<(String, u16), String> {
    let s = input.trim();
    let (default_port, rest) = if let Some(r) = s.strip_prefix("http://") {
        (80, r)
    } else if let Some(r) = s.strip_prefix("https://") {
        (443, r)
    } else {
        (443, s)
    };
    let hostport = rest.split(['/', '?', '#']).next().unwrap_or("");
    let hostport = hostport.rsplit('@').next().unwrap_or(hostport);
    let (host, port) = proxy::split_host_port(hostport, default_port);
    let host = host.trim_end_matches('.').to_lowercase();
    if host.is_empty() {
        return Err(tr!("check-empty"));
    }
    if port == 0 {
        return Err(tr!("check-bad-port", input = hostport));
    }
    Ok((host, port))
}

fn pac_url_of(g: &Inner) -> String {
    format!("http://{}/proxy.pac?v={}", g.cfg.listen, g.pac_ver)
}

fn apply_system_proxy_mode(g: &mut Inner) {
    g.system_check_at = None;
    if g.cfg.system_proxy == "off" {
        if let Some(s) = g.sys.take() {
            s.disable();
        }
        return;
    }
    let force = g.cfg.system_proxy == "force";
    if let Some(s) = g.sys.as_ref() {
        s.set_force(force);
        return;
    }
    match SystemProxy::new(&pac_url_of(g), force) {
        Ok(s) => {
            g.sys = Some(s);
            g.system_unavailable.clear();
        }
        Err(e) => {
            log::warn!("System proxy setting can't be managed here: {e}");
            g.system_unavailable = e;
        }
    }
}

/// Keeps the system proxy setting on exactly while something routes, and reads
/// it back every few seconds, so the status says whether browsers really use
/// the app rather than what we last wrote.
fn sync_system_proxy(g: &mut Inner) {
    let any = g.routing;
    let state = if g.cfg.system_proxy == "off" {
        if any { SystemProxyState::Manual } else { SystemProxyState::Idle }
    } else if let Some(s) = g.sys.as_ref() {
        if any {
            if g.system_check_at.is_some_and(|t| Instant::now() < t) {
                return; // not due yet; keep the last answer
            }
            g.system_check_at = Some(Instant::now() + SYSTEM_CHECK_EVERY);
            let res = if s.is_on() {
                s.verify()
            } else if g.system == SystemProxyState::Changed {
                // Something else changed it: wait for "Try again" rather than fight it.
                Err(ProxyError::Changed)
            } else {
                s.enable()
            };
            g.system_setting = s.current();
            match res {
                Ok(()) => SystemProxyState::Active,
                Err(e) => e.into(),
            }
        } else {
            s.pause();
            if g.system != SystemProxyState::Idle {
                g.system_setting = s.current();
            }
            SystemProxyState::Idle
        }
    } else if any {
        SystemProxyState::Failed(g.system_unavailable.clone())
    } else {
        SystemProxyState::Idle
    };
    if state != g.system {
        log::info!("System proxy setting: {state:?} (currently {:?})", g.system_setting);
        g.system = state;
    }
}

/// Saves a tailnet's detected domain (and its name as the default label).
fn learn_domain(g: &mut Inner, id: &str, domain: &str, tailnet_name: &str) {
    let Some(tc) = g.cfg.tailnets.iter_mut().find(|t| t.id == id) else {
        return;
    };
    let mut dirty = false;
    if tc.domain != domain {
        log::info!("[{id}] detected domain {domain}");
        domain.clone_into(&mut tc.domain);
        dirty = true;
    }
    if tc.name.is_empty() && !tailnet_name.is_empty() {
        tailnet_name.clone_into(&mut tc.name);
        dirty = true;
    }
    if dirty {
        let (name, domains) = (tc.name.clone(), tc.domains());
        if let Err(e) = g.cfg.save() {
            log::warn!("saving settings: {e}");
        }
        if let Some(e) = g.entries.get_mut(id) {
            e.st.name = name;
            e.st.domains = domains;
        }
    }
}

fn free_port() -> Option<u16> {
    StdListener::bind("127.0.0.1:0").ok()?.local_addr().ok().map(|a| a.port())
}

fn hex(b: &[u8]) -> String {
    b.iter().fold(String::with_capacity(b.len() * 2), |mut out, x| {
        let _ = write!(out, "{x:02x}");
        out
    })
}

#[cfg(test)]
pub(crate) mod tests {
    use super::*;

    pub fn test_dir() -> (std::sync::MutexGuard<'static, ()>, std::path::PathBuf) {
        let g = lock(&crate::TEST_LOCK);
        let d = std::env::temp_dir().join(format!("tp-core-{}", rand::random::<u64>()));
        std::fs::create_dir_all(&d).unwrap();
        // SAFETY: tests that read or change the environment hold TEST_LOCK.
        unsafe { std::env::set_var("TAILNET_LINK_CONFIG_DIR", &d) };
        (g, d)
    }

    /// Adds a tailnet as if logged in (no real node).
    pub fn fake(core: &Core, id: &str, domain: &str, connected: bool) {
        let tc = TailnetConfig {
            id: id.into(),
            name: id.into(),
            enabled: true,
            domain: domain.into(),
            ..Default::default()
        };
        let mut g = lock(&core.inner);
        g.cfg.tailnets.push(tc.clone());
        g.entries.insert(
            id.into(),
            Entry {
                node: None,
                st: TailnetStatus {
                    id: id.into(),
                    name: id.into(),
                    backend: if connected { "Running".into() } else { "NeedsLogin".into() },
                    connected,
                    domains: tc.domains(),
                    ..Default::default()
                },
                open_url: String::new(),
                shields: false,
            },
        );
    }

    pub fn route(core: &Core) {
        let mut g = lock(&core.inner);
        core.update_routing(&mut g);
    }

    #[test]
    fn routing_by_name() {
        let (_g, _d) = test_dir();
        // No system proxy here; "off" keeps that out of the summary.
        let core = Core::new(Config { system_proxy: "off".into(), ..Config::default() });
        fake(&core, "a", "example.ts.net", true);
        fake(&core, "b", "other-net.ts.net", true);
        fake(&core, "c", "offline.ts.net", false);
        lock(&core.inner).cfg.tailnets[1].extra_domains = vec!["corp.example.com".into()];
        route(&core);
        for (host, want) in [
            ("wiki.example.ts.net", Some("a")),
            ("WIKI.Example.ts.net.", Some("a")),
            ("db.other-net.ts.net", Some("b")),
            ("wiki.corp.example.com", Some("b")),
            ("x.offline.ts.net", None),
            ("example.com", None),
        ] {
            assert_eq!(core.node_for(host).as_deref(), want, "{host}");
        }
        let pac = String::from_utf8(lock(&core.inner).pac.clone()).unwrap();
        assert!(pac.contains(".example.ts.net") && pac.contains(".corp.example.com"));
        assert!(!pac.contains("offline.ts.net"));
        assert!(core.status().routing);
        assert_eq!(core.status().summary(), "Routing via 2 of 3 tailnets");
    }

    #[test]
    fn pausing_stops_routing() {
        let (_g, _d) = test_dir();
        let core = Core::new(Config::default());
        fake(&core, "a", "example.ts.net", true);
        route(&core);
        let v1 = lock(&core.inner).pac_ver;
        lock(&core.inner).cfg.tailnets[0].enabled = false;
        route(&core);
        assert!(core.node_for("x.example.ts.net").is_none());
        assert_ne!(lock(&core.inner).pac_ver, v1, "PAC version bumps when domains change");
        lock(&core.inner).cfg.tailnets[0].enabled = true;
        core.set_enabled(false);
        assert!(!core.status().routing, "master switch");
    }

    #[test]
    fn duplicate_domain_first_wins() {
        let (_g, _d) = test_dir();
        let core = Core::new(Config::default());
        fake(&core, "a", "shared.ts.net", true);
        fake(&core, "b", "shared.ts.net", true);
        route(&core);
        assert!(core.node_for("x.shared.ts.net").is_some());
        assert_ne!(core.status().tailnets[1].problem, "");
    }

    #[test]
    fn learned_domain_is_saved() {
        let (_g, _d) = test_dir();
        let core = Core::new(Config::default());
        fake(&core, "a", "", true);
        lock(&core.inner).cfg.tailnets[0].name.clear();
        learn_domain(&mut lock(&core.inner), "a", "example.ts.net", "Main Company");
        let saved = Config::load().unwrap();
        assert_eq!(saved.tailnets[0].domain, "example.ts.net");
        assert_eq!(saved.tailnets[0].name, "Main Company");
    }

    #[test]
    fn check_targets_parse() {
        for (input, want) in [
            ("https://Wiki.x.ts.net/path?q=1", ("wiki.x.ts.net", 443)),
            ("http://wiki.x.ts.net", ("wiki.x.ts.net", 80)),
            ("db.x.ts.net:5432", ("db.x.ts.net", 5432)),
            ("  pc.x.ts.net.  ", ("pc.x.ts.net", 443)),
            ("http://user@pc.x.ts.net:8080/", ("pc.x.ts.net", 8080)),
        ] {
            assert_eq!(parse_check_target(input).unwrap(), (want.0.to_owned(), want.1), "{input}");
        }
        assert!(parse_check_target("").is_err());
        assert!(parse_check_target("https:///x").is_err());
    }

    #[test]
    fn check_reports_unrouted_names() {
        let (_g, _d) = test_dir();
        let core = Core::new(Config::default());
        fake(&core, "a", "example.ts.net", true);
        route(&core);
        let e = core.check("https://example.com/").unwrap_err();
        assert!(e.contains("isn't routed"), "{e}");
        // Routed, but this fake tailnet has no node.
        let e = core.check("pc.example.ts.net").unwrap_err();
        assert!(e.contains("isn't running"), "{e}");
    }

    #[test]
    fn machines_from_status() {
        let st: crate::tsnet::Status = serde_json::from_str(
            r#"{"BackendState":"Running","Peer":{
                "k1":{"DNSName":"zeta.x.ts.net.","OS":"linux","Online":true,"TailscaleIPs":["fd7a::1","100.1.2.3"]},
                "k2":{"DNSName":"Alpha.x.ts.net.","OS":"windows","Online":false,"TailscaleIPs":null},
                "k3":{"DNSName":"","OS":"","Online":true},
                "k4":{"DNSName":"beta.x.ts.net.","OS":"macOS","Online":true}}}"#,
        )
        .unwrap();
        let m = machines_of(&st);
        let names: Vec<&str> = m.iter().map(|m| m.name.as_str()).collect();
        assert_eq!(names, ["beta", "zeta", "alpha"], "online first, then by name");
        assert_eq!(m[1].ip, "100.1.2.3", "IPv4 preferred");
        assert_eq!(m[2].dns_name, "alpha.x.ts.net");
        assert!(m[1].matches("ZETA") && m[1].matches("linux") && m[1].matches("100.1"));
        assert!(!m[1].matches("windows"));
        let none: crate::tsnet::Status = serde_json::from_str(r#"{"BackendState":"NeedsLogin","Peer":null}"#).unwrap();
        let machines = machines_of(&none);
        assert!(machines.is_empty(), "{machines:?}");
    }

    #[test]
    fn add_forward_assigns_and_reuses_a_port() {
        let (_g, _d) = test_dir();
        let core = Core::new(Config::default());
        let p = core.add_forward("pc.example.ts.net:3389").unwrap();
        assert_ne!(p, 0);
        assert_eq!(core.add_forward("pc.example.ts.net:3389").unwrap(), p);
        assert_eq!(core.config().forwards.len(), 1);
        assert!(core.add_forward("no-port-here").is_err());
        let st = core.status();
        assert_eq!(st.forwards.len(), 1);
        assert_eq!(st.forwards[0].local_port, p);
        assert_eq!(st.forwards[0].error, "");
        assert!(st.forwards[0].via.is_empty(), "no tailnet routes it yet");
        core.shutdown();
    }

    #[test]
    fn auto_port_forward_is_saved() {
        let (_g, _d) = test_dir();
        let cfg = Config {
            forwards: vec![Forward { local_port: 0, target: "pc.example.ts.net:3389".into() }],
            ..Config::default()
        };
        let core = Core::new(cfg);
        core.apply_forwards();
        let p = core.config().forwards[0].local_port;
        assert_ne!(p, 0);
        assert_eq!(Config::load().unwrap().forwards[0].local_port, p);
        core.shutdown();
    }
}
