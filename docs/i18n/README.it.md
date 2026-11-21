# Tailnet Link

[![CI](https://github.com/Azazel-Labs/tailnet-link/actions/workflows/ci.yml/badge.svg)](https://github.com/Azazel-Labs/tailnet-link/actions/workflows/ci.yml)
[![Release](https://img.shields.io/github/v/release/Azazel-Labs/tailnet-link)](https://github.com/Azazel-Labs/tailnet-link/releases)
[![License: MIT-0](https://img.shields.io/badge/license-MIT--0-blue.svg)](../../LICENSE)
[![Rust: 1.95+](https://img.shields.io/badge/rust-1.95%2B-orange.svg)](../../Cargo.toml)
[![Edition: 2024](https://img.shields.io/badge/edition-2024-orange.svg)](../../Cargo.toml)
[![Platforms](https://img.shields.io/badge/platforms-Windows%20%7C%20macOS%20%7C%20Linux-lightgrey.svg)](../../README.md#download)

[English](../../README.md) · [Afrikaans](README.af.md) · [Català](README.ca.md) · [Čeština](README.cs.md) · [Dansk](README.da.md) · [Deutsch](README.de.md) · [Ελληνικά](README.el.md) · [Español (Latinoamérica)](README.es-419.md) · [Español (España)](README.es-ES.md) · [Suomi](README.fi.md) · [Français](README.fr.md) · [Magyar](README.hu.md) · [Bahasa Indonesia](README.id.md) · Italiano · [日本語](README.ja.md) · [한국어](README.ko.md) · [Norsk bokmål](README.nb.md) · [Nederlands](README.nl.md) · [Polski](README.pl.md) · [Português (Brasil)](README.pt-BR.md) · [Português (Portugal)](README.pt-PT.md) · [Română](README.ro.md) · [Русский](README.ru.md) · [Српски](README.sr-Cyrl.md) · [Svenska](README.sv.md) · [ไทย](README.th.md) · [Türkçe](README.tr.md) · [Українська](README.uk.md) · [Tiếng Việt](README.vi.md) · [简体中文](README.zh-Hans.md) · [繁體中文](README.zh-Hant.md)

![Tailnet Link](../images/hero.svg)

**Resta sul tuo tailnet. Raggiungi i dispositivi di tutti gli altri, contemporaneamente.**

Con Tailscale puoi essere connesso a un solo tailnet alla volta. Se il tuo home lab, la tua azienda e un cliente hanno ciascuno il proprio, continui a cambiare account e tutto ciò a cui eri connesso cade. Tailnet Link mette fine a tutto questo. L'app Tailscale resta esattamente dov'è e Tailnet Link aggiunge discretamente gli altri tailnet al suo fianco: `https://wiki.studio.example/` e `build-pc.home.example` si aprono e basta.

**[Scarica l'ultima versione](https://github.com/Azazel-Labs/tailnet-link/releases/latest)** per Windows, macOS o Linux. È gratuita e open source.

![Tailnet Link](../images/tailnets.png)

*Gli screenshot usano tailnet di fantasia; tutti i nomi e gli indirizzi sono inventati.*

## Perché Tailnet Link

- **Basta cambiare account.** Aggiungi tutti i tailnet che ti servono e usali tutti insieme. Il tuo tailnet non si disconnette mai.
- **Niente da configurare.** Accedi e il dominio del tailnet viene trovato per te. Apri i suoi dispositivi per nome in qualsiasi browser.
- **Non entra in conflitto con Tailscale.** Nessun adattatore VPN, nessuna route, nessuna modifica al DNS. Ogni tailnet aggiuntivo gira come nodo separato all'interno dell'app, senza conflitti con l'app Tailscale né tra loro.
- **Protetto per impostazione predefinita.** Ogni nodo aggiuntivo entra con gli scudi alzati: tu raggiungi quei tailnet, ma nulla al loro interno può raggiungere il tuo computer.
- **Ci passa solo il loro traffico.** Gli indirizzi degli altri tailnet passano da Tailnet Link; tutto il resto va diretto, esattamente come prima.
- **Funziona con le app che ignorano il proxy.** Desktop remoto, SSH e i client di database ricevono con un clic una porta locale che conduce al dispositivo.
- **Rimette tutto a posto.** Il proxy di sistema è attivo solo mentre qualcosa viene instradato e viene ripristinato all'uscita, in pausa, in caso di crash o di blackout.
- **Parla la tua lingua.** L'interfaccia è tradotta in 31 lingue.

## Come funziona

1. **Aggiungi un tailnet.** La pagina di accesso di Tailscale si apre nel browser, proprio come con l'app Tailscale.
2. **Il dominio viene rilevato automaticamente.** Dopo l'accesso, Tailnet Link legge il nome MagicDNS del tailnet (ad esempio `example.ts.net`) e instrada `*.example.ts.net` attraverso di esso.
3. **Apri i suoi dispositivi.** Digita un nome nel browser, oppure scegli un dispositivo dall'elenco per aprirlo, copiarne l'indirizzo o inoltrargli una porta.

## App che ignorano il proxy

I browser e la maggior parte degli strumenti seguono il proxy di sistema. Desktop remoto, i client di database e app simili no. Per queste, fai clic sul pulsante a forma di spina accanto a un dispositivo e scegli una porta: viene assegnata e mantenuta una porta locale libera, e ti connetti a `127.0.0.1:<porta>`. Su Windows, gli inoltri di Desktop remoto hanno il loro pulsante **Apri Desktop remoto**.

![Tailnet Link](../images/forward.png)

## Piattaforme e download

Tailnet Link funziona su Windows, macOS (nella barra dei menu) e Linux (GNOME con l'estensione AppIndicator, oppure KDE). Su Windows avvia **`tailnet-link-windows-setup.exe`**; su Mac apri **`tailnet-link-macos-universal.dmg`** (Apple Silicon e Intel); su Ubuntu o Debian esegui `sudo apt install ./tailnet-link-linux-amd64.deb`. Sono disponibili anche versioni senza programma di installazione, e `SHA256SUMS.txt` elenca i checksum.

**Senza firma del codice.** Su Windows, all'avviso di SmartScreen scegli **Ulteriori informazioni → Esegui comunque**. Su macOS, la prima volta fai clic destro sull'app e scegli **Apri**.

## Per saperne di più

Tutti i dettagli (funzionamento interno, proxy di sistema, programma di installazione per Windows, file, come contribuire) sono nel [README in inglese](../../README.md). Per migliorare una traduzione, consulta [docs/translations.md](../../docs/translations.md).

Copyright © 2026 Azazel Labs LLC. Rilasciato con licenza [MIT-0](../../LICENSE). Tailnet Link non è realizzato da Tailscale Inc. né affiliato a essa. Tailscale è un marchio di Tailscale Inc.
