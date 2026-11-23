# Tailnet Link

[![CI](https://github.com/Azazel-Labs/tailnet-link/actions/workflows/ci.yml/badge.svg)](https://github.com/Azazel-Labs/tailnet-link/actions/workflows/ci.yml)
[![Release](https://img.shields.io/github/v/release/Azazel-Labs/tailnet-link)](https://github.com/Azazel-Labs/tailnet-link/releases)
[![License: MIT-0](https://img.shields.io/badge/license-MIT--0-blue.svg)](../../LICENSE)
[![Rust: 1.95+](https://img.shields.io/badge/rust-1.95%2B-orange.svg)](../../Cargo.toml)
[![Edition: 2024](https://img.shields.io/badge/edition-2024-orange.svg)](../../Cargo.toml)
[![Platforms](https://img.shields.io/badge/platforms-Windows%20%7C%20macOS%20%7C%20Linux-lightgrey.svg)](../../README.md#download)

[English](../../README.md) · [Afrikaans](README.af.md) · [Català](README.ca.md) · [Čeština](README.cs.md) · [Dansk](README.da.md) · [Deutsch](README.de.md) · [Ελληνικά](README.el.md) · [Español (Latinoamérica)](README.es-419.md) · [Español (España)](README.es-ES.md) · [Suomi](README.fi.md) · [Français](README.fr.md) · [Magyar](README.hu.md) · [Bahasa Indonesia](README.id.md) · [Italiano](README.it.md) · [日本語](README.ja.md) · [한국어](README.ko.md) · [Norsk bokmål](README.nb.md) · [Nederlands](README.nl.md) · [Polski](README.pl.md) · [Português (Brasil)](README.pt-BR.md) · [Português (Portugal)](README.pt-PT.md) · [Română](README.ro.md) · [Русский](README.ru.md) · Српски · [Svenska](README.sv.md) · [ไทย](README.th.md) · [Türkçe](README.tr.md) · [Українська](README.uk.md) · [Tiếng Việt](README.vi.md) · [简体中文](README.zh-Hans.md) · [繁體中文](README.zh-Hant.md)

![Tailnet Link](../images/hero.svg)

**Останите на својој мрежи tailnet. Истовремено приступајте уређајима у свим осталим.**

Tailscale вам дозвољава да будете пријављени на само једну мрежу tailnet у исто време. Ако ваша кућна лабораторија, ваша компанија и клијент имају сваки своју, стално мењате налоге, а све на шта сте били повезани се прекида. Tailnet Link томе прави крај. Апликација Tailscale остаје тачно где јесте, а Tailnet Link поред ње тихо додаје остале мреже tailnet, па се и `https://wiki.comet-bebop.ts.net/` и `build-pc.capybara-iguana.ts.net` једноставно отварају.

**[Преузмите најновије издање](https://github.com/Azazel-Labs/tailnet-link/releases/latest)** за Windows, macOS или Linux. Бесплатно је и отвореног кода.

![Tailnet Link](../images/tailnets.png)

*Снимци екрана приказују измишљене мреже tailnet; сва имена и адресе у њима су измишљени.*

## Зашто Tailnet Link

- **Нема више мењања налога.** Додајте онолико мрежа tailnet колико вам треба и користите их све одједном. Ваша сопствена мрежа tailnet се никада не прекида.
- **Ништа не треба подешавати.** Пријавите се и домен мреже tailnet ће бити пронађен уместо вас. Отварајте њене уређаје по имену у било ком прегледачу.
- **Проналази веб-сајтове на вашим уређајима.** Уређаји који служе HTTPS страницу приказују се као плочице са називом и иконом странице, на један клик. Сваки уређај се проверава највише једном дневно.
- **Не смета апликацији Tailscale.** Нема VPN адаптера, рута ни измена DNS-а. Свака додатна мрежа tailnet ради као засебан чвор унутар апликације, па се ништа не сукобљава ни са апликацијом Tailscale ни међусобно.
- **Подразумевано закључано.** Сваки додатни чвор се придружује са укљученом опцијом Shields Up: ви можете да приступите тим мрежама tailnet, а ништа из њих не може да приступи вашем рачунару.
- **Кроз апликацију иде само њихов саобраћај.** Адресе у другим мрежама tailnet иду кроз Tailnet Link. Све остало иде директно, као и раније.
- **Ради са апликацијама које занемарују прокси.** Удаљена радна површина, SSH и клијенти база података једним кликом добијају локални порт који води до уређаја.
- **Распрема за собом.** Системско подешавање проксија је укључено само док нешто рутира и враћа се при изласку, паузи, паду или нестанку струје.
- **Говори вашим језиком.** Интерфејс је преведен на 31 језик.

## Како ради

1. **Додајте мрежу tailnet.** Страница за пријаву на Tailscale отвара се у прегледачу, исто као код апликације Tailscale.
2. **Домен се препознаје аутоматски.** Након пријаве Tailnet Link чита MagicDNS име мреже tailnet (на пример `capybara-iguana.ts.net`) и кроз њу рутира `*.capybara-iguana.ts.net`.
3. **Отварајте њене уређаје.** Укуцајте име у прегледач или изаберите уређај са листе да бисте га отворили, копирали његову адресу или проследили порт ка њему.

У позадини, за сваку мрежу tailnet ради засебан Tailscale чвор, један локални порт опслужује све њих, а системско подешавање проксија показује на PAC датотеку са доменима само тих мрежа. HTTPS ради с краја на крај, са правим сертификатима.

## Апликације које занемарују прокси

Прегледачи и већина алата прате системско подешавање проксија, а Удаљена радна површина, клијенти база података и сличне апликације не. За њих кликните на дугме са утикачем поред уређаја и изаберите порт: слободан локални порт се бира и задржава, а ви се повезујете на `127.0.0.1:<port>`. На систему Windows прослеђивања за Удаљену радну површину имају сопствено дугме **Отвори удаљену радну површину**.

![Tailnet Link](../images/forward.png)

## Платформе и преузимање

Tailnet Link ради на системима Windows, macOS (на траци менија) и Linux (GNOME са проширењем AppIndicator или KDE). У [најновијем издању](https://github.com/Azazel-Labs/tailnet-link/releases/latest): `tailnet-link-windows-setup.exe` је инсталатер за Windows, `tailnet-link-macos-universal.dmg` је за Mac (Apple Silicon и Intel), а `tailnet-link-linux-amd64.deb` за Ubuntu и Debian (`sudo apt install ./tailnet-link-linux-amd64.deb`). Контролни збирови свих датотека налазе се у `SHA256SUMS.txt`.

**Код није потписан.** На систему Windows, у упозорењу SmartScreen изаберите **Више информација → Ипак покрени**. На систему macOS, први пут кликните десним тастером на апликацију и изаберите **Отвори**.

## Више информација

Комплетан опис, укључујући унутрашњи рад, враћање подешавања проксија и инсталатер за Windows, налази се у [README-у на енглеском](../../README.md). Како да побољшате превод, објашњава [docs/translations.md](../../docs/translations.md).

Copyright © 2026 Azazel Labs LLC. Објављено под лиценцом [MIT-0](../../LICENSE). Tailnet Link није направила компанија Tailscale Inc. нити је с њом повезан. Tailscale је жиг компаније Tailscale Inc.
