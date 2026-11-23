# Tailnet Link

[![CI](https://github.com/Azazel-Labs/tailnet-link/actions/workflows/ci.yml/badge.svg)](https://github.com/Azazel-Labs/tailnet-link/actions/workflows/ci.yml)
[![Release](https://img.shields.io/github/v/release/Azazel-Labs/tailnet-link)](https://github.com/Azazel-Labs/tailnet-link/releases)
[![License: MIT-0](https://img.shields.io/badge/license-MIT--0-blue.svg)](../../LICENSE)
[![Rust: 1.95+](https://img.shields.io/badge/rust-1.95%2B-orange.svg)](../../Cargo.toml)
[![Edition: 2024](https://img.shields.io/badge/edition-2024-orange.svg)](../../Cargo.toml)
[![Platforms](https://img.shields.io/badge/platforms-Windows%20%7C%20macOS%20%7C%20Linux-lightgrey.svg)](../../README.md#download)

[English](../../README.md) · [Afrikaans](README.af.md) · Català · [Čeština](README.cs.md) · [Dansk](README.da.md) · [Deutsch](README.de.md) · [Ελληνικά](README.el.md) · [Español (Latinoamérica)](README.es-419.md) · [Español (España)](README.es-ES.md) · [Suomi](README.fi.md) · [Français](README.fr.md) · [Magyar](README.hu.md) · [Bahasa Indonesia](README.id.md) · [Italiano](README.it.md) · [日本語](README.ja.md) · [한국어](README.ko.md) · [Norsk bokmål](README.nb.md) · [Nederlands](README.nl.md) · [Polski](README.pl.md) · [Português (Brasil)](README.pt-BR.md) · [Português (Portugal)](README.pt-PT.md) · [Română](README.ro.md) · [Русский](README.ru.md) · [Српски](README.sr-Cyrl.md) · [Svenska](README.sv.md) · [ไทย](README.th.md) · [Türkçe](README.tr.md) · [Українська](README.uk.md) · [Tiếng Việt](README.vi.md) · [简体中文](README.zh-Hans.md) · [繁體中文](README.zh-Hant.md)

![Tailnet Link](../images/hero.svg)

**Queda’t a la teva tailnet. Accedeix alhora a les màquines de totes les altres.**

Tailscale només et deixa tenir la sessió iniciada en una tailnet cada vegada. Si el teu laboratori de casa, la teva empresa i un client tenen cadascun la seva, vas canviant de compte contínuament i tot allò a què estaves connectat es talla. Tailnet Link hi posa fi. L’aplicació de Tailscale es queda exactament on és, i Tailnet Link hi afegeix discretament les altres tailnets al costat: `https://wiki.comet-bebop.ts.net/` i `build-pc.capybara-iguana.ts.net` s’obren sense més.

**[Baixa la versió més recent](https://github.com/Azazel-Labs/tailnet-link/releases/latest)** per a Windows, macOS o Linux. És gratuït i de codi obert.

![Tailnet Link](../images/tailnets.png)

*Les captures de pantalla fan servir tailnets inventades; tots els noms i adreces que s’hi veuen són ficticis.*

## Per què Tailnet Link

- **S’ha acabat canviar de compte.** Afegeix totes les tailnets que necessitis i fes-les servir alhora. La teva tailnet no es desconnecta mai.
- **No cal configurar res.** Inicia la sessió i el domini de la tailnet es troba sol. Obre’n les màquines pel nom des de qualsevol navegador.
- **Troba els llocs web de les teves màquines.** Les màquines que serveixen una pàgina HTTPS apareixen com a mosaics amb el nom i la icona de la pàgina, a un clic. Cada màquina es comprova com a màxim un cop al dia.
- **No es baralla amb Tailscale.** Sense adaptador VPN, sense rutes, sense canvis de DNS. Cada tailnet addicional funciona com un node independent dins de l’aplicació, sense xocar amb l’aplicació de Tailscale ni entre elles.
- **Protegit per defecte.** Cada node addicional s’hi uneix amb els escuts alçats: tu pots accedir a aquelles tailnets, però res d’elles no pot arribar al teu ordinador.
- **Només hi passa el seu trànsit.** Les adreces de les altres tailnets passen per Tailnet Link. Tota la resta va directa, igual que abans.
- **Funciona amb aplicacions que ignoren el proxy.** L’Escriptori remot, SSH i els clients de bases de dades obtenen amb un clic un port local que porta a la màquina.
- **També funciona al terminal.** Posa `tl` davant de curl, git, ssh o ping, o executa `tl` sol per obrir un intèrpret d’ordres on funcionen els noms de les teves tailnets.
- **Ho deixa tot com estava.** La configuració del proxy del sistema només està activada mentre s’encamina alguna cosa, i es restaura en sortir, en posar-ho en pausa, si falla o si s’interromp el corrent.
- **Parla la teva llengua.** La interfície està traduïda a 31 idiomes.

## Com funciona

1. **Afegeix una tailnet.** La pàgina d’inici de sessió de Tailscale s’obre al navegador, igual que amb l’aplicació de Tailscale.
2. **El domini es detecta automàticament.** Quan inicies la sessió, Tailnet Link llegeix el nom MagicDNS de la tailnet (per exemple `capybara-iguana.ts.net`) i encamina `*.capybara-iguana.ts.net` per ella.
3. **Obre’n les màquines.** Escriu un nom al navegador o tria una màquina de la llista per obrir-la, copiar-ne l’adreça o redirigir-hi un port.

## Aplicacions que ignoren el proxy

Els navegadors i la majoria d’eines segueixen la configuració del proxy del sistema. L’Escriptori remot, els clients de bases de dades i aplicacions semblants, no. Per a aquestes, fes clic al botó de l’endoll al costat d’una màquina i tria un port: es tria i es conserva un port local lliure, i et connectes a `127.0.0.1:<port>`. A Windows, les redireccions de l’Escriptori remot tenen el seu propi botó **Obre l’Escriptori remot**.

![Tailnet Link](../images/forward.png)

## En un terminal

Les eines de línia d’ordres no llegeixen la configuració del proxy del sistema. Posa `tl`, que s’instal·la amb l’aplicació, davant d’una ordre, o executa `tl` sol per obrir un intèrpret d’ordres on funcionen els noms de les teves tailnets. El botó del terminal de la pestanya **Tailnets** n’obre un.

```sh
tl curl http://wiki.capybara-iguana.ts.net/
tl ssh admin@build-pc.capybara-iguana.ts.net
tl ping build-pc.capybara-iguana.ts.net
```

curl, git, npm, pip i la majoria de les altres eines funcionen així, i també ssh, scp i sftp. `tl ping` fa servir el ping propi de Tailscale. Els detalls són al [README en anglès](../../README.md#in-a-terminal-tl).

## Plataformes i baixada

Tailnet Link funciona a Windows, macOS (a la barra de menús) i Linux (GNOME amb l’extensió AppIndicator, o KDE). A Windows, executa **`tailnet-link-windows-setup.exe`**; al Mac, obre **`tailnet-link-macos-universal.dmg`** (Apple Silicon i Intel); a Ubuntu o Debian, executa `sudo apt install ./tailnet-link-linux-amd64.deb`. També hi ha versions sense instal·lador, i `SHA256SUMS.txt` conté les sumes de verificació.

**Sense signatura de codi.** A Windows, a l’avís de SmartScreen, tria **Més informació → Executa igualment**. A macOS, la primera vegada fes clic amb el botó dret a l’aplicació i tria **Obre**.

## Més informació

Els detalls (funcionament intern, proxy del sistema, instal·lador de Windows, fitxers, contribucions) són al [README en anglès](../../README.md). Per millorar una traducció, consulta [docs/translations.md](../../docs/translations.md).

Copyright © 2026 Azazel Labs LLC. Publicat sota [MIT-0](../../LICENSE). Tailnet Link no està fet per Tailscale Inc. ni hi està afiliat. Tailscale és una marca comercial de Tailscale Inc.
