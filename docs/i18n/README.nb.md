# Tailnet Link

[![CI](https://github.com/Azazel-Labs/tailnet-link/actions/workflows/ci.yml/badge.svg)](https://github.com/Azazel-Labs/tailnet-link/actions/workflows/ci.yml)
[![Release](https://img.shields.io/github/v/release/Azazel-Labs/tailnet-link)](https://github.com/Azazel-Labs/tailnet-link/releases)
[![License: MIT-0](https://img.shields.io/badge/license-MIT--0-blue.svg)](../../LICENSE)
[![Rust: 1.95+](https://img.shields.io/badge/rust-1.95%2B-orange.svg)](../../Cargo.toml)
[![Edition: 2024](https://img.shields.io/badge/edition-2024-orange.svg)](../../Cargo.toml)
[![Platforms](https://img.shields.io/badge/platforms-Windows%20%7C%20macOS%20%7C%20Linux-lightgrey.svg)](../../README.md#download)

[English](../../README.md) · [Afrikaans](README.af.md) · [Català](README.ca.md) · [Čeština](README.cs.md) · [Dansk](README.da.md) · [Deutsch](README.de.md) · [Ελληνικά](README.el.md) · [Español (Latinoamérica)](README.es-419.md) · [Español (España)](README.es-ES.md) · [Suomi](README.fi.md) · [Français](README.fr.md) · [Magyar](README.hu.md) · [Bahasa Indonesia](README.id.md) · [Italiano](README.it.md) · [日本語](README.ja.md) · [한국어](README.ko.md) · Norsk bokmål · [Nederlands](README.nl.md) · [Polski](README.pl.md) · [Português (Brasil)](README.pt-BR.md) · [Português (Portugal)](README.pt-PT.md) · [Română](README.ro.md) · [Русский](README.ru.md) · [Српски](README.sr-Cyrl.md) · [Svenska](README.sv.md) · [ไทย](README.th.md) · [Türkçe](README.tr.md) · [Українська](README.uk.md) · [Tiếng Việt](README.vi.md) · [简体中文](README.zh-Hans.md) · [繁體中文](README.zh-Hant.md)

![Tailnet Link](../images/hero.svg)

**Bli på ditt eget tailnet. Nå maskiner på alle de andre, samtidig.**

Med Tailscale kan du bare være logget på ett tailnet om gangen. Har hjemmelaben din, arbeidsplassen og en kunde hvert sitt, må du bytte konto hele tiden, og det du var koblet til, faller ut. Tailnet Link gjør slutt på det. Tailscale-appen blir værende der den er, og Tailnet Link legger stille og rolig til de andre tailnettene ved siden av, slik at både `https://wiki.comet-bebop.ts.net/` og `build-pc.capybara-iguana.ts.net` bare åpnes.

**[Last ned den nyeste utgivelsen](https://github.com/Azazel-Labs/tailnet-link/releases/latest)** for Windows, macOS eller Linux. Gratis og åpen kildekode.

![Fanen Tailnets med to tailnets som ruter, og maskinene deres i listen](../images/tailnets.png)

*Skjermbildene viser oppdiktede tailnets; alle navn og adresser i dem er oppfunnet.*

## Hvorfor Tailnet Link

- **Slutt på kontobytter.** Legg til så mange tailnets du trenger, og bruk alle samtidig. Ditt eget tailnet kobles aldri fra.
- **Ingenting å konfigurere.** Logg på, så finnes tailnettets domene for deg. Åpne maskinene der ved navn i hvilken som helst nettleser.
- **Kommer ikke i veien for Tailscale.** Ingen VPN-adapter, ingen ruter, ingen DNS-endringer. Hvert ekstra tailnet kjører som en egen node inne i appen.
- **Låst ned som standard.** Hver ekstra node kobler seg til med skjoldene oppe: du når de tailnettene, men ingenting i dem når datamaskinen din.
- **Bare trafikken deres går gjennom.** Adresser i de andre tailnettene dine går gjennom Tailnet Link. Alt annet går direkte, akkurat som før.
- **Fungerer med apper som ignorerer proxyer.** Eksternt skrivebord, SSH og databaseklienter får med ett klikk en lokal port som leder til maskinen.
- **Rydder opp etter seg.** Systemets proxy-innstilling er bare på mens noe rutes, og settes tilbake ved avslutning, pause, krasj eller strømbrudd.
- **Snakker språket ditt.** Grensesnittet finnes på 31 språk.

## Slik fungerer det

1. **Legg til et tailnet.** Tailscales egen påloggingsside åpnes i nettleseren, akkurat som med Tailscale-appen.
2. **Domenet hentes automatisk.** Når du har logget på, leser Tailnet Link tailnettets MagicDNS-navn (for eksempel `capybara-iguana.ts.net`) og ruter `*.capybara-iguana.ts.net` gjennom det.
3. **Åpne maskinene der.** Skriv et navn i nettleseren, eller velg en maskin i listen for å åpne den, kopiere adressen eller videresende en port til den.

## Apper som ignorerer proxyer

Nettlesere og de fleste verktøy følger systemets proxy-innstilling. Eksternt skrivebord, databaseklienter og lignende apper gjør det ikke. Klikk da på støpselknappen ved en maskin og velg en port: en ledig lokal port velges og beholdes, og du kobler til `127.0.0.1:<port>`. På Windows får videresendinger for Eksternt skrivebord sin egen knapp, **Åpne Eksternt skrivebord**.

![Dialogen etter videresending av Eksternt skrivebord: en lokal adresse å kopiere og en knapp som åpner Eksternt skrivebord](../images/forward.png)

## Plattformer og nedlasting

Tailnet Link kjører på Windows (vindu og systemstatusfelt), macOS (menylinjen) og Linux (GNOME og KDE). Last ned **`tailnet-link-windows-setup.exe`** for Windows, **`tailnet-link-macos-universal.dmg`** for Mac eller **`tailnet-link-linux-amd64.deb`** for Ubuntu og Debian (`sudo apt install ./tailnet-link-linux-amd64.deb`) fra [den nyeste utgivelsen](https://github.com/Azazel-Labs/tailnet-link/releases/latest).

Appen er **ikke kodesignert**. På Windows velger du **Mer informasjon → Kjør likevel** ved SmartScreen-advarselen. På macOS høyreklikker du på appen og velger **Åpne** første gang.

## Mer informasjon

Alle detaljer, blant annet hvordan proxy-innstillingen håndteres, hvor filene ligger og hva Windows-installasjonsprogrammet gjør, står i [den engelske README-filen](../../README.md). Forbedringer av oversettelsen er hjertelig velkomne: se [docs/translations.md](../../docs/translations.md).

Copyright © 2026 Azazel Labs LLC. Utgitt under [MIT-0](../../LICENSE). Tailnet Link er ikke laget av eller tilknyttet Tailscale Inc. Tailscale er et varemerke som tilhører Tailscale Inc.
