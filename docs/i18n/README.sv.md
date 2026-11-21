# Tailnet Link

[![CI](https://github.com/Azazel-Labs/tailnet-link/actions/workflows/ci.yml/badge.svg)](https://github.com/Azazel-Labs/tailnet-link/actions/workflows/ci.yml)
[![Release](https://img.shields.io/github/v/release/Azazel-Labs/tailnet-link)](https://github.com/Azazel-Labs/tailnet-link/releases)
[![License: MIT-0](https://img.shields.io/badge/license-MIT--0-blue.svg)](../../LICENSE)
[![Rust: 1.95+](https://img.shields.io/badge/rust-1.95%2B-orange.svg)](../../Cargo.toml)
[![Edition: 2024](https://img.shields.io/badge/edition-2024-orange.svg)](../../Cargo.toml)
[![Platforms](https://img.shields.io/badge/platforms-Windows%20%7C%20macOS%20%7C%20Linux-lightgrey.svg)](../../README.md#download)

[English](../../README.md) · [Afrikaans](README.af.md) · [Català](README.ca.md) · [Čeština](README.cs.md) · [Dansk](README.da.md) · [Deutsch](README.de.md) · [Ελληνικά](README.el.md) · [Español (Latinoamérica)](README.es-419.md) · [Español (España)](README.es-ES.md) · [Suomi](README.fi.md) · [Français](README.fr.md) · [Magyar](README.hu.md) · [Bahasa Indonesia](README.id.md) · [Italiano](README.it.md) · [日本語](README.ja.md) · [한국어](README.ko.md) · [Norsk bokmål](README.nb.md) · [Nederlands](README.nl.md) · [Polski](README.pl.md) · [Português (Brasil)](README.pt-BR.md) · [Português (Portugal)](README.pt-PT.md) · [Română](README.ro.md) · [Русский](README.ru.md) · [Српски](README.sr-Cyrl.md) · Svenska · [ไทย](README.th.md) · [Türkçe](README.tr.md) · [Українська](README.uk.md) · [Tiếng Việt](README.vi.md) · [简体中文](README.zh-Hans.md) · [繁體中文](README.zh-Hant.md)

![Tailnet Link](../images/hero.svg)

**Stanna i ditt eget tailnet. Nå datorer i alla andra, samtidigt.**

Med Tailscale kan du bara vara inloggad i ett tailnet åt gången. Har ditt hemlabb, ditt företag och en kund var sitt, får du byta konto hela tiden, och det du var ansluten till kopplas ner. Tailnet Link gör slut på det. Tailscale-appen stannar precis där den är, och Tailnet Link lägger diskret till de andra tailneten bredvid, så att både `https://wiki.studio.example/` och `build-pc.home.example` bara öppnas.

**[Hämta den senaste utgåvan](https://github.com/Azazel-Labs/tailnet-link/releases/latest)** för Windows, macOS eller Linux. Gratis och öppen källkod.

![Fliken Tailnet med två tailnet som dirigerar och deras datorer i listan](../images/tailnets.png)

*Skärmbilderna visar påhittade tailnet; alla namn och adresser i dem är uppdiktade.*

## Varför Tailnet Link

- **Inga fler kontobyten.** Lägg till så många tailnet du behöver och använd alla på en gång. Ditt eget tailnet kopplas aldrig ner.
- **Inget att konfigurera.** Logga in, så hittas tailnetets domän åt dig. Öppna dess datorer med namn i valfri webbläsare.
- **Krockar inte med Tailscale.** Ingen VPN-adapter, inga rutter, inga DNS-ändringar. Varje extra tailnet körs som en separat nod inuti appen.
- **Låst som standard.** Varje extra nod ansluter med sköldarna uppe: du når de tailneten, men inget i dem når din dator.
- **Bara deras trafik går igenom.** Adresser i dina andra tailnet går via Tailnet Link. Allt annat går direkt, precis som förut.
- **Fungerar med appar som ignorerar proxyn.** Fjärrskrivbord, SSH och databasklienter får med ett klick en lokal port som leder till datorn.
- **Städar efter sig.** Systemets proxyinställning är bara på medan något dirigeras, och återställs vid avslut, paus, krasch eller strömavbrott.
- **Talar ditt språk.** Gränssnittet finns på 31 språk.

## Så fungerar det

1. **Lägg till ett tailnet.** Tailscales egen inloggningssida öppnas i webbläsaren, precis som med Tailscale-appen.
2. **Domänen hämtas automatiskt.** När du har loggat in läser Tailnet Link tailnetets MagicDNS-namn (till exempel `example.ts.net`) och dirigerar `*.example.ts.net` via det.
3. **Öppna dess datorer.** Skriv ett namn i webbläsaren, eller välj en dator i listan för att öppna den, kopiera dess adress eller vidarebefordra en port till den.

## Appar som ignorerar proxyn

Webbläsare och de flesta verktyg följer systemets proxyinställning. Fjärrskrivbord, databasklienter och liknande appar gör det inte. Klicka då på kontaktknappen vid en dator och välj en port: en ledig lokal port väljs och behålls, och du ansluter till `127.0.0.1:<port>`. På Windows får vidarebefordringar för Fjärrskrivbord en egen knapp, **Öppna Fjärrskrivbord**.

![Dialogen efter vidarebefordring av Fjärrskrivbord: en lokal adress att kopiera och en knapp som öppnar Fjärrskrivbord](../images/forward.png)

## Plattformar och nedladdning

Tailnet Link körs på Windows (fönster och meddelandefält), macOS (menyraden) och Linux (GNOME och KDE). Hämta **`tailnet-link-windows-setup.exe`** för Windows, **`tailnet-link-macos-universal.dmg`** för Mac eller **`tailnet-link-linux-amd64.deb`** för Ubuntu och Debian (`sudo apt install ./tailnet-link-linux-amd64.deb`) från [den senaste utgåvan](https://github.com/Azazel-Labs/tailnet-link/releases/latest).

Apparna är **inte kodsignerade**. På Windows väljer du **Mer information → Kör ändå** vid SmartScreen-varningen. På macOS högerklickar du på appen och väljer **Öppna** första gången.

## Mer information

Alla detaljer, som proxyinställningens beteende, filplatser och vad Windows-installationsprogrammet gör, finns i [den engelska README-filen](../../README.md). Förbättringar av översättningen är välkomna: se [docs/translations.md](../../docs/translations.md).

Copyright © 2026 Azazel Labs LLC. Släppt under [MIT-0](../../LICENSE). Tailnet Link är inte gjort av eller knutet till Tailscale Inc. Tailscale är ett varumärke som tillhör Tailscale Inc.
