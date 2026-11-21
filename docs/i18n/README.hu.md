# Tailnet Link

[![CI](https://github.com/Azazel-Labs/tailnet-link/actions/workflows/ci.yml/badge.svg)](https://github.com/Azazel-Labs/tailnet-link/actions/workflows/ci.yml)
[![Release](https://img.shields.io/github/v/release/Azazel-Labs/tailnet-link)](https://github.com/Azazel-Labs/tailnet-link/releases)
[![License: MIT-0](https://img.shields.io/badge/license-MIT--0-blue.svg)](../../LICENSE)
[![Rust: 1.95+](https://img.shields.io/badge/rust-1.95%2B-orange.svg)](../../Cargo.toml)
[![Edition: 2024](https://img.shields.io/badge/edition-2024-orange.svg)](../../Cargo.toml)
[![Platforms](https://img.shields.io/badge/platforms-Windows%20%7C%20macOS%20%7C%20Linux-lightgrey.svg)](../../README.md#download)

[English](../../README.md) · [Afrikaans](README.af.md) · [Català](README.ca.md) · [Čeština](README.cs.md) · [Dansk](README.da.md) · [Deutsch](README.de.md) · [Ελληνικά](README.el.md) · [Español (Latinoamérica)](README.es-419.md) · [Español (España)](README.es-ES.md) · [Suomi](README.fi.md) · [Français](README.fr.md) · Magyar · [Bahasa Indonesia](README.id.md) · [Italiano](README.it.md) · [日本語](README.ja.md) · [한국어](README.ko.md) · [Norsk bokmål](README.nb.md) · [Nederlands](README.nl.md) · [Polski](README.pl.md) · [Português (Brasil)](README.pt-BR.md) · [Português (Portugal)](README.pt-PT.md) · [Română](README.ro.md) · [Русский](README.ru.md) · [Српски](README.sr-Cyrl.md) · [Svenska](README.sv.md) · [ไทย](README.th.md) · [Türkçe](README.tr.md) · [Українська](README.uk.md) · [Tiếng Việt](README.vi.md) · [简体中文](README.zh-Hans.md) · [繁體中文](README.zh-Hant.md)

![Tailnet Link](../images/hero.svg)

**Maradjon a saját tailnetjén. Érje el az összes többi tailnet gépeit – egyszerre.**

A Tailscale-lel egyszerre csak egy tailnetbe lehet bejelentkezni. Ha az otthoni labornak, a cégnek és egy ügyfélnek is saját tailnetje van, folyton fiókot kell váltania, és ami éppen kapcsolódva volt, megszakad. A Tailnet Link véget vet ennek. A Tailscale alkalmazás pontosan ott marad, ahol van, a Tailnet Link pedig csendben mellé teszi a többi tailnetet, így a `https://wiki.studio.example/` és a `build-pc.home.example` is egyszerűen megnyílik.

**[Töltse le a legújabb kiadást](https://github.com/Azazel-Labs/tailnet-link/releases/latest)** Windowsra, macOS-re vagy Linuxra. Ingyenes és nyílt forráskódú.

![A Tailnetek lap két útválasztó tailnettel és a gépeik listájával](../images/tailnets.png)

*A képernyőképeken kitalált tailnetek szerepelnek; minden név és cím fiktív.*

## Miért a Tailnet Link?

- **Nincs több fiókváltás.** Adjon hozzá annyi tailnetet, amennyire szüksége van, és használja mindet egyszerre. A saját tailnetje soha nem bontja a kapcsolatot.
- **Nincs mit beállítani.** Jelentkezzen be, és a program magától megtalálja a tailnet tartományát. A gépeket név szerint nyithatja meg bármely böngészőben.
- **Nem akad össze a Tailscale-lel.** Nincs VPN-adapter, nincsenek útvonalak, nincs DNS-módosítás. Minden további tailnet külön csomópontként fut az alkalmazáson belül, így semmi sem ütközik sem a Tailscale alkalmazással, sem egymással.
- **Alapból zárt.** Minden további csomópont „shields up” módban csatlakozik: Ön eléri azokat a tailneteket, de onnan semmi sem érheti el az Ön számítógépét.
- **Csak az ő forgalmuk megy rajta át.** A többi tailnet címei a Tailnet Linken keresztül mennek, minden más közvetlenül, pontosan úgy, mint eddig.
- **A proxyt figyelmen kívül hagyó alkalmazásokkal is működik.** A Távoli asztal, az SSH és az adatbázis-kliensek egyetlen kattintással helyi portot kapnak, amely a géphez vezet.
- **Rendet rak maga után.** A rendszer proxybeállítása csak addig aktív, amíg útválasztás folyik, és kilépéskor, szüneteltetéskor, összeomláskor vagy áramszünet után visszaáll.
- **Beszéli az Ön nyelvét.** A felület 31 nyelven érhető el.

## Hogyan működik?

1. **Adjon hozzá egy tailnetet.** A Tailscale saját bejelentkezési oldala nyílik meg a böngészőben, ugyanúgy, mint a Tailscale alkalmazásnál.
2. **A tartományt a program automatikusan felismeri.** Bejelentkezés után a Tailnet Link kiolvassa a tailnet MagicDNS-nevét (például `example.ts.net`), és a `*.example.ts.net` címeket rajta keresztül irányítja.
3. **Nyissa meg a gépeit.** Írjon be egy nevet a böngészőbe, vagy válasszon gépet a listából: megnyithatja, kimásolhatja a címét, vagy portot továbbíthat hozzá.

## Proxyt figyelmen kívül hagyó alkalmazások

A böngészők és a legtöbb eszköz követi a rendszer proxybeállítását, a Távoli asztal, az adatbázis-kliensek és a hasonló alkalmazások viszont nem. Ezekhez kattintson a gép melletti csatlakozó gombra, és válasszon portot: a program kiválaszt és megjegyez egy szabad helyi portot, Ön pedig a `127.0.0.1:<port>` címre csatlakozik. Windowson a Távoli asztal továbbításaihoz saját **Távoli asztal megnyitása** gomb is tartozik.

![A Távoli asztal továbbítása utáni párbeszédablak: másolható helyi cím és a Távoli asztalt megnyitó gomb](../images/forward.png)

## Letöltés és platformok

A Tailnet Link Windowson, macOS-en és Linuxon (GNOME és KDE) fut. A [legújabb kiadásban](https://github.com/Azazel-Labs/tailnet-link/releases/latest) megtalálja a `tailnet-link-windows-setup.exe` Windows-telepítőt, a `tailnet-link-macos-universal.dmg` fájlt Macre (Apple Silicon és Intel), valamint a `tailnet-link-linux-amd64.deb` csomagot Ubuntura és Debianra (`sudo apt install ./tailnet-link-linux-amd64.deb`).

**Nincs kóddal aláírva.** Windowson a SmartScreen figyelmeztetésénél válassza a **További információ → Futtatás mindenképp** lehetőséget. macOS-en az első indításkor kattintson jobb gombbal az alkalmazásra, és válassza a **Megnyitás** parancsot.

## További információ

A részletes leírás (Beállítások, tálcamenü, a proxybeállítás visszaállítása, a Windows-telepítő, a fájlok helye) az [angol README-ben](../../README.md) található. Ha javítaná a fordítást, olvassa el a [docs/translations.md](../../docs/translations.md) útmutatót.

Copyright © 2026 Azazel Labs LLC. [MIT-0](../../LICENSE) licenc alatt. A Tailnet Linket nem a Tailscale Inc. készítette, és nem is áll kapcsolatban vele. A Tailscale a Tailscale Inc. védjegye.
