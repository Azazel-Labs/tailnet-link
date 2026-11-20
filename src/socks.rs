//! Minimal SOCKS5 client (username/password auth, CONNECT by host name), used
//! to open connections through a libtailscale node. Names are resolved by the
//! node itself, so MagicDNS names work.

use std::io;
use std::net::IpAddr;
use tokio::io::{AsyncReadExt, AsyncWriteExt};
use tokio::net::TcpStream;

use crate::tsnet::SocksTarget;

fn err(msg: impl Into<String>) -> io::Error {
    io::Error::other(msg.into())
}

pub async fn connect(proxy: &SocksTarget, host: &str, port: u16) -> io::Result<TcpStream> {
    let mut s = TcpStream::connect(&proxy.addr).await?;
    s.set_nodelay(true)?;

    // Greeting: version 5, one method: username/password (2).
    s.write_all(&[5, 1, 2]).await?;
    let mut buf = [0u8; 2];
    s.read_exact(&mut buf).await?;
    if buf != [5, 2] {
        return Err(err("SOCKS5: proxy refused username/password auth"));
    }

    // Username/password (RFC 1929).
    let (u, p) = (proxy.user.as_bytes(), proxy.pass.as_bytes());
    if u.len() > 255 || p.len() > 255 {
        return Err(err("SOCKS5: credentials too long"));
    }
    let mut auth = vec![1, u.len() as u8];
    auth.extend_from_slice(u);
    auth.push(p.len() as u8);
    auth.extend_from_slice(p);
    s.write_all(&auth).await?;
    s.read_exact(&mut buf).await?;
    if buf[1] != 0 {
        return Err(err("SOCKS5: authentication failed"));
    }

    // CONNECT.
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
            if host.len() > 255 {
                return Err(err("SOCKS5: host name too long"));
            }
            req.push(3);
            req.push(host.len() as u8);
            req.extend_from_slice(host.as_bytes());
        }
    }
    req.extend_from_slice(&port.to_be_bytes());
    s.write_all(&req).await?;

    let mut head = [0u8; 4];
    s.read_exact(&mut head).await?;
    if head[1] != 0 {
        return Err(err(match head[1] {
            2 => "connection not allowed by that tailnet's access rules".to_owned(),
            3 => "network unreachable".into(),
            4 => format!("{host} is unreachable (is it online in that tailnet?)"),
            5 => format!("{host} refused the connection on port {port}"),
            n => format!("SOCKS5 error {n}"),
        }));
    }
    // Skip the bound address.
    let skip = match head[3] {
        1 => 4,
        4 => 16,
        3 => {
            let mut l = [0u8; 1];
            s.read_exact(&mut l).await?;
            l[0] as usize
        }
        _ => return Err(err("SOCKS5: bad reply")),
    };
    let mut rest = vec![0u8; skip + 2];
    s.read_exact(&mut rest).await?;
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
}
