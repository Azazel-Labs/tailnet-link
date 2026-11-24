# Tailnet Link

[![CI](https://github.com/Azazel-Labs/tailnet-link/actions/workflows/ci.yml/badge.svg)](https://github.com/Azazel-Labs/tailnet-link/actions/workflows/ci.yml)
[![Release](https://img.shields.io/github/v/release/Azazel-Labs/tailnet-link)](https://github.com/Azazel-Labs/tailnet-link/releases)
[![License: MIT-0](https://img.shields.io/badge/license-MIT--0-blue.svg)](../../LICENSE)
[![Rust: 1.95+](https://img.shields.io/badge/rust-1.95%2B-orange.svg)](../../Cargo.toml)
[![Edition: 2024](https://img.shields.io/badge/edition-2024-orange.svg)](../../Cargo.toml)
[![Platforms](https://img.shields.io/badge/platforms-Windows%20%7C%20macOS%20%7C%20Linux-lightgrey.svg)](../../README.md#download)

[English](../../README.md) · [Afrikaans](README.af.md) · [Català](README.ca.md) · [Čeština](README.cs.md) · [Dansk](README.da.md) · [Deutsch](README.de.md) · [Ελληνικά](README.el.md) · [Español (Latinoamérica)](README.es-419.md) · [Español (España)](README.es-ES.md) · [Suomi](README.fi.md) · [Français](README.fr.md) · [Magyar](README.hu.md) · [Bahasa Indonesia](README.id.md) · [Italiano](README.it.md) · [日本語](README.ja.md) · [한국어](README.ko.md) · [Norsk bokmål](README.nb.md) · [Nederlands](README.nl.md) · [Polski](README.pl.md) · [Português (Brasil)](README.pt-BR.md) · [Português (Portugal)](README.pt-PT.md) · [Română](README.ro.md) · Русский · [Српски](README.sr-Cyrl.md) · [Svenska](README.sv.md) · [ไทย](README.th.md) · [Türkçe](README.tr.md) · [Українська](README.uk.md) · [Tiếng Việt](README.vi.md) · [简体中文](README.zh-Hans.md) · [繁體中文](README.zh-Hant.md)

![Tailnet Link](../images/hero.svg)

**Оставайтесь в своей сети tailnet и одновременно открывайте устройства во всех остальных.**

Tailscale позволяет быть в одной сети tailnet за раз. Если своя сеть есть у домашней лаборатории, у компании и у клиента, приходится постоянно переключать учётные записи, и всё, к чему вы были подключены, обрывается. Tailnet Link решает эту проблему. Приложение Tailscale остаётся там, где было, а Tailnet Link незаметно добавляет рядом остальные сети tailnet, так что и `https://wiki.comet-bebop.ts.net/`, и `build-pc.capybara-iguana.ts.net` просто открываются.

**[Скачайте последний выпуск](https://github.com/Azazel-Labs/tailnet-link/releases/latest)** для Windows, macOS или Linux. Бесплатно и с открытым исходным кодом.

![Tailnet Link](../images/tailnets.png)

*На снимках экрана показаны вымышленные сети tailnet; все имена и адреса в них придуманы.*

## Почему Tailnet Link

- **Никакого переключения учётных записей.** Добавьте столько сетей tailnet, сколько нужно, и пользуйтесь всеми сразу. Ваша собственная сеть tailnet никогда не отключается.
- **Ничего не нужно настраивать.** Войдите — и домен сети tailnet определится сам. Открывайте её устройства по имени в любом браузере.
- **Находит сайты на ваших устройствах.** Устройства, на которых работает HTTPS-страница, показываются в списке с названием и значком страницы и открываются одним щелчком. Отметьте звёздочкой те, которыми пользуетесь, и они станут плитками с изображением страницы. Каждое устройство проверяется не чаще раза в день.
- **Не мешает Tailscale.** Никаких VPN-адаптеров, маршрутов и изменений DNS. Каждая дополнительная сеть tailnet работает как отдельный узел внутри приложения, поэтому ничто не конфликтует ни с приложением Tailscale, ни друг с другом.
- **Защищено по умолчанию.** Каждый дополнительный узел подключается в режиме Shields Up: вы можете обращаться к этим сетям tailnet, а из них до вашего компьютера никто не доберётся.
- **Через приложение идёт только их трафик.** Адреса в других сетях tailnet идут через Tailnet Link, всё остальное — напрямую, как и раньше.
- **Работает с приложениями, игнорирующими прокси.** Удалённый рабочий стол, SSH и клиенты баз данных в один клик получают локальный порт, ведущий к нужному устройству.
- **Работает и в терминале.** Поставьте `tl` перед curl, git, ssh или ping либо запустите `tl` без аргументов, чтобы получить оболочку, в которой работают имена из ваших сетей tailnet.
- **Убирает за собой.** Системный прокси включён, только пока идёт маршрутизация, и восстанавливается при выходе, паузе, сбое или отключении питания.
- **Говорит на вашем языке.** Интерфейс переведён на 31 язык.

## Как это работает

1. **Добавьте сеть tailnet.** В браузере откроется страница входа Tailscale — так же, как в приложении Tailscale.
2. **Домен определяется автоматически.** После входа Tailnet Link считывает имя MagicDNS этой сети tailnet (например, `capybara-iguana.ts.net`) и направляет через неё `*.capybara-iguana.ts.net`.
3. **Открывайте её устройства.** Введите имя в браузере или выберите устройство в списке, чтобы открыть его, скопировать адрес или переадресовать на него порт.

Внутри для каждой сети tailnet работает отдельный узел Tailscale, один локальный порт обслуживает их все, а системный прокси указывает на PAC-файл только с доменами этих сетей. HTTPS работает end-to-end с настоящими сертификатами.

## Приложения, игнорирующие прокси

Браузеры и большинство инструментов следуют системной настройке прокси, а удалённый рабочий стол, клиенты баз данных и похожие приложения — нет. Для них нажмите кнопку с вилкой рядом с устройством и выберите порт: свободный локальный порт будет выбран и закреплён, и вы подключаетесь к `127.0.0.1:<port>`. В Windows для переадресации удалённого рабочего стола есть отдельная кнопка **Открыть удалённый рабочий стол**.

![Tailnet Link](../images/forward.png)

## В терминале

Программы командной строки не читают системную настройку прокси. Поставьте `tl`, который устанавливается вместе с приложением, перед командой либо запустите `tl` без аргументов, чтобы получить оболочку, в которой работают имена из ваших сетей tailnet. Такую оболочку открывает и кнопка терминала на вкладке **Сети tailnet**.

```sh
tl curl http://wiki.capybara-iguana.ts.net/
tl ssh admin@build-pc.capybara-iguana.ts.net
tl ping build-pc.capybara-iguana.ts.net
```

Так работают curl, git, npm, pip и большинство других инструментов, а также ssh, scp и sftp. `tl ping` использует собственный ping Tailscale. Подробности — в [README на английском](../../README.md#in-a-terminal-tl).

## Платформы и загрузка

Tailnet Link работает в Windows, macOS (в строке меню) и Linux (GNOME с расширением AppIndicator или KDE). В [последнем выпуске](https://github.com/Azazel-Labs/tailnet-link/releases/latest): `tailnet-link-windows-setup.exe` — установщик для Windows, `tailnet-link-macos-universal.dmg` — для Mac (Apple Silicon и Intel), `tailnet-link-linux-amd64.deb` — для Ubuntu и Debian (`sudo apt install ./tailnet-link-linux-amd64.deb`). Контрольные суммы всех файлов — в `SHA256SUMS.txt`.

**Код не подписан.** В Windows в предупреждении SmartScreen выберите **Подробнее → Выполнить в любом случае**. В macOS при первом запуске щёлкните приложение правой кнопкой мыши и выберите **Открыть**.

## Подробнее

Полное описание, включая устройство приложения, восстановление настройки прокси и установщик для Windows, — в [README на английском](../../README.md). Как улучшить перевод, рассказано в [docs/translations.md](../../docs/translations.md).

Copyright © 2026 Azazel Labs LLC. Распространяется по лицензии [MIT-0](../../LICENSE). Tailnet Link не создан компанией Tailscale Inc. и не связан с ней. Tailscale — товарный знак Tailscale Inc.
