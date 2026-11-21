# Tailnet Link

[![CI](https://github.com/Azazel-Labs/tailnet-link/actions/workflows/ci.yml/badge.svg)](https://github.com/Azazel-Labs/tailnet-link/actions/workflows/ci.yml)
[![Release](https://img.shields.io/github/v/release/Azazel-Labs/tailnet-link)](https://github.com/Azazel-Labs/tailnet-link/releases)
[![License: MIT-0](https://img.shields.io/badge/license-MIT--0-blue.svg)](../../LICENSE)
[![Rust: 1.95+](https://img.shields.io/badge/rust-1.95%2B-orange.svg)](../../Cargo.toml)
[![Edition: 2024](https://img.shields.io/badge/edition-2024-orange.svg)](../../Cargo.toml)
[![Platforms](https://img.shields.io/badge/platforms-Windows%20%7C%20macOS%20%7C%20Linux-lightgrey.svg)](../../README.md#download)

[English](../../README.md) · [Afrikaans](README.af.md) · [Català](README.ca.md) · [Čeština](README.cs.md) · [Dansk](README.da.md) · [Deutsch](README.de.md) · [Ελληνικά](README.el.md) · [Español (Latinoamérica)](README.es-419.md) · [Español (España)](README.es-ES.md) · [Suomi](README.fi.md) · [Français](README.fr.md) · [Magyar](README.hu.md) · [Bahasa Indonesia](README.id.md) · [Italiano](README.it.md) · [日本語](README.ja.md) · [한국어](README.ko.md) · [Norsk bokmål](README.nb.md) · Nederlands · [Polski](README.pl.md) · [Português (Brasil)](README.pt-BR.md) · [Português (Portugal)](README.pt-PT.md) · [Română](README.ro.md) · [Русский](README.ru.md) · [Српски](README.sr-Cyrl.md) · [Svenska](README.sv.md) · [ไทย](README.th.md) · [Türkçe](README.tr.md) · [Українська](README.uk.md) · [Tiếng Việt](README.vi.md) · [简体中文](README.zh-Hans.md) · [繁體中文](README.zh-Hant.md)

![Tailnet Link](../images/hero.svg)

**Blijf op je eigen tailnet. Bereik tegelijk de machines in alle andere.**

Met Tailscale ben je bij één tailnet tegelijk ingelogd. Hebben je homelab, je werkgever en een klant elk hun eigen tailnet, dan wissel je steeds van account en valt weg waarmee je verbonden was. Tailnet Link maakt daar een eind aan. Je Tailscale-app blijft precies waar hij is, en Tailnet Link zet de andere tailnets er ongemerkt naast. Zo openen `https://wiki.studio.example/` en `build-pc.home.example` allebei gewoon.

**[Download de nieuwste versie](https://github.com/Azazel-Labs/tailnet-link/releases/latest)** voor Windows, macOS of Linux. Gratis en open source.

![Tailnet Link](../images/tailnets.png)

*De schermafbeeldingen gebruiken verzonnen tailnets; alle namen en adressen erin zijn fictief.*

## Waarom Tailnet Link

- **Nooit meer van account wisselen.** Voeg zoveel tailnets toe als je nodig hebt en gebruik ze allemaal tegelijk. Je eigen tailnet verbreekt nooit de verbinding.
- **Niets in te stellen.** Log in en het domein van het tailnet wordt voor je gevonden. Open de machines op naam in elke browser.
- **Zit Tailscale niet in de weg.** Geen VPN-adapter, geen routes, geen DNS-wijzigingen. Elk extra tailnet draait als een aparte node in de app, dus niets botst met de Tailscale-app of met elkaar.
- **Standaard afgeschermd.** Elke extra node doet mee met shields up: jij bereikt die tailnets, maar niets daarin kan jouw computer bereiken.
- **Alleen hun verkeer gaat erdoor.** Adressen in je andere tailnets lopen via Tailnet Link. Al het andere gaat rechtstreeks, precies zoals voorheen.
- **Werkt met apps die proxy's negeren.** Extern bureaublad, SSH en databaseclients krijgen met één klik een lokale poort die naar de machine leidt.
- **Ruimt zelf op.** De proxyinstelling van het systeem staat alleen aan zolang er iets gerouteerd wordt, en wordt teruggezet bij afsluiten, pauzeren, een crash of stroomuitval.
- **Spreekt jouw taal.** De interface is vertaald in 31 talen.

## Zo werkt het

1. **Voeg een tailnet toe.** De eigen inlogpagina van Tailscale opent in je browser, net als bij de Tailscale-app.
2. **Het domein wordt automatisch gevonden.** Na het inloggen leest Tailnet Link de MagicDNS-naam van het tailnet (bijvoorbeeld `example.ts.net`) en routeert `*.example.ts.net` daarlangs.
3. **Open de machines.** Typ een naam in je browser, of kies een machine uit de lijst om hem te openen, het adres te kopiëren of er een poort naar door te sturen.

## Apps die proxy's negeren

Browsers en de meeste tools volgen de proxyinstelling van het systeem. Extern bureaublad, databaseclients en vergelijkbare apps doen dat niet. Klik daarvoor op de stekkerknop naast een machine en kies een poort: er wordt een vrije lokale poort gekozen en vastgehouden, en je maakt verbinding met `127.0.0.1:<port>`. Op Windows krijgen doorsturingen voor Extern bureaublad een eigen knop **Extern bureaublad openen**.

![Tailnet Link](../images/forward.png)

## Platforms en download

Tailnet Link werkt op Windows, macOS (in de menubalk) en Linux (GNOME met de AppIndicator-extensie, of KDE). Start op Windows **`tailnet-link-windows-setup.exe`**, open op een Mac **`tailnet-link-macos-universal.dmg`** (Apple Silicon en Intel) en voer op Ubuntu of Debian `sudo apt install ./tailnet-link-linux-amd64.deb` uit. Er zijn ook versies zonder installatieprogramma, en `SHA256SUMS.txt` bevat de controlesommen.

**Niet digitaal ondertekend.** Kies op Windows bij de SmartScreen-waarschuwing **Meer informatie → Toch uitvoeren**. Klik op macOS de eerste keer met de rechtermuisknop op de app en kies **Open**.

## Meer weten

Alle details (de techniek eronder, de systeemproxy, het Windows-installatieprogramma, bestanden, bijdragen) staan in de [Engelse README](../../README.md). Wil je een vertaling verbeteren? Zie [docs/translations.md](../../docs/translations.md).

Copyright © 2026 Azazel Labs LLC. Uitgebracht onder [MIT-0](../../LICENSE). Tailnet Link is niet gemaakt door of gelieerd aan Tailscale Inc. Tailscale is een handelsmerk van Tailscale Inc.
