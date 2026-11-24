# Tailnet Link

[![CI](https://github.com/Azazel-Labs/tailnet-link/actions/workflows/ci.yml/badge.svg)](https://github.com/Azazel-Labs/tailnet-link/actions/workflows/ci.yml)
[![Release](https://img.shields.io/github/v/release/Azazel-Labs/tailnet-link)](https://github.com/Azazel-Labs/tailnet-link/releases)
[![License: MIT-0](https://img.shields.io/badge/license-MIT--0-blue.svg)](../../LICENSE)
[![Rust: 1.95+](https://img.shields.io/badge/rust-1.95%2B-orange.svg)](../../Cargo.toml)
[![Edition: 2024](https://img.shields.io/badge/edition-2024-orange.svg)](../../Cargo.toml)
[![Platforms](https://img.shields.io/badge/platforms-Windows%20%7C%20macOS%20%7C%20Linux-lightgrey.svg)](../../README.md#download)

[English](../../README.md) · [Afrikaans](README.af.md) · [Català](README.ca.md) · [Čeština](README.cs.md) · [Dansk](README.da.md) · [Deutsch](README.de.md) · [Ελληνικά](README.el.md) · [Español (Latinoamérica)](README.es-419.md) · [Español (España)](README.es-ES.md) · [Suomi](README.fi.md) · [Français](README.fr.md) · [Magyar](README.hu.md) · [Bahasa Indonesia](README.id.md) · [Italiano](README.it.md) · [日本語](README.ja.md) · 한국어 · [Norsk bokmål](README.nb.md) · [Nederlands](README.nl.md) · [Polski](README.pl.md) · [Português (Brasil)](README.pt-BR.md) · [Português (Portugal)](README.pt-PT.md) · [Română](README.ro.md) · [Русский](README.ru.md) · [Српски](README.sr-Cyrl.md) · [Svenska](README.sv.md) · [ไทย](README.th.md) · [Türkçe](README.tr.md) · [Українська](README.uk.md) · [Tiếng Việt](README.vi.md) · [简体中文](README.zh-Hans.md) · [繁體中文](README.zh-Hant.md)

![Tailnet Link](../images/hero.svg)

**내 tailnet에 그대로 머문 채, 다른 모든 tailnet의 머신에도 동시에 접속하세요.**

Tailscale에서는 한 번에 하나의 tailnet에만 로그인할 수 있습니다. 홈 랩, 회사, 고객사가 각자 tailnet을 쓰고 있다면 계정을 계속 바꿔야 하고, 그때마다 연결돼 있던 것이 끊깁니다. Tailnet Link가 이 번거로움을 없애 줍니다. Tailscale 앱은 지금 그대로 두고, Tailnet Link가 다른 tailnet을 조용히 옆에 추가하므로 `https://wiki.comet-bebop.ts.net/`도 `build-pc.capybara-iguana.ts.net`도 그냥 열립니다.

Windows, macOS, Linux용 **[최신 릴리스 다운로드](https://github.com/Azazel-Labs/tailnet-link/releases/latest)**. 무료 오픈 소스입니다.

![Tailnet 탭: 두 tailnet이 라우팅 중이고 각 머신이 나열된 모습](../images/tailnets.png)

*스크린샷의 tailnet은 가상의 것으로, 이름과 주소는 모두 지어낸 것입니다.*

## Tailnet Link를 써야 하는 이유

- **더 이상 계정을 바꿀 필요가 없습니다.** 필요한 만큼 tailnet을 추가해 한꺼번에 사용하세요. 내 tailnet은 절대 끊기지 않습니다.
- **설정할 것이 없습니다.** 로그인만 하면 tailnet의 도메인을 알아서 찾아 줍니다. 어느 브라우저에서든 이름으로 머신을 열 수 있습니다.
- **머신의 웹사이트를 찾아 줍니다.** HTTPS 페이지를 제공하는 머신이 페이지 이름과 아이콘과 함께 목록에 표시되어 클릭 한 번으로 열 수 있습니다. 자주 쓰는 곳에 별표를 표시하면 페이지 그림이 있는 타일이 됩니다. 각 머신은 하루에 한 번까지만 확인합니다.
- **Tailscale과 충돌하지 않습니다.** VPN 어댑터도, 경로도, DNS 변경도 없습니다. 추가한 tailnet은 각각 앱 안의 독립된 노드로 실행되므로 Tailscale 앱과도, 서로 간에도 부딪히지 않습니다.
- **기본적으로 안전합니다.** 추가 노드는 모두 Shields Up 상태로 참여합니다. 내가 그 tailnet에 접속할 수는 있어도, 그쪽에서 내 컴퓨터로는 접속할 수 없습니다.
- **해당 트래픽만 거칩니다.** 다른 tailnet의 주소만 Tailnet Link를 거치고, 나머지는 예전처럼 직접 연결됩니다.
- **프록시를 무시하는 앱도 지원합니다.** 원격 데스크톱, SSH, 데이터베이스 클라이언트에 머신으로 이어지는 로컬 포트를 클릭 한 번으로 만들어 줍니다.
- **터미널에서도 쓸 수 있습니다.** curl, git, ssh, ping 앞에 `tl`을 붙이거나, `tl`만 실행하면 tailnet 이름을 쓸 수 있는 셸이 열립니다.
- **뒷정리도 알아서 합니다.** 시스템 프록시 설정은 라우팅하는 동안에만 켜지고, 종료, 일시 중지, 비정상 종료, 정전 후에는 원래대로 돌아옵니다.
- **한국어를 지원합니다.** 인터페이스가 31개 언어로 번역되어 있습니다.

## 작동 방식

1. **tailnet을 추가합니다.** Tailscale 앱과 마찬가지로 Tailscale의 로그인 페이지가 브라우저에서 열립니다.
2. **도메인은 자동으로 감지됩니다.** 로그인하면 Tailnet Link가 tailnet의 MagicDNS 이름(예: `capybara-iguana.ts.net`)을 읽고 `*.capybara-iguana.ts.net`을 그 tailnet으로 라우팅합니다.
3. **머신을 엽니다.** 브라우저에 이름을 입력하거나, 목록에서 머신을 골라 열거나, 주소를 복사하거나, 포트를 포워딩하세요.

## 프록시를 무시하는 앱

브라우저와 대부분의 도구는 시스템 프록시 설정을 따르지만, 원격 데스크톱이나 데이터베이스 클라이언트 같은 앱은 그렇지 않습니다. 이럴 때는 머신 옆의 플러그 버튼을 클릭하고 포트를 고르세요. 빈 로컬 포트가 선택되어 고정되며, `127.0.0.1:<port>`로 접속하면 됩니다. Windows에서는 원격 데스크톱 포워딩에 전용 **원격 데스크톱 열기** 버튼이 생깁니다.

![원격 데스크톱을 포워딩한 뒤의 대화 상자: 복사할 로컬 주소와 원격 데스크톱을 여는 버튼](../images/forward.png)

## 터미널에서

명령줄 도구는 시스템 프록시 설정을 읽지 않습니다. 앱과 함께 설치되는 `tl`을 명령 앞에 붙이거나, `tl`만 실행하면 tailnet 이름을 쓸 수 있는 셸이 열립니다. **Tailnet** 탭의 터미널 버튼으로도 이 셸을 열 수 있습니다.

```sh
tl curl http://wiki.capybara-iguana.ts.net/
tl ssh admin@build-pc.capybara-iguana.ts.net
tl ping build-pc.capybara-iguana.ts.net
```

curl, git, npm, pip 등 대부분의 도구가 이렇게 작동하며, ssh, scp, sftp도 마찬가지입니다. `tl ping`은 Tailscale 자체 ping을 사용합니다. 자세한 내용은 [영어 README](../../README.md#in-a-terminal-tl)를 참고하세요.

## 지원 플랫폼과 다운로드

Windows, macOS(메뉴 막대), Linux(GNOME 및 KDE)를 지원합니다. [최신 릴리스](https://github.com/Azazel-Labs/tailnet-link/releases/latest)에서 Windows는 `tailnet-link-windows-setup.exe`, Mac은 `tailnet-link-macos-universal.dmg`(Apple Silicon 및 Intel), Ubuntu / Debian은 `tailnet-link-linux-amd64.deb`(`sudo apt install ./tailnet-link-linux-amd64.deb`)를 받으세요. 설치 프로그램 없이 실행하는 버전도 있습니다.

**코드 서명이 되어 있지 않습니다.** Windows에서 SmartScreen 경고가 나오면 **추가 정보 → 실행**을 선택하세요. macOS에서는 처음 실행할 때 앱을 오른쪽 클릭하고 **열기**를 선택하세요.

---

자세한 내용(프록시 설정 처리 방식, Windows 설치 프로그램의 동작, 파일 위치 등)은 [영어 README](../../README.md)를 참고하세요. 번역 개선은 [docs/translations.md](../../docs/translations.md)를 통해 언제든 환영합니다.

Copyright © 2026 Azazel Labs LLC. [MIT-0](../../LICENSE)로 배포됩니다. Tailnet Link는 Tailscale Inc.가 만들지 않았으며 Tailscale Inc.와 관련이 없습니다. Tailscale은 Tailscale Inc.의 상표입니다.
