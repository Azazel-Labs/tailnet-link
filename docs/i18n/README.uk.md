# Tailnet Link

[![CI](https://github.com/Azazel-Labs/tailnet-link/actions/workflows/ci.yml/badge.svg)](https://github.com/Azazel-Labs/tailnet-link/actions/workflows/ci.yml)
[![Release](https://img.shields.io/github/v/release/Azazel-Labs/tailnet-link)](https://github.com/Azazel-Labs/tailnet-link/releases)
[![License: MIT-0](https://img.shields.io/badge/license-MIT--0-blue.svg)](../../LICENSE)
[![Rust: 1.95+](https://img.shields.io/badge/rust-1.95%2B-orange.svg)](../../Cargo.toml)
[![Edition: 2024](https://img.shields.io/badge/edition-2024-orange.svg)](../../Cargo.toml)
[![Platforms](https://img.shields.io/badge/platforms-Windows%20%7C%20macOS%20%7C%20Linux-lightgrey.svg)](../../README.md#download)

[English](../../README.md) · [Afrikaans](README.af.md) · [Català](README.ca.md) · [Čeština](README.cs.md) · [Dansk](README.da.md) · [Deutsch](README.de.md) · [Ελληνικά](README.el.md) · [Español (Latinoamérica)](README.es-419.md) · [Español (España)](README.es-ES.md) · [Suomi](README.fi.md) · [Français](README.fr.md) · [Magyar](README.hu.md) · [Bahasa Indonesia](README.id.md) · [Italiano](README.it.md) · [日本語](README.ja.md) · [한국어](README.ko.md) · [Norsk bokmål](README.nb.md) · [Nederlands](README.nl.md) · [Polski](README.pl.md) · [Português (Brasil)](README.pt-BR.md) · [Português (Portugal)](README.pt-PT.md) · [Română](README.ro.md) · [Русский](README.ru.md) · [Српски](README.sr-Cyrl.md) · [Svenska](README.sv.md) · [ไทย](README.th.md) · [Türkçe](README.tr.md) · Українська · [Tiếng Việt](README.vi.md) · [简体中文](README.zh-Hans.md) · [繁體中文](README.zh-Hant.md)

![Tailnet Link](../images/hero.svg)

**Залишайтеся у своїй мережі tailnet і водночас відкривайте пристрої в усіх інших.**

Tailscale дає змогу бути в одній мережі tailnet одночасно. Якщо власна мережа є у домашньої лабораторії, у компанії та в клієнта, доводиться постійно перемикати облікові записи, і все, до чого ви були підключені, обривається. Tailnet Link розв’язує цю проблему. Застосунок Tailscale лишається там, де був, а Tailnet Link непомітно додає поруч інші мережі tailnet, тож і `https://wiki.comet-bebop.ts.net/`, і `build-pc.capybara-iguana.ts.net` просто відкриваються.

**[Завантажте останній випуск](https://github.com/Azazel-Labs/tailnet-link/releases/latest)** для Windows, macOS або Linux. Безкоштовно і з відкритим кодом.

![Tailnet Link](../images/tailnets.png)

*На знімках екрана показано вигадані мережі tailnet; усі назви й адреси в них вигадані.*

## Чому Tailnet Link

- **Жодного перемикання облікових записів.** Додайте стільки мереж tailnet, скільки потрібно, і користуйтеся всіма одразу. Ваша власна мережа tailnet ніколи не від’єднується.
- **Нічого не треба налаштовувати.** Увійдіть — і домен мережі tailnet визначиться сам. Відкривайте її пристрої за назвою в будь-якому браузері.
- **Знаходить сайти на ваших пристроях.** Пристрої, що віддають HTTPS-сторінку, показуються плитками з назвою та значком сторінки й відкриваються одним клацанням. Кожен пристрій перевіряється не частіше ніж раз на день.
- **Не заважає Tailscale.** Жодних VPN-адаптерів, маршрутів чи змін DNS. Кожна додаткова мережа tailnet працює як окремий вузол усередині застосунку, тож ніщо не конфліктує ні із застосунком Tailscale, ні між собою.
- **Захищено за замовчуванням.** Кожен додатковий вузол приєднується в режимі Shields Up: ви можете звертатися до цих мереж tailnet, а з них до вашого комп’ютера ніхто не дістанеться.
- **Через застосунок іде лише їхній трафік.** Адреси в інших мережах tailnet ідуть через Tailnet Link, усе інше — напряму, як і раніше.
- **Працює із застосунками, що ігнорують проксі.** Віддалений робочий стіл, SSH і клієнти баз даних одним клацанням отримують локальний порт, що веде до потрібного пристрою.
- **Працює і в терміналі.** Поставте `tl` перед curl, git, ssh або ping чи запустіть `tl` без аргументів, щоб отримати оболонку, у якій працюють імена з ваших мереж tailnet.
- **Прибирає по собі.** Системний проксі ввімкнено, лише поки триває маршрутизація, і його буде відновлено після виходу, паузи, збою чи вимкнення живлення.
- **Розмовляє вашою мовою.** Інтерфейс перекладено 31 мовою.

## Як це працює

1. **Додайте мережу tailnet.** У браузері відкриється сторінка входу Tailscale — так само, як у застосунку Tailscale.
2. **Домен визначається автоматично.** Після входу Tailnet Link зчитує ім’я MagicDNS цієї мережі tailnet (наприклад, `capybara-iguana.ts.net`) і спрямовує через неї `*.capybara-iguana.ts.net`.
3. **Відкривайте її пристрої.** Введіть назву в браузері або виберіть пристрій у списку, щоб відкрити його, скопіювати адресу чи переадресувати на нього порт.

Усередині для кожної мережі tailnet працює окремий вузол Tailscale, один локальний порт обслуговує їх усі, а системний проксі вказує на PAC-файл лише з доменами цих мереж. HTTPS працює наскрізно зі справжніми сертифікатами.

## Застосунки, що ігнорують проксі

Браузери й більшість інструментів дотримуються системного налаштування проксі, а віддалений робочий стіл, клієнти баз даних і подібні застосунки — ні. Для них натисніть кнопку з вилкою біля пристрою й виберіть порт: вільний локальний порт буде вибрано й закріплено, і ви підключаєтеся до `127.0.0.1:<port>`. У Windows для переадресації віддаленого робочого стола є окрема кнопка **Відкрити віддалений робочий стіл**.

![Tailnet Link](../images/forward.png)

## У терміналі

Програми командного рядка не читають системне налаштування проксі. Поставте `tl`, який установлюється разом із застосунком, перед командою або запустіть `tl` без аргументів, щоб отримати оболонку, у якій працюють імена з ваших мереж tailnet. Таку оболонку відкриває й кнопка термінала на вкладці **Мережі tailnet**.

```sh
tl curl http://wiki.capybara-iguana.ts.net/
tl ssh admin@build-pc.capybara-iguana.ts.net
tl ping build-pc.capybara-iguana.ts.net
```

Так працюють curl, git, npm, pip і більшість інших інструментів, а також ssh, scp і sftp. `tl ping` використовує власний ping Tailscale. Подробиці — у [README англійською](../../README.md#in-a-terminal-tl).

## Платформи та завантаження

Tailnet Link працює у Windows, macOS (у рядку меню) і Linux (GNOME з розширенням AppIndicator або KDE). В [останньому випуску](https://github.com/Azazel-Labs/tailnet-link/releases/latest): `tailnet-link-windows-setup.exe` — інсталятор для Windows, `tailnet-link-macos-universal.dmg` — для Mac (Apple Silicon та Intel), `tailnet-link-linux-amd64.deb` — для Ubuntu і Debian (`sudo apt install ./tailnet-link-linux-amd64.deb`). Контрольні суми всіх файлів — у `SHA256SUMS.txt`.

**Код не підписано.** У Windows у попередженні SmartScreen виберіть **Докладніше → Усе одно запустити**. У macOS під час першого запуску клацніть застосунок правою кнопкою миші й виберіть **Відкрити**.

## Докладніше

Повний опис, зокрема будову застосунку, відновлення налаштування проксі та інсталятор для Windows, наведено в [README англійською](../../README.md). Як покращити переклад, розповідає [docs/translations.md](../../docs/translations.md).

Copyright © 2026 Azazel Labs LLC. Поширюється за ліцензією [MIT-0](../../LICENSE). Tailnet Link не створено компанією Tailscale Inc. і не пов’язано з нею. Tailscale — торговельна марка Tailscale Inc.
