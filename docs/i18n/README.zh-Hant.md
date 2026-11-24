# Tailnet Link

[![CI](https://github.com/Azazel-Labs/tailnet-link/actions/workflows/ci.yml/badge.svg)](https://github.com/Azazel-Labs/tailnet-link/actions/workflows/ci.yml)
[![Release](https://img.shields.io/github/v/release/Azazel-Labs/tailnet-link)](https://github.com/Azazel-Labs/tailnet-link/releases)
[![License: MIT-0](https://img.shields.io/badge/license-MIT--0-blue.svg)](../../LICENSE)
[![Rust: 1.95+](https://img.shields.io/badge/rust-1.95%2B-orange.svg)](../../Cargo.toml)
[![Edition: 2024](https://img.shields.io/badge/edition-2024-orange.svg)](../../Cargo.toml)
[![Platforms](https://img.shields.io/badge/platforms-Windows%20%7C%20macOS%20%7C%20Linux-lightgrey.svg)](../../README.md#download)

[English](../../README.md) · [Afrikaans](README.af.md) · [Català](README.ca.md) · [Čeština](README.cs.md) · [Dansk](README.da.md) · [Deutsch](README.de.md) · [Ελληνικά](README.el.md) · [Español (Latinoamérica)](README.es-419.md) · [Español (España)](README.es-ES.md) · [Suomi](README.fi.md) · [Français](README.fr.md) · [Magyar](README.hu.md) · [Bahasa Indonesia](README.id.md) · [Italiano](README.it.md) · [日本語](README.ja.md) · [한국어](README.ko.md) · [Norsk bokmål](README.nb.md) · [Nederlands](README.nl.md) · [Polski](README.pl.md) · [Português (Brasil)](README.pt-BR.md) · [Português (Portugal)](README.pt-PT.md) · [Română](README.ro.md) · [Русский](README.ru.md) · [Српски](README.sr-Cyrl.md) · [Svenska](README.sv.md) · [ไทย](README.th.md) · [Türkçe](README.tr.md) · [Українська](README.uk.md) · [Tiếng Việt](README.vi.md) · [简体中文](README.zh-Hans.md) · 繁體中文

![Tailnet Link](../images/hero.svg)

**留在你自己的 tailnet，同時連到其他每一個 tailnet 中的裝置。**

Tailscale 一次只能登入一個 tailnet。如果你的家用實驗室、公司和客戶各有自己的 tailnet，你就得不斷切換帳號，而且每次切換，原本的連線就會中斷。Tailnet Link 讓這件事成為過去：你的 Tailscale 應用程式維持原樣，Tailnet Link 在一旁悄悄加入其他 tailnet，`https://wiki.comet-bebop.ts.net/` 和 `build-pc.capybara-iguana.ts.net` 都能直接開啟。

**[下載最新版本](https://github.com/Azazel-Labs/tailnet-link/releases/latest)**，支援 Windows、macOS 和 Linux，免費且開放原始碼。

![Tailnet 分頁：兩個 tailnet 正在路由，並列出各自的裝置](../images/tailnets.png)

*截圖中的 tailnet 皆為虛構，其中的名稱和位址都是編造的。*

## 為什麼選擇 Tailnet Link

- **不必再切換帳號。** 需要幾個 tailnet 就加幾個，全部同時使用。你自己的 tailnet 永遠不會中斷。
- **不需要任何設定。** 登入後就會自動找到 tailnet 的網域。在任何瀏覽器中都能用名稱開啟裝置。
- **找出裝置上的網站。** 提供 HTTPS 網頁的裝置會列在清單中，附上網頁名稱和圖示，按一下就能開啟。為常用的網站加上星號，它們就會變成附有網頁畫面的圖塊。每台裝置每天最多檢查一次。
- **不和 Tailscale 衝突。** 沒有 VPN 介面卡，不改路由，也不改 DNS。每個額外的 tailnet 都在應用程式內以獨立節點執行，與 Tailscale 應用程式及彼此之間互不干擾。
- **預設就很安全。** 每個額外節點都以 Shields Up 模式加入：你可以連到那些 tailnet，但其中的任何裝置都無法連到你的電腦。
- **只有相關流量會經過它。** 只有其他 tailnet 中的位址會經過 Tailnet Link，其餘流量一如往常直接連線。
- **支援忽略代理伺服器的應用程式。** 遠端桌面、SSH 和資料庫用戶端只要按一下，就能取得通往裝置的本機連接埠。
- **終端機裡也能用。** 在 curl、git、ssh 或 ping 前加上 `tl`，或者單獨執行 `tl`，開啟一個可使用你的 tailnet 中名稱的 shell。
- **自動收拾善後。** 系統代理伺服器設定只在路由時開啟，結束、暫停、當機或停電後都會恢復原狀。
- **說你的語言。** 介面已翻譯成 31 種語言。

## 運作方式

1. **新增 tailnet。** 和 Tailscale 應用程式一樣，Tailscale 自己的登入頁面會在瀏覽器中開啟。
2. **自動取得網域。** 登入後，Tailnet Link 會讀取該 tailnet 的 MagicDNS 名稱（例如 `capybara-iguana.ts.net`），並透過它路由 `*.capybara-iguana.ts.net`。
3. **開啟裝置。** 在瀏覽器中輸入名稱，或從清單中選擇裝置來開啟、複製位址，或為它轉送連接埠。

## 忽略代理伺服器的應用程式

瀏覽器和大多數工具都會遵循系統代理伺服器設定，但遠端桌面、資料庫用戶端等應用程式不會。對於這類應用程式，按一下裝置旁的插頭按鈕並選擇連接埠：系統會挑選並保留一個可用的本機連接埠，你只要連到 `127.0.0.1:<port>` 即可。在 Windows 上，遠端桌面轉送還會有專屬的 **開啟遠端桌面** 按鈕。

![轉送遠端桌面後的對話方塊：可複製的本機位址，以及開啟遠端桌面的按鈕](../images/forward.png)

## 在終端機中使用

命令列工具不會讀取系統代理伺服器設定。在命令前加上隨應用程式一起安裝的 `tl`，或者單獨執行 `tl`，開啟一個可使用你的 tailnet 中名稱的 shell。**Tailnet** 分頁上的終端機按鈕也能開啟這樣的 shell。

```sh
tl curl http://wiki.capybara-iguana.ts.net/
tl ssh admin@build-pc.capybara-iguana.ts.net
tl ping build-pc.capybara-iguana.ts.net
```

curl、git、npm、pip 和大多數其他工具都能這樣使用，ssh、scp 和 sftp 也一樣。`tl ping` 使用 Tailscale 本身的 ping。詳細說明請參閱 [英文 README](../../README.md#in-a-terminal-tl)。

## 支援平台與下載

支援 Windows、macOS（選單列）和 Linux（GNOME 與 KDE）。請從 [最新版本](https://github.com/Azazel-Labs/tailnet-link/releases/latest) 下載：Windows 用 `tailnet-link-windows-setup.exe`，Mac 用 `tailnet-link-macos-universal.dmg`（Apple 晶片與 Intel），Ubuntu / Debian 用 `tailnet-link-linux-amd64.deb`（`sudo apt install ./tailnet-link-linux-amd64.deb`）。另有免安裝的獨立版本。

**未經程式碼簽署。** 在 Windows 上出現 SmartScreen 警告時，請選擇 **其他資訊 → 仍要執行**。在 macOS 上，第一次執行時請在應用程式上按右鍵並選擇 **打開**。

---

完整說明（代理伺服器設定的處理方式、Windows 安裝程式的行為、檔案位置等）請參閱 [英文 README](../../README.md)。歡迎透過 [docs/translations.md](../../docs/translations.md) 協助改進翻譯。

Copyright © 2026 Azazel Labs LLC. 以 [MIT-0](../../LICENSE) 授權發布。Tailnet Link 並非由 Tailscale Inc. 開發，也與其無關。Tailscale 是 Tailscale Inc. 的商標。
