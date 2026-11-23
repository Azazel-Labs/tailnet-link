//! Minimal SOCKS5 client (username/password auth, CONNECT by host name), used
//! to open connections through a libtailscale node. Names are resolved by the
//! node itself, so MagicDNS names work.

use std::io;
use std::net::{IpAddr, ToSocketAddrs as _};
use std::time::{Duration, Instant};
use tokio::io::{AsyncReadExt, AsyncWriteExt};
use tokio::net::TcpStream;

use crate::tsnet::SocksTarget;

fn err(msg: impl Into<String>) -> io::Error {
    io::Error::other(msg.into())
}

/// Greeting: version 5, one method: username/password (2).
const GREETING: [u8; 3] = [5, 1, 2];

/// Username/password (RFC 1929).
fn auth_request(proxy: &SocksTarget) -> io::Result<Vec<u8>> {
    let (u, p) = (proxy.user.as_bytes(), proxy.pass.as_bytes());
    let (Ok(ul), Ok(pl)) = (u8::try_from(u.len()), u8::try_from(p.len())) else {
        return Err(err("SOCKS5: credentials too long"));
    };
    let mut auth = vec![1, ul];
    auth.extend_from_slice(u);
    auth.push(pl);
    auth.extend_from_slice(p);
    Ok(auth)
}

fn connect_request(host: &str, port: u16) -> io::Result<Vec<u8>> {
    let mut req = vec![5, 1, 0];
    match host.trim_matches(|c| c == '[' || c == ']').parse::<IpAddr>() {
        Ok(IpAddr::V4(ip)) => {
            req.push(1);
            req.extend_from_slice(&ip.octets());
        }
        Ok(IpAddr::V6(ip)) => {
            req.push(4);
            req.extend_from_slice(&ip.octets());
        }
        Err(_) => {
            let Ok(len) = u8::try_from(host.len()) else { return Err(err("SOCKS5: host name too long")) };
            req.push(3);
            req.push(len);
            req.extend_from_slice(host.as_bytes());
        }
    }
    req.extend_from_slice(&port.to_be_bytes());
    Ok(req)
}

/// The error for a CONNECT reply's status byte (not 0), with a matching kind.
fn reply_error(code: u8, host: &str, port: u16) -> io::Error {
    use io::ErrorKind as K;
    let (kind, msg) = match code {
        2 => (K::PermissionDenied, "connection not allowed by that tailnet's access rules".to_owned()),
        3 => (K::NetworkUnreachable, "network unreachable".into()),
        4 => (K::HostUnreachable, format!("{host} is unreachable (is it online in that tailnet?)")),
        5 => (K::ConnectionRefused, format!("{host} refused the connection on port {port}")),
        n => (K::Other, format!("SOCKS5 error {n}")),
    };
    io::Error::new(kind, msg)
}

/// How many bytes of bound address follow a reply's head, for address types 1 and 4.
/// `None` means a name (type 3), whose length byte comes first.
fn bound_len(kind: u8) -> io::Result<Option<usize>> {
    match kind {
        1 => Ok(Some(4)),
        4 => Ok(Some(16)),
        3 => Ok(None),
        _ => Err(err("SOCKS5: bad reply")),
    }
}

pub async fn connect(proxy: &SocksTarget, host: &str, port: u16) -> io::Result<TcpStream> {
    let mut s = TcpStream::connect(&proxy.addr).await?;
    s.set_nodelay(true)?;

    s.write_all(&GREETING).await?;
    let mut buf = [0u8; 2];
    s.read_exact(&mut buf).await?;
    if buf != [5, 2] {
        return Err(err("SOCKS5: proxy refused username/password auth"));
    }
    s.write_all(&auth_request(proxy)?).await?;
    s.read_exact(&mut buf).await?;
    if buf[1] != 0 {
        return Err(err("SOCKS5: authentication failed"));
    }

    s.write_all(&connect_request(host, port)?).await?;
    let mut head = [0u8; 4];
    s.read_exact(&mut head).await?;
    if head[1] != 0 {
        return Err(reply_error(head[1], host, port));
    }
    let skip = if let Some(n) = bound_len(head[3])? {
        n
    } else {
        let mut l = [0u8; 1];
        s.read_exact(&mut l).await?;
        l[0] as usize
    };
    let mut rest = vec![0u8; skip + 2];
    s.read_exact(&mut rest).await?;
    Ok(s)
}

/// [`connect`] without the async runtime, for threads that mustn't depend on it.
/// The whole exchange must finish within `timeout`, or it fails with `TimedOut`.
pub fn connect_blocking(
    proxy: &SocksTarget,
    host: &str,
    port: u16,
    timeout: Duration,
) -> io::Result<std::net::TcpStream> {
    use std::io::{Read as _, Write as _};

    let deadline = Instant::now() + timeout;
    let left = || {
        deadline
            .checked_duration_since(Instant::now())
            .filter(|d| !d.is_zero())
            .ok_or_else(|| io::Error::from(io::ErrorKind::TimedOut))
    };
    let addr = proxy.addr.to_socket_addrs()?.next().ok_or_else(|| err("SOCKS5: bad proxy address"))?;
    let mut s = std::net::TcpStream::connect_timeout(&addr, left()?)?;
    s.set_nodelay(true)?;
    // Every read and write gets what's left of the deadline. A socket timeout shows
    // up as WouldBlock on some systems, so call it what it is.
    let read = |s: &mut std::net::TcpStream, buf: &mut [u8]| -> io::Result<()> {
        s.set_read_timeout(Some(left()?))?;
        s.read_exact(buf)
            .map_err(|e| if e.kind() == io::ErrorKind::WouldBlock { io::ErrorKind::TimedOut.into() } else { e })
    };
    let write = |s: &mut std::net::TcpStream, buf: &[u8]| -> io::Result<()> {
        s.set_write_timeout(Some(left()?))?;
        s.write_all(buf)
            .map_err(|e| if e.kind() == io::ErrorKind::WouldBlock { io::ErrorKind::TimedOut.into() } else { e })
    };

    write(&mut s, &GREETING)?;
    let mut buf = [0u8; 2];
    read(&mut s, &mut buf)?;
    if buf != [5, 2] {
        return Err(err("SOCKS5: proxy refused username/password auth"));
    }
    write(&mut s, &auth_request(proxy)?)?;
    read(&mut s, &mut buf)?;
    if buf[1] != 0 {
        return Err(err("SOCKS5: authentication failed"));
    }

    write(&mut s, &connect_request(host, port)?)?;
    let mut head = [0u8; 4];
    read(&mut s, &mut head)?;
    if head[1] != 0 {
        return Err(reply_error(head[1], host, port));
    }
    let skip = if let Some(n) = bound_len(head[3])? {
        n
    } else {
        let mut l = [0u8; 1];
        read(&mut s, &mut l)?;
        l[0] as usize
    };
    let mut rest = vec![0u8; skip + 2];
    read(&mut s, &mut rest)?;
    s.set_read_timeout(None)?;
    s.set_write_timeout(None)?;
    Ok(s)
}

#[cfg(test)]
mod tests {
    use super::*;
    use tokio::net::TcpListener;

    /// A tiny SOCKS5 server that checks the credentials and the requested name.
    async fn fake_socks(expect_host: &'static str, expect_port: u16) -> (String, tokio::task::JoinHandle<()>) {
        let ln = TcpListener::bind("127.0.0.1:0").await.unwrap();
        let addr = ln.local_addr().unwrap().to_string();
        let h = tokio::spawn(async move {
            let (mut conn, _) = ln.accept().await.unwrap();
            let mut greeting = [0u8; 3];
            conn.read_exact(&mut greeting).await.unwrap();
            assert_eq!(greeting, [5, 1, 2]);
            conn.write_all(&[5, 2]).await.unwrap();
            let mut auth = [0u8; 2];
            conn.read_exact(&mut auth).await.unwrap();
            let mut user = vec![0u8; auth[1] as usize];
            conn.read_exact(&mut user).await.unwrap();
            let mut pl = [0u8; 1];
            conn.read_exact(&mut pl).await.unwrap();
            let mut pass = vec![0u8; pl[0] as usize];
            conn.read_exact(&mut pass).await.unwrap();
            assert_eq!(user, b"tsnet");
            assert_eq!(pass, b"secret");
            conn.write_all(&[1, 0]).await.unwrap();
            let mut req = [0u8; 5];
            conn.read_exact(&mut req).await.unwrap();
            assert_eq!(&req[..4], &[5, 1, 0, 3]);
            let mut name = vec![0u8; req[4] as usize];
            conn.read_exact(&mut name).await.unwrap();
            assert_eq!(name, expect_host.as_bytes());
            let mut port = [0u8; 2];
            conn.read_exact(&mut port).await.unwrap();
            assert_eq!(u16::from_be_bytes(port), expect_port);
            conn.write_all(&[5, 0, 0, 1, 127, 0, 0, 1, 0, 0]).await.unwrap();
            conn.write_all(b"hello").await.unwrap();
        });
        (addr, h)
    }

    #[tokio::test]
    async fn connects_by_name_with_auth() {
        let (addr, h) = fake_socks("wiki.example.ts.net", 443).await;
        let t = SocksTarget { addr, user: "tsnet".into(), pass: "secret".into() };
        let mut s = connect(&t, "wiki.example.ts.net", 443).await.unwrap();
        let mut got = [0u8; 5];
        s.read_exact(&mut got).await.unwrap();
        assert_eq!(&got, b"hello");
        h.await.unwrap();
    }

    #[tokio::test(flavor = "multi_thread")]
    async fn connects_without_the_runtime() {
        let (addr, h) = fake_socks("wiki.example.ts.net", 443).await;
        let t = SocksTarget { addr, user: "tsnet".into(), pass: "secret".into() };
        let got = tokio::task::spawn_blocking(move || {
            use std::io::Read as _;
            let mut s = connect_blocking(&t, "wiki.example.ts.net", 443, Duration::from_secs(5)).unwrap();
            let mut got = [0u8; 5];
            s.read_exact(&mut got).unwrap();
            got
        })
        .await
        .unwrap();
        assert_eq!(&got, b"hello");
        h.await.unwrap();
    }

    #[test]
    fn a_silent_proxy_times_out() {
        // Accepts the connection, then never says a word.
        let ln = std::net::TcpListener::bind("127.0.0.1:0").unwrap();
        let t = SocksTarget { addr: ln.local_addr().unwrap().to_string(), user: "tsnet".into(), pass: "x".into() };
        let started = Instant::now();
        let e = connect_blocking(&t, "wiki.example.ts.net", 443, Duration::from_millis(300)).unwrap_err();
        assert_eq!(e.kind(), io::ErrorKind::TimedOut);
        assert!(started.elapsed() < Duration::from_secs(3));
        drop(ln);
    }
}
