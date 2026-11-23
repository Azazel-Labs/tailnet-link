# Tailnet Link

[![CI](https://github.com/Azazel-Labs/tailnet-link/actions/workflows/ci.yml/badge.svg)](https://github.com/Azazel-Labs/tailnet-link/actions/workflows/ci.yml)
[![Release](https://img.shields.io/github/v/release/Azazel-Labs/tailnet-link)](https://github.com/Azazel-Labs/tailnet-link/releases)
[![License: MIT-0](https://img.shields.io/badge/license-MIT--0-blue.svg)](../../LICENSE)
[![Rust: 1.95+](https://img.shields.io/badge/rust-1.95%2B-orange.svg)](../../Cargo.toml)
[![Edition: 2024](https://img.shields.io/badge/edition-2024-orange.svg)](../../Cargo.toml)
[![Platforms](https://img.shields.io/badge/platforms-Windows%20%7C%20macOS%20%7C%20Linux-lightgrey.svg)](../../README.md#download)

[English](../../README.md) · [Afrikaans](README.af.md) · [Català](README.ca.md) · [Čeština](README.cs.md) · [Dansk](README.da.md) · Deutsch · [Ελληνικά](README.el.md) · [Español (Latinoamérica)](README.es-419.md) · [Español (España)](README.es-ES.md) · [Suomi](README.fi.md) · [Français](README.fr.md) · [Magyar](README.hu.md) · [Bahasa Indonesia](README.id.md) · [Italiano](README.it.md) · [日本語](README.ja.md) · [한국어](README.ko.md) · [Norsk bokmål](README.nb.md) · [Nederlands](README.nl.md) · [Polski](README.pl.md) · [Português (Brasil)](README.pt-BR.md) · [Português (Portugal)](README.pt-PT.md) · [Română](README.ro.md) · [Русский](README.ru.md) · [Српски](README.sr-Cyrl.md) · [Svenska](README.sv.md) · [ไทย](README.th.md) · [Türkçe](README.tr.md) · [Українська](README.uk.md) · [Tiếng Việt](README.vi.md) · [简体中文](README.zh-Hans.md) · [繁體中文](README.zh-Hant.md)

![Tailnet Link](../images/hero.svg)

**Bleiben Sie in Ihrem eigenen Tailnet. Erreichen Sie gleichzeitig Geräte in allen anderen.**

Mit Tailscale sind Sie immer nur bei einem Tailnet angemeldet. Haben Ihr Homelab, Ihre Firma und ein Kunde jeweils ein eigenes, wechseln Sie ständig das Konto, und jede bestehende Verbindung bricht ab. Tailnet Link macht damit Schluss. Ihre Tailscale-App bleibt genau, wie sie ist, und Tailnet Link fügt die anderen Tailnets unauffällig daneben hinzu: `https://wiki.comet-bebop.ts.net/` und `build-pc.capybara-iguana.ts.net` öffnen sich einfach.

**[Neueste Version herunterladen](https://github.com/Azazel-Labs/tailnet-link/releases/latest)** für Windows, macOS oder Linux. Kostenlos und Open Source.

![Tailnet Link](../images/tailnets.png)

*Die Screenshots zeigen erfundene Tailnets; alle Namen und Adressen darin sind ausgedacht.*

## Warum Tailnet Link

- **Kein Kontowechsel mehr.** Fügen Sie so viele Tailnets hinzu, wie Sie brauchen, und nutzen Sie alle gleichzeitig. Ihr eigenes Tailnet wird nie getrennt.
- **Nichts einzurichten.** Anmelden genügt, die Domain des Tailnets wird automatisch gefunden. Öffnen Sie seine Geräte per Name in jedem Browser.
- **Findet die Websites auf Ihren Geräten.** Geräte, die eine HTTPS-Seite ausliefern, erscheinen als Kacheln mit Name und Symbol der Seite, nur einen Klick entfernt. Jedes Gerät wird höchstens einmal am Tag geprüft.
- **Verträgt sich mit Tailscale.** Kein VPN-Adapter, keine Routen, keine DNS-Änderungen. Jedes zusätzliche Tailnet läuft als eigener Knoten in der App, ohne Konflikte mit der Tailscale-App oder untereinander.
- **Standardmäßig abgeschottet.** Jeder zusätzliche Knoten tritt mit „Shields up“ bei: Sie erreichen diese Tailnets, aber nichts darin erreicht Ihren Computer.
- **Nur deren Verkehr läuft darüber.** Adressen in Ihren anderen Tailnets gehen über Tailnet Link, alles andere direkt, genau wie vorher.
- **Funktioniert mit Apps, die Proxys ignorieren.** Remotedesktop, SSH und Datenbankclients erhalten mit einem Klick einen lokalen Port, der zum Gerät führt.
- **Räumt hinter sich auf.** Die System-Proxy-Einstellung ist nur aktiv, solange etwas weitergeleitet wird, und wird beim Beenden, Pausieren, Absturz oder Stromausfall zurückgesetzt.
- **Spricht Ihre Sprache.** Die Oberfläche ist in 31 Sprachen übersetzt.

## So funktioniert es

1. **Tailnet hinzufügen.** Die Anmeldeseite von Tailscale öffnet sich in Ihrem Browser, genau wie bei der Tailscale-App.
2. **Die Domain wird automatisch erkannt.** Nach der Anmeldung liest Tailnet Link den MagicDNS-Namen des Tailnets (zum Beispiel `capybara-iguana.ts.net`) und leitet `*.capybara-iguana.ts.net` darüber.
3. **Geräte öffnen.** Geben Sie einen Namen im Browser ein oder wählen Sie ein Gerät aus der Liste, um es zu öffnen, seine Adresse zu kopieren oder einen Port dorthin weiterzuleiten.

## Apps, die Proxys ignorieren

Browser und die meisten Tools folgen der System-Proxy-Einstellung. Remotedesktop, Datenbankclients und ähnliche Apps nicht. Klicken Sie für diese auf das Stecker-Symbol neben einem Gerät und wählen Sie einen Port: Ein freier lokaler Port wird vergeben und beibehalten, und Sie verbinden sich mit `127.0.0.1:<Port>`. Unter Windows erhalten Remotedesktop-Weiterleitungen eine eigene Schaltfläche **Remotedesktop öffnen**.

![Tailnet Link](../images/forward.png)

## Plattformen und Download

Tailnet Link läuft unter Windows, macOS (in der Menüleiste) und Linux (GNOME mit der AppIndicator-Erweiterung oder KDE). Unter Windows starten Sie **`tailnet-link-windows-setup.exe`**, auf dem Mac öffnen Sie **`tailnet-link-macos-universal.dmg`** (Apple Silicon und Intel), unter Ubuntu oder Debian führen Sie `sudo apt install ./tailnet-link-linux-amd64.deb` aus. Die Apps gibt es auch ohne Installer; `SHA256SUMS.txt` enthält die Prüfsummen.

**Nicht codesigniert.** Wählen Sie unter Windows bei der SmartScreen-Warnung **Weitere Informationen → Trotzdem ausführen**. Klicken Sie unter macOS beim ersten Mal mit der rechten Maustaste auf die App und wählen Sie **Öffnen**.

## Mehr erfahren

Alle Details (Funktionsweise, System-Proxy, Windows-Installer, Dateien, Mitwirken) stehen in der [englischen README](../../README.md). Wie Sie eine Übersetzung verbessern, erklärt [docs/translations.md](../../docs/translations.md).

Copyright © 2026 Azazel Labs LLC. Veröffentlicht unter [MIT-0](../../LICENSE). Tailnet Link wird nicht von Tailscale Inc. entwickelt und ist nicht mit Tailscale Inc. verbunden. Tailscale ist eine Marke von Tailscale Inc.
