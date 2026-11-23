# Tailnet Link

[![CI](https://github.com/Azazel-Labs/tailnet-link/actions/workflows/ci.yml/badge.svg)](https://github.com/Azazel-Labs/tailnet-link/actions/workflows/ci.yml)
[![Release](https://img.shields.io/github/v/release/Azazel-Labs/tailnet-link)](https://github.com/Azazel-Labs/tailnet-link/releases)
[![License: MIT-0](https://img.shields.io/badge/license-MIT--0-blue.svg)](../../LICENSE)
[![Rust: 1.95+](https://img.shields.io/badge/rust-1.95%2B-orange.svg)](../../Cargo.toml)
[![Edition: 2024](https://img.shields.io/badge/edition-2024-orange.svg)](../../Cargo.toml)
[![Platforms](https://img.shields.io/badge/platforms-Windows%20%7C%20macOS%20%7C%20Linux-lightgrey.svg)](../../README.md#download)

[English](../../README.md) · [Afrikaans](README.af.md) · [Català](README.ca.md) · [Čeština](README.cs.md) · [Dansk](README.da.md) · [Deutsch](README.de.md) · [Ελληνικά](README.el.md) · [Español (Latinoamérica)](README.es-419.md) · [Español (España)](README.es-ES.md) · [Suomi](README.fi.md) · [Français](README.fr.md) · [Magyar](README.hu.md) · [Bahasa Indonesia](README.id.md) · [Italiano](README.it.md) · [日本語](README.ja.md) · [한국어](README.ko.md) · [Norsk bokmål](README.nb.md) · [Nederlands](README.nl.md) · Polski · [Português (Brasil)](README.pt-BR.md) · [Português (Portugal)](README.pt-PT.md) · [Română](README.ro.md) · [Русский](README.ru.md) · [Српски](README.sr-Cyrl.md) · [Svenska](README.sv.md) · [ไทย](README.th.md) · [Türkçe](README.tr.md) · [Українська](README.uk.md) · [Tiếng Việt](README.vi.md) · [简体中文](README.zh-Hans.md) · [繁體中文](README.zh-Hant.md)

![Tailnet Link](../images/hero.svg)

**Zostań we własnej sieci tailnet. Jednocześnie korzystaj z urządzeń we wszystkich pozostałych.**

Tailscale pozwala być zalogowanym tylko do jednej sieci tailnet naraz. Jeśli domowe laboratorium, firma i klient mają każde swoją, ciągle przełączasz konta, a wszystko, z czym było połączenie, się rozłącza. Tailnet Link kończy z tym. Aplikacja Tailscale zostaje dokładnie tam, gdzie była, a Tailnet Link po cichu dodaje obok pozostałe sieci tailnet, więc zarówno `https://wiki.comet-bebop.ts.net/`, jak i `build-pc.capybara-iguana.ts.net` po prostu się otwierają.

**[Pobierz najnowsze wydanie](https://github.com/Azazel-Labs/tailnet-link/releases/latest)** dla systemu Windows, macOS lub Linux. Za darmo i z otwartym kodem źródłowym.

![Tailnet Link](../images/tailnets.png)

*Zrzuty ekranu przedstawiają fikcyjne sieci tailnet; wszystkie nazwy i adresy są zmyślone.*

## Dlaczego Tailnet Link

- **Koniec z przełączaniem kont.** Dodaj tyle sieci tailnet, ile potrzebujesz, i korzystaj ze wszystkich naraz. Twoja własna sieć tailnet nigdy się nie rozłącza.
- **Nic do konfigurowania.** Zaloguj się, a domena sieci tailnet zostanie znaleziona za Ciebie. Otwieraj jej urządzenia po nazwie w dowolnej przeglądarce.
- **Znajduje witryny na Twoich urządzeniach.** Urządzenia udostępniające stronę przez HTTPS pojawiają się jako kafelki z nazwą i ikoną strony, o jedno kliknięcie. Każde urządzenie jest sprawdzane najwyżej raz dziennie.
- **Nie wchodzi w drogę Tailscale.** Żadnej karty VPN, tras ani zmian DNS. Każda dodatkowa sieć tailnet działa jako osobny węzeł wewnątrz aplikacji, więc nic nie koliduje ani z aplikacją Tailscale, ani ze sobą nawzajem.
- **Domyślnie zabezpieczony.** Każdy dodatkowy węzeł dołącza z włączoną opcją Shields Up: Ty masz dostęp do tych sieci tailnet, a nic z nich nie ma dostępu do Twojego komputera.
- **Przechodzi przez niego tylko ich ruch.** Adresy w pozostałych sieciach tailnet idą przez Tailnet Link. Cała reszta idzie bezpośrednio, dokładnie jak wcześniej.
- **Działa z aplikacjami, które ignorują proxy.** Pulpit zdalny, SSH i klienty baz danych jednym kliknięciem dostają lokalny port prowadzący do urządzenia.
- **Sprząta po sobie.** Systemowe ustawienie proxy jest włączone tylko wtedy, gdy coś przekazuje ruch, i zostaje przywrócone po zamknięciu, wstrzymaniu, awarii lub zaniku zasilania.
- **Mówi Twoim językiem.** Interfejs jest przetłumaczony na 31 języków.

## Jak to działa

1. **Dodaj sieć tailnet.** W przeglądarce otworzy się strona logowania Tailscale, tak samo jak w aplikacji Tailscale.
2. **Domena zostaje wykryta automatycznie.** Po zalogowaniu Tailnet Link odczytuje nazwę MagicDNS sieci tailnet (na przykład `capybara-iguana.ts.net`) i kieruje przez nią ruch do `*.capybara-iguana.ts.net`.
3. **Otwieraj jej urządzenia.** Wpisz nazwę w przeglądarce albo wybierz urządzenie z listy, aby je otworzyć, skopiować jego adres lub przekierować do niego port.

Pod spodem każda sieć tailnet działa jako osobny węzeł Tailscale, jeden lokalny port obsługuje je wszystkie, a systemowe ustawienie proxy wskazuje plik PAC zawierający tylko domeny tych sieci. HTTPS działa end-to-end z prawdziwymi certyfikatami.

## Aplikacje, które ignorują proxy

Przeglądarki i większość narzędzi stosują się do systemowego ustawienia proxy, ale Pulpit zdalny, klienty baz danych i podobne aplikacje nie. Dla nich kliknij przycisk z wtyczką obok urządzenia i wybierz port: wolny port lokalny zostanie wybrany i zachowany, a Ty łączysz się z `127.0.0.1:<port>`. W systemie Windows przekierowania Pulpitu zdalnego mają własny przycisk **Otwórz Pulpit zdalny**.

![Tailnet Link](../images/forward.png)

## Platformy i pobieranie

Tailnet Link działa w systemach Windows, macOS (na pasku menu) i Linux (GNOME z rozszerzeniem AppIndicator lub KDE). W [najnowszym wydaniu](https://github.com/Azazel-Labs/tailnet-link/releases/latest): `tailnet-link-windows-setup.exe` to instalator dla Windows, `tailnet-link-macos-universal.dmg` jest dla Maca (Apple Silicon i Intel), a `tailnet-link-linux-amd64.deb` dla Ubuntu i Debiana (`sudo apt install ./tailnet-link-linux-amd64.deb`). Sumy kontrolne wszystkich plików są w `SHA256SUMS.txt`.

**Kod nie jest podpisany.** W systemie Windows w ostrzeżeniu SmartScreen wybierz **Więcej informacji → Uruchom mimo to**. W systemie macOS przy pierwszym uruchomieniu kliknij aplikację prawym przyciskiem myszy i wybierz **Otwórz**.

## Więcej informacji

Pełny opis, w tym działanie aplikacji od środka, przywracanie ustawienia proxy i instalator dla Windows, znajdziesz w [README po angielsku](../../README.md). Jak poprawić tłumaczenie, wyjaśnia [docs/translations.md](../../docs/translations.md).

Copyright © 2026 Azazel Labs LLC. Udostępniono na licencji [MIT-0](../../LICENSE). Tailnet Link nie jest tworzony przez Tailscale Inc. ani z nią powiązany. Tailscale jest znakiem towarowym Tailscale Inc.
