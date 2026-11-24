# Tailnet Link

[![CI](https://github.com/Azazel-Labs/tailnet-link/actions/workflows/ci.yml/badge.svg)](https://github.com/Azazel-Labs/tailnet-link/actions/workflows/ci.yml)
[![Release](https://img.shields.io/github/v/release/Azazel-Labs/tailnet-link)](https://github.com/Azazel-Labs/tailnet-link/releases)
[![License: MIT-0](https://img.shields.io/badge/license-MIT--0-blue.svg)](../../LICENSE)
[![Rust: 1.95+](https://img.shields.io/badge/rust-1.95%2B-orange.svg)](../../Cargo.toml)
[![Edition: 2024](https://img.shields.io/badge/edition-2024-orange.svg)](../../Cargo.toml)
[![Platforms](https://img.shields.io/badge/platforms-Windows%20%7C%20macOS%20%7C%20Linux-lightgrey.svg)](../../README.md#download)

[English](../../README.md) · [Afrikaans](README.af.md) · [Català](README.ca.md) · [Čeština](README.cs.md) · [Dansk](README.da.md) · [Deutsch](README.de.md) · [Ελληνικά](README.el.md) · [Español (Latinoamérica)](README.es-419.md) · [Español (España)](README.es-ES.md) · [Suomi](README.fi.md) · [Français](README.fr.md) · [Magyar](README.hu.md) · [Bahasa Indonesia](README.id.md) · [Italiano](README.it.md) · [日本語](README.ja.md) · [한국어](README.ko.md) · [Norsk bokmål](README.nb.md) · [Nederlands](README.nl.md) · [Polski](README.pl.md) · [Português (Brasil)](README.pt-BR.md) · [Português (Portugal)](README.pt-PT.md) · Română · [Русский](README.ru.md) · [Српски](README.sr-Cyrl.md) · [Svenska](README.sv.md) · [ไทย](README.th.md) · [Türkçe](README.tr.md) · [Українська](README.uk.md) · [Tiếng Việt](README.vi.md) · [简体中文](README.zh-Hans.md) · [繁體中文](README.zh-Hant.md)

![Tailnet Link](../images/hero.svg)

**Rămâi în propriul tailnet. Ajungi la mașinile din toate celelalte, în același timp.**

Tailscale te lasă să fii autentificat într-un singur tailnet odată. Dacă laboratorul de acasă, compania și un client au fiecare tailnetul lor, schimbi mereu conturile, iar tot ce era conectat se întrerupe. Tailnet Link pune capăt acestui lucru. Aplicația Tailscale rămâne exact unde este, iar Tailnet Link adaugă discret celelalte tailneturi alături, astfel încât `https://wiki.comet-bebop.ts.net/` și `build-pc.capybara-iguana.ts.net` se deschid pur și simplu.

**[Descarcă cea mai recentă versiune](https://github.com/Azazel-Labs/tailnet-link/releases/latest)** pentru Windows, macOS sau Linux. Este gratuită și open source.

![Tailnet Link](../images/tailnets.png)

*Capturile de ecran folosesc tailneturi inventate; toate numele și adresele din ele sunt fictive.*

## De ce Tailnet Link

- **Gata cu schimbatul conturilor.** Adaugă câte tailneturi ai nevoie și folosește-le pe toate deodată. Propriul tailnet nu se deconectează niciodată.
- **Nimic de configurat.** Autentifică-te, iar domeniul tailnetului este găsit pentru tine. Deschide-i mașinile după nume în orice browser.
- **Găsește site-urile de pe mașinile tale.** Mașinile care servesc o pagină HTTPS apar într-o listă cu numele și pictograma paginii, la un clic distanță. Marchează cu stea site-urile pe care le folosești și devin plăci cu o imagine a paginii. Fiecare mașină este verificată cel mult o dată pe zi.
- **Nu se bate cap în cap cu Tailscale.** Fără adaptor VPN, fără rute, fără modificări DNS. Fiecare tailnet suplimentar rulează ca nod separat în aplicație, așa că nimic nu intră în conflict cu aplicația Tailscale sau între ele.
- **Blocat implicit.** Fiecare nod suplimentar intră cu scuturile ridicate: tu ajungi la acele tailneturi, dar nimic din ele nu poate ajunge la computerul tău.
- **Doar traficul lor trece prin el.** Adresele din celelalte tailneturi trec prin Tailnet Link. Restul merge direct, exact ca înainte.
- **Funcționează cu aplicațiile care ignoră proxyul.** Desktop la distanță, SSH și clienții de baze de date primesc dintr-un clic un port local care duce la mașină.
- **Funcționează și în terminal.** Pune `tl` în fața lui curl, git, ssh sau ping, sau rulează doar `tl` pentru un shell în care funcționează numele din tailneturile tale.
- **Face ordine după el.** Setarea proxy a sistemului este activă doar cât timp ceva rutează și este restabilită la ieșire, la întrerupere, la blocare sau la o pană de curent.
- **Vorbește limba ta.** Interfața este tradusă în 31 de limbi.

## Cum funcționează

1. **Adaugă un tailnet.** Pagina de autentificare Tailscale se deschide în browser, la fel ca în aplicația Tailscale.
2. **Domeniul este preluat automat.** După autentificare, Tailnet Link citește numele MagicDNS al tailnetului (de exemplu `capybara-iguana.ts.net`) și rutează `*.capybara-iguana.ts.net` prin el.
3. **Deschide-i mașinile.** Tastează un nume în browser sau alege o mașină din listă ca s-o deschizi, să-i copiezi adresa sau să-i redirecționezi un port.

## Aplicații care ignoră proxyul

Browserele și majoritatea instrumentelor respectă setarea proxy a sistemului. Desktop la distanță, clienții de baze de date și aplicațiile similare, nu. Pentru acestea, dă clic pe butonul cu ștecher de lângă o mașină și alege un port: se alege și se păstrează un port local liber, iar tu te conectezi la `127.0.0.1:<port>`. Pe Windows, redirecționările pentru Desktop la distanță au propriul buton **Deschide Desktop la distanță**.

![Tailnet Link](../images/forward.png)

## Într-un terminal

Instrumentele din linia de comandă nu citesc setarea proxy a sistemului. Pune `tl`, instalat odată cu aplicația, în fața unei comenzi, sau rulează doar `tl` pentru un shell în care funcționează numele din tailneturile tale. Butonul de terminal din fila **Tailneturi** deschide unul.

```sh
tl curl http://wiki.capybara-iguana.ts.net/
tl ssh admin@build-pc.capybara-iguana.ts.net
tl ping build-pc.capybara-iguana.ts.net
```

curl, git, npm, pip și majoritatea celorlalte instrumente funcționează așa, la fel și ssh, scp și sftp. `tl ping` folosește ping-ul propriu al Tailscale. Detaliile se află în [README-ul în engleză](../../README.md#in-a-terminal-tl).

## Platforme și descărcare

Tailnet Link funcționează pe Windows, macOS (în bara de meniu) și Linux (GNOME cu extensia AppIndicator sau KDE). Pe Windows rulează **`tailnet-link-windows-setup.exe`**, pe Mac deschide **`tailnet-link-macos-universal.dmg`** (Apple Silicon și Intel), iar pe Ubuntu sau Debian rulează `sudo apt install ./tailnet-link-linux-amd64.deb`. Există și versiuni fără program de instalare, iar `SHA256SUMS.txt` conține sumele de control.

**Fără semnătură de cod.** Pe Windows, la avertismentul SmartScreen, alege **Mai multe informații → Rulează oricum**. Pe macOS, prima dată dă clic dreapta pe aplicație și alege **Deschide**.

## Află mai multe

Detaliile (cum funcționează în spate, proxyul de sistem, programul de instalare pentru Windows, fișiere, contribuții) se află în [README-ul în engleză](../../README.md). Pentru a îmbunătăți o traducere, vezi [docs/translations.md](../../docs/translations.md).

Copyright © 2026 Azazel Labs LLC. Publicat sub licența [MIT-0](../../LICENSE). Tailnet Link nu este creat de Tailscale Inc. și nu este afiliat cu aceasta. Tailscale este o marcă comercială a Tailscale Inc.
