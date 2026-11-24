# Tailnet Link

[![CI](https://github.com/Azazel-Labs/tailnet-link/actions/workflows/ci.yml/badge.svg)](https://github.com/Azazel-Labs/tailnet-link/actions/workflows/ci.yml)
[![Release](https://img.shields.io/github/v/release/Azazel-Labs/tailnet-link)](https://github.com/Azazel-Labs/tailnet-link/releases)
[![License: MIT-0](https://img.shields.io/badge/license-MIT--0-blue.svg)](../../LICENSE)
[![Rust: 1.95+](https://img.shields.io/badge/rust-1.95%2B-orange.svg)](../../Cargo.toml)
[![Edition: 2024](https://img.shields.io/badge/edition-2024-orange.svg)](../../Cargo.toml)
[![Platforms](https://img.shields.io/badge/platforms-Windows%20%7C%20macOS%20%7C%20Linux-lightgrey.svg)](../../README.md#download)

[English](../../README.md) · Afrikaans · [Català](README.ca.md) · [Čeština](README.cs.md) · [Dansk](README.da.md) · [Deutsch](README.de.md) · [Ελληνικά](README.el.md) · [Español (Latinoamérica)](README.es-419.md) · [Español (España)](README.es-ES.md) · [Suomi](README.fi.md) · [Français](README.fr.md) · [Magyar](README.hu.md) · [Bahasa Indonesia](README.id.md) · [Italiano](README.it.md) · [日本語](README.ja.md) · [한국어](README.ko.md) · [Norsk bokmål](README.nb.md) · [Nederlands](README.nl.md) · [Polski](README.pl.md) · [Português (Brasil)](README.pt-BR.md) · [Português (Portugal)](README.pt-PT.md) · [Română](README.ro.md) · [Русский](README.ru.md) · [Српски](README.sr-Cyrl.md) · [Svenska](README.sv.md) · [ไทย](README.th.md) · [Türkçe](README.tr.md) · [Українська](README.uk.md) · [Tiếng Việt](README.vi.md) · [简体中文](README.zh-Hans.md) · [繁體中文](README.zh-Hant.md)

![Tailnet Link](../images/hero.svg)

**Bly op jou eie tailnet. Bereik masjiene op al die ander, terselfdertyd.**

Met Tailscale kan jy net by een tailnet op 'n slag aangemeld wees. As jou tuislab, jou maatskappy en 'n kliënt elk hul eie het, wissel jy aanhoudend van rekening, en wat jy ook al aan gekoppel was, val weg. Tailnet Link maak daar 'n einde aan. Jou Tailscale-app bly presies waar dit is, en Tailnet Link voeg die ander tailnets stilletjies langsaan by, sodat `https://wiki.comet-bebop.ts.net/` en `build-pc.capybara-iguana.ts.net` albei sommer net oopmaak.

**[Laai die nuutste weergawe af](https://github.com/Azazel-Labs/tailnet-link/releases/latest)** vir Windows, macOS of Linux. Dit is gratis en oopbron.

![Die Tailnets-oortjie met twee tailnets wat roeteer en hul masjiene gelys](../images/tailnets.png)

*Die skermskote gebruik versinde tailnets; elke naam en adres daarin is uitgedink.*

## Hoekom Tailnet Link

- **Geen rekeningwisseling meer nie.** Voeg soveel tailnets by as wat jy nodig het en gebruik hulle almal gelyk. Jou eie tailnet ontkoppel nooit.
- **Niks om op te stel nie.** Meld aan, en die tailnet se domein word vir jou gevind. Maak sy masjiene volgens naam in enige blaaier oop.
- **Vind die webwerwe op jou masjiene.** Masjiene wat 'n HTTPS-bladsy bedien, word gelys met die bladsy se naam en ikoon, net een klik weg. Gee dié wat jy gebruik 'n ster, en hulle word teëls met 'n prent van die bladsy. Elke masjien word hoogstens een keer per dag nagegaan.
- **Baklei nie met Tailscale nie.** Geen VPN-adapter, geen roetes, geen DNS-veranderinge nie. Elke ekstra tailnet loop as 'n aparte nodus binne die app.
- **By verstek toegesluit.** Elke ekstra nodus sluit aan met die skilde op: jy kan daardie tailnets bereik, maar niks daarin kan jou rekenaar bereik nie.
- **Net hul verkeer gaan daardeur.** Adresse in jou ander tailnets gaan deur Tailnet Link. Alles anders gaan direk, presies soos voorheen.
- **Werk met apps wat instaanbedieners ignoreer.** Remote Desktop, SSH en databasiskliënte kry met een klik 'n plaaslike poort wat na die masjien lei.
- **Werk ook in die terminaal.** Sit `tl` voor curl, git, ssh of ping, of voer `tl` op sy eie uit vir 'n shell waar jou tailnets se name werk.
- **Ruim self op.** Die stelsel se instaanbedienerinstelling is net aan terwyl iets geroeteer word, en word teruggesit wanneer jy afsluit, pouseer, of as die app ineenstort of die krag uitgaan.
- **Praat jou taal.** Die koppelvlak is in 31 tale vertaal.

## Hoe dit werk

1. **Voeg 'n tailnet by.** Tailscale se eie aanmeldbladsy maak in jou blaaier oop, net soos met die Tailscale-app.
2. **Sy domein word outomaties opgespoor.** Nadat jy aangemeld het, lees Tailnet Link die tailnet se MagicDNS-naam (byvoorbeeld `capybara-iguana.ts.net`) en roeteer `*.capybara-iguana.ts.net` daardeur.
3. **Maak sy masjiene oop.** Tik 'n naam in jou blaaier, of kies 'n masjien uit die lys om dit oop te maak, sy adres te kopieer of 'n poort daarheen aan te stuur.

## Apps wat instaanbedieners ignoreer

Blaaiers en die meeste gereedskap volg die stelsel se instaanbedienerinstelling. Remote Desktop, databasiskliënte en soortgelyke apps doen dit nie. Klik dan op die propknoppie langs 'n masjien en kies 'n poort: 'n vrye plaaslike poort word gekies en behou, en jy koppel aan `127.0.0.1:<poort>`. Op Windows kry Remote Desktop-aanstuurings hul eie **Maak Remote Desktop oop**-knoppie.

![Die dialoog ná die aanstuur van Remote Desktop: 'n plaaslike adres om te kopieer en 'n knoppie wat Remote Desktop oopmaak](../images/forward.png)

## In 'n terminaal

Opdragreëlgereedskap lees nie die stelsel se instaanbedienerinstelling nie. Sit `tl`, wat saam met die app geïnstalleer word, voor 'n opdrag, of voer `tl` op sy eie uit vir 'n shell waar jou tailnets se name werk. Die terminaalknoppie op die **Tailnets**-oortjie maak een oop.

```sh
tl curl http://wiki.capybara-iguana.ts.net/
tl ssh admin@build-pc.capybara-iguana.ts.net
tl ping build-pc.capybara-iguana.ts.net
```

curl, git, npm, pip en die meeste ander gereedskap werk so, en ssh, scp en sftp ook. `tl ping` gebruik Tailscale se eie ping. Die besonderhede is in [die Engelse README](../../README.md#in-a-terminal-tl).

## Platforms en aflaai

Tailnet Link loop op Windows (venster en kennisgewingarea), macOS (kieslysbalk) en Linux (GNOME en KDE). Laai **`tailnet-link-windows-setup.exe`** vir Windows, **`tailnet-link-macos-universal.dmg`** vir Mac of **`tailnet-link-linux-amd64.deb`** vir Ubuntu en Debian (`sudo apt install ./tailnet-link-linux-amd64.deb`) van [die nuutste weergawe](https://github.com/Azazel-Labs/tailnet-link/releases/latest) af.

Die app is **nie kodegeteken nie**. Kies op Windows by die SmartScreen-waarskuwing **More info → Run anyway** (Meer inligting → Hardloop in elk geval). Regsklik op macOS die eerste keer op die app en kies **Open**.

## Meer inligting

Al die besonderhede, soos hoe die instaanbedienerinstelling hanteer word, waar die lêers is en wat die Windows-installeerder doen, is in [die Engelse README](../../README.md). Verbeterings aan die vertaling is baie welkom: sien [docs/translations.md](../../docs/translations.md).

Kopiereg © 2026 Azazel Labs LLC. Vrygestel onder [MIT-0](../../LICENSE). Tailnet Link is nie deur Tailscale Inc. gemaak of daaraan verbonde nie. Tailscale is 'n handelsmerk van Tailscale Inc.
