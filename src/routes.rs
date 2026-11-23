//! Addresses and subnets a tailnet reaches, besides its domain: its machines'
//! Tailscale addresses, the subnets its routers share (for example a cloud network),
//! and machines shared into it from other tailnets, which keep their home
//! tailnet's name.

use std::collections::BTreeSet;
use std::fmt;
use std::net::IpAddr;

/// An address range such as 192.168.0.0/16.
#[derive(Clone, Copy, Debug, PartialEq, Eq, PartialOrd, Ord, Hash)]
pub struct Prefix {
    pub addr: IpAddr,
    pub len: u8,
}

impl Prefix {
    /// `192.168.0.0/16` or `fd7a::/48`. The address is masked to the length.
    pub fn parse(s: &str) -> Option<Prefix> {
        let (a, l) = s.trim().split_once('/')?;
        let addr: IpAddr = a.parse().ok()?;
        let len: u8 = l.parse().ok()?;
        if len > max_len(addr) {
            return None;
        }
        Some(Prefix { addr: mask(addr, len), len })
    }

    pub fn contains(&self, ip: IpAddr) -> bool {
        ip.is_ipv4() == self.addr.is_ipv4() && mask(ip, self.len) == self.addr
    }

    /// `0.0.0.0/0` or `::/0`: an exit node, which would take every address.
    pub fn is_default(&self) -> bool {
        self.len == 0
    }

    /// The dotted mask for the PAC's `isInNet`, e.g. 255.255.0.0 (`IPv4` only).
    pub fn v4_mask(&self) -> Option<String> {
        if !self.addr.is_ipv4() {
            return None;
        }
        let m = if self.len == 0 { 0 } else { u32::MAX << (32 - u32::from(self.len)) };
        Some(std::net::Ipv4Addr::from(m).to_string())
    }
}

impl fmt::Display for Prefix {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        write!(f, "{}/{}", self.addr, self.len)
    }
}

fn max_len(ip: IpAddr) -> u8 {
    if ip.is_ipv4() { 32 } else { 128 }
}

fn mask(ip: IpAddr, len: u8) -> IpAddr {
    match ip {
        IpAddr::V4(a) => {
            let m = if len == 0 { 0 } else { u32::MAX << (32 - u32::from(len.min(32))) };
            IpAddr::V4((u32::from(a) & m).into())
        }
        IpAddr::V6(a) => {
            let m = if len == 0 { 0 } else { u128::MAX << (128 - u32::from(len.min(128))) };
            IpAddr::V6((u128::from(a) & m).into())
        }
    }
}

/// A host as typed or sent by a browser, ready to compare: no brackets around
/// an `IPv6` address, no trailing dot, lower case.
pub fn normalize(host: &str) -> String {
    host.trim().trim_start_matches('[').trim_end_matches(']').trim_end_matches('.').to_lowercase()
}

/// What one tailnet reaches, read from its status.
#[derive(Clone, Debug, Default, PartialEq, Eq)]
pub struct Reach {
    /// Every machine's full MagicDNS name, including machines shared in from
    /// other tailnets (whose names end in that tailnet's domain).
    pub hosts: BTreeSet<String>,
    /// Every machine's Tailscale addresses.
    pub addrs: BTreeSet<IpAddr>,
    /// The subnets its routers share (never an exit node's 0.0.0.0/0).
    pub subnets: BTreeSet<Prefix>,
}

impl Reach {
    pub fn of(st: &crate::tsnet::Status) -> Reach {
        let mut r = Reach::default();
        for p in st.peers.iter().flat_map(|m| m.values()) {
            let name = normalize(&p.dns_name);
            if !name.is_empty() {
                r.hosts.insert(name);
            }
            r.addrs.extend(p.ips.iter().flatten().filter_map(|i| i.parse::<IpAddr>().ok()));
            for s in p.primary_routes.iter().flatten() {
                match Prefix::parse(s) {
                    Some(p) if !p.is_default() => {
                        r.subnets.insert(p);
                    }
                    _ => {}
                }
            }
        }
        r
    }

    /// How specifically this tailnet claims `ip`: a machine's own address beats
    /// any subnet, and a longer subnet beats a shorter one. `None`: not at all.
    pub fn claim(&self, ip: IpAddr, with_subnets: bool) -> Option<u16> {
        if self.addrs.contains(&ip) {
            return Some(u16::from(max_len(ip)) + 1);
        }
        if !with_subnets {
            return None;
        }
        self.subnets.iter().filter(|p| p.contains(ip)).map(|p| u16::from(p.len)).max()
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn prefixes() {
        let p = Prefix::parse("192.168.5.6/16").unwrap();
        assert_eq!(p.to_string(), "192.168.0.0/16");
        assert_eq!(p.v4_mask().as_deref(), Some("255.255.0.0"));
        assert!(p.contains("192.168.20.15".parse().unwrap()));
        assert!(!p.contains("192.169.20.15".parse().unwrap()));
        assert!(!p.contains("::1".parse().unwrap()));
        assert!(Prefix::parse("0.0.0.0/0").unwrap().is_default());
        assert!(Prefix::parse("10.0.0.0/33").is_none());
        assert!(Prefix::parse("nonsense").is_none());
        let v6 = Prefix::parse("fd7a:115c:a1e0::/48").unwrap();
        assert!(v6.contains("fd7a:115c:a1e0::1234".parse().unwrap()));
        assert!(v6.v4_mask().is_none());
    }

    #[test]
    fn reach_from_status() {
        let st: crate::tsnet::Status = serde_json::from_str(
            r#"{"BackendState":"Running","Peer":{
                "a":{"DNSName":"router.x.ts.net.","TailscaleIPs":["100.1.2.3","fd7a::3"],
                     "PrimaryRoutes":["192.168.0.0/16","0.0.0.0/0","::/0"]},
                "b":{"DNSName":"Shared.Other.ts.net.","TailscaleIPs":["100.9.9.9"],"PrimaryRoutes":null},
                "c":{"DNSName":"","TailscaleIPs":null}}}"#,
        )
        .unwrap();
        let r = Reach::of(&st);
        assert_eq!(r.hosts.iter().map(String::as_str).collect::<Vec<_>>(), ["router.x.ts.net", "shared.other.ts.net"]);
        assert_eq!(r.subnets.iter().map(ToString::to_string).collect::<Vec<_>>(), ["192.168.0.0/16"]);
        assert_eq!(r.claim("100.9.9.9".parse().unwrap(), true), Some(33));
        assert_eq!(r.claim("192.168.20.15".parse().unwrap(), true), Some(16));
        assert_eq!(r.claim("192.168.20.15".parse().unwrap(), false), None);
        assert_eq!(r.claim("8.8.8.8".parse().unwrap(), true), None);
    }

    #[test]
    fn hosts_normalize() {
        assert_eq!(normalize("[FD7A::1]"), "fd7a::1");
        assert_eq!(normalize("Build.X.ts.net."), "build.x.ts.net");
    }
}
