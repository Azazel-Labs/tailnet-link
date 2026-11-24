# Tailnet Link

[![CI](https://github.com/Azazel-Labs/tailnet-link/actions/workflows/ci.yml/badge.svg)](https://github.com/Azazel-Labs/tailnet-link/actions/workflows/ci.yml)
[![Release](https://img.shields.io/github/v/release/Azazel-Labs/tailnet-link)](https://github.com/Azazel-Labs/tailnet-link/releases)
[![License: MIT-0](https://img.shields.io/badge/license-MIT--0-blue.svg)](../../LICENSE)
[![Rust: 1.95+](https://img.shields.io/badge/rust-1.95%2B-orange.svg)](../../Cargo.toml)
[![Edition: 2024](https://img.shields.io/badge/edition-2024-orange.svg)](../../Cargo.toml)
[![Platforms](https://img.shields.io/badge/platforms-Windows%20%7C%20macOS%20%7C%20Linux-lightgrey.svg)](../../README.md#download)

[English](../../README.md) · [Afrikaans](README.af.md) · [Català](README.ca.md) · Čeština · [Dansk](README.da.md) · [Deutsch](README.de.md) · [Ελληνικά](README.el.md) · [Español (Latinoamérica)](README.es-419.md) · [Español (España)](README.es-ES.md) · [Suomi](README.fi.md) · [Français](README.fr.md) · [Magyar](README.hu.md) · [Bahasa Indonesia](README.id.md) · [Italiano](README.it.md) · [日本語](README.ja.md) · [한국어](README.ko.md) · [Norsk bokmål](README.nb.md) · [Nederlands](README.nl.md) · [Polski](README.pl.md) · [Português (Brasil)](README.pt-BR.md) · [Português (Portugal)](README.pt-PT.md) · [Română](README.ro.md) · [Русский](README.ru.md) · [Српски](README.sr-Cyrl.md) · [Svenska](README.sv.md) · [ไทย](README.th.md) · [Türkçe](README.tr.md) · [Українська](README.uk.md) · [Tiếng Việt](README.vi.md) · [简体中文](README.zh-Hans.md) · [繁體中文](README.zh-Hant.md)

![Tailnet Link](../images/hero.svg)

**Zůstaňte ve své síti tailnet. A zároveň se dostaňte k zařízením ve všech ostatních.**

Tailscale vám dovolí být přihlášeni jen k jedné síti tailnet najednou. Pokud má vlastní síť vaše domácí laboratoř, firma i klient, neustále přepínáte účty a všechno, k čemu jste byli připojeni, spadne. Tailnet Link tomu dělá konec. Aplikace Tailscale zůstane přesně tam, kde je, a Tailnet Link vedle ní nenápadně přidá ostatní sítě tailnet, takže `https://wiki.comet-bebop.ts.net/` i `build-pc.capybara-iguana.ts.net` se prostě otevřou.

**[Stáhněte si nejnovější vydání](https://github.com/Azazel-Labs/tailnet-link/releases/latest)** pro Windows, macOS nebo Linux. Je zdarma a s otevřeným zdrojovým kódem.

![Tailnet Link](../images/tailnets.png)

*Snímky obrazovky používají smyšlené sítě tailnet; všechny názvy a adresy jsou vymyšlené.*

## Proč Tailnet Link

- **Žádné přepínání účtů.** Přidejte tolik sítí tailnet, kolik potřebujete, a používejte je všechny najednou. Vaše vlastní síť tailnet se nikdy neodpojí.
- **Nic se nenastavuje.** Přihlaste se a doména sítě tailnet se najde sama. Její zařízení otevírejte podle názvu v libovolném prohlížeči.
- **Najde weby na vašich zařízeních.** Zařízení, která poskytují stránku přes HTTPS, se zobrazí v seznamu s názvem a ikonou stránky, na jedno kliknutí. Ty, které používáte, označte hvězdičkou a stanou se z nich dlaždice s náhledem stránky. Každé zařízení se kontroluje nejvýše jednou denně.
- **Nepřekáží aplikaci Tailscale.** Žádný VPN adaptér, žádné trasy ani změny DNS. Každá další síť tailnet běží jako samostatný uzel uvnitř aplikace, takže nic nekoliduje s aplikací Tailscale ani navzájem.
- **Ve výchozím stavu uzamčeno.** Každý další uzel se připojuje se zapnutou volbou Shields Up: vy se k těmto sítím tailnet dostanete, ale nic z nich se nedostane k vašemu počítači.
- **Prochází jím jen jejich provoz.** Adresy v ostatních sítích tailnet jdou přes Tailnet Link. Vše ostatní jde napřímo, přesně jako dřív.
- **Funguje s aplikacemi, které ignorují proxy.** Vzdálená plocha, SSH a databázoví klienti jedním kliknutím získají místní port, který vede k zařízení.
- **Funguje i v terminálu.** Napište `tl` před curl, git, ssh nebo ping, nebo spusťte samotné `tl` a získáte shell, ve kterém fungují názvy z vašich sítí tailnet.
- **Uklízí po sobě.** Systémové nastavení proxy je zapnuté jen tehdy, když se něco směruje, a obnoví se při ukončení, pozastavení, pádu i výpadku proudu.
- **Mluví vaším jazykem.** Rozhraní je přeloženo do 31 jazyků.

## Jak to funguje

1. **Přidejte síť tailnet.** V prohlížeči se otevře přihlašovací stránka Tailscale, stejně jako u aplikace Tailscale.
2. **Doména se zjistí automaticky.** Po přihlášení Tailnet Link načte název MagicDNS sítě tailnet (například `capybara-iguana.ts.net`) a směruje přes ni `*.capybara-iguana.ts.net`.
3. **Otevírejte její zařízení.** Napište název do prohlížeče nebo vyberte zařízení ze seznamu, abyste ho otevřeli, zkopírovali jeho adresu nebo na něj přesměrovali port.

Pod kapotou běží pro každou síť tailnet samostatný uzel Tailscale, jeden místní port obsluhuje všechny a systémové nastavení proxy ukazuje na soubor PAC jen s doménami těchto sítí. HTTPS funguje end-to-end se skutečnými certifikáty.

## Aplikace, které ignorují proxy

Prohlížeče a většina nástrojů se řídí systémovým nastavením proxy, Vzdálená plocha, databázoví klienti a podobné aplikace ale ne. Pro ně klikněte na tlačítko se zástrčkou u zařízení a vyberte port: zvolí se a zachová volný místní port a vy se připojíte k `127.0.0.1:<port>`. Ve Windows mají přesměrování pro Vzdálenou plochu vlastní tlačítko **Otevřít Vzdálenou plochu**.

![Tailnet Link](../images/forward.png)

## V terminálu

Nástroje příkazového řádku systémové nastavení proxy nečtou. Napište `tl`, který se instaluje spolu s aplikací, před příkaz, nebo spusťte samotné `tl` a získáte shell, ve kterém fungují názvy z vašich sítí tailnet. Takový shell otevře i tlačítko terminálu na kartě **Sítě tailnet**.

```sh
tl curl http://wiki.capybara-iguana.ts.net/
tl ssh admin@build-pc.capybara-iguana.ts.net
tl ping build-pc.capybara-iguana.ts.net
```

Takto fungují curl, git, npm, pip i většina dalších nástrojů a také ssh, scp a sftp. `tl ping` používá vlastní ping služby Tailscale. Podrobnosti najdete v [anglickém README](../../README.md#in-a-terminal-tl).

## Platformy a stažení

Tailnet Link funguje ve Windows, macOS (na řádku nabídek) a Linuxu (GNOME s rozšířením AppIndicator nebo KDE). V [nejnovějším vydání](https://github.com/Azazel-Labs/tailnet-link/releases/latest) najdete `tailnet-link-windows-setup.exe` jako instalátor pro Windows, `tailnet-link-macos-universal.dmg` pro Mac (Apple Silicon i Intel) a `tailnet-link-linux-amd64.deb` pro Ubuntu a Debian (`sudo apt install ./tailnet-link-linux-amd64.deb`). Kontrolní součty všech souborů jsou v `SHA256SUMS.txt`.

**Kód není podepsaný.** Ve Windows v upozornění SmartScreen zvolte **Další informace → Přesto spustit**. V macOS při prvním spuštění klikněte na aplikaci pravým tlačítkem a zvolte **Otevřít**.

## Další informace

Úplný popis, včetně vnitřního fungování, obnovování nastavení proxy a instalátoru pro Windows, najdete v [anglickém README](../../README.md). Jak vylepšit překlad, vysvětluje [docs/translations.md](../../docs/translations.md).

Copyright © 2026 Azazel Labs LLC. Vydáno pod licencí [MIT-0](../../LICENSE). Tailnet Link nevytváří společnost Tailscale Inc. a není s ní nijak spojen. Tailscale je ochranná známka společnosti Tailscale Inc.
