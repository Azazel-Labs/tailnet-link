# Tailnet Link

[![CI](https://github.com/Azazel-Labs/tailnet-link/actions/workflows/ci.yml/badge.svg)](https://github.com/Azazel-Labs/tailnet-link/actions/workflows/ci.yml)
[![Release](https://img.shields.io/github/v/release/Azazel-Labs/tailnet-link)](https://github.com/Azazel-Labs/tailnet-link/releases)
[![License: MIT-0](https://img.shields.io/badge/license-MIT--0-blue.svg)](../../LICENSE)
[![Rust: 1.95+](https://img.shields.io/badge/rust-1.95%2B-orange.svg)](../../Cargo.toml)
[![Edition: 2024](https://img.shields.io/badge/edition-2024-orange.svg)](../../Cargo.toml)
[![Platforms](https://img.shields.io/badge/platforms-Windows%20%7C%20macOS%20%7C%20Linux-lightgrey.svg)](../../README.md#download)

[English](../../README.md) · [Afrikaans](README.af.md) · [Català](README.ca.md) · [Čeština](README.cs.md) · [Dansk](README.da.md) · [Deutsch](README.de.md) · [Ελληνικά](README.el.md) · [Español (Latinoamérica)](README.es-419.md) · [Español (España)](README.es-ES.md) · [Suomi](README.fi.md) · [Français](README.fr.md) · [Magyar](README.hu.md) · [Bahasa Indonesia](README.id.md) · [Italiano](README.it.md) · [日本語](README.ja.md) · [한국어](README.ko.md) · [Norsk bokmål](README.nb.md) · [Nederlands](README.nl.md) · [Polski](README.pl.md) · [Português (Brasil)](README.pt-BR.md) · [Português (Portugal)](README.pt-PT.md) · [Română](README.ro.md) · [Русский](README.ru.md) · [Српски](README.sr-Cyrl.md) · [Svenska](README.sv.md) · [ไทย](README.th.md) · [Türkçe](README.tr.md) · [Українська](README.uk.md) · [Tiếng Việt](README.vi.md) · 简体中文 · [繁體中文](README.zh-Hant.md)

![Tailnet Link](../images/hero.svg)

**留在你自己的 tailnet 上，同时访问其他所有 tailnet 中的设备。**

Tailscale 一次只能登录一个 tailnet。如果你的家庭实验室、公司和客户各有各的 tailnet，你就得不停切换账户，而且每次切换都会断开之前的连接。Tailnet Link 解决了这个问题：你的 Tailscale 应用原封不动，Tailnet Link 在一旁悄悄加入其他 tailnet，`https://wiki.comet-bebop.ts.net/` 和 `build-pc.capybara-iguana.ts.net` 都能直接打开。

**[下载最新版本](https://github.com/Azazel-Labs/tailnet-link/releases/latest)**，支持 Windows、macOS 和 Linux，免费且开源。

![Tailnet 选项卡：两个 tailnet 正在路由，并列出了各自的设备](../images/tailnets.png)

*截图中的 tailnet 均为虚构，其中的名称和地址都是编造的。*

## 为什么选择 Tailnet Link

- **告别切换账户。** 按需添加任意多个 tailnet，同时使用。你自己的 tailnet 永远不会断开。
- **无需配置。** 登录即可，tailnet 的域名会自动找到。在任何浏览器中都能按名称打开设备。
- **找出设备上的网站。** 提供 HTTPS 页面的设备会以磁贴形式显示，附带页面名称和图标，一键即可打开。每台设备每天最多检查一次。
- **不与 Tailscale 冲突。** 没有 VPN 适配器，不改路由，不改 DNS。每个额外的 tailnet 都在应用内作为独立节点运行，与 Tailscale 应用以及彼此之间互不干扰。
- **默认安全。** 每个额外节点都以 Shields Up 模式加入：你可以访问那些 tailnet，而其中的任何设备都无法访问你的电脑。
- **只有相关流量经过它。** 只有其他 tailnet 中的地址经过 Tailnet Link，其他流量照旧直连。
- **支持忽略代理的应用。** 远程桌面、SSH 和数据库客户端一键即可获得通往设备的本地端口。
- **自动善后。** 系统代理设置仅在路由时开启，退出、暂停、崩溃或断电后都会恢复原状。
- **说你的语言。** 界面已翻译成 31 种语言。

## 工作原理

1. **添加 tailnet。** 和 Tailscale 应用一样，Tailscale 自己的登录页面会在浏览器中打开。
2. **自动获取域名。** 登录后，Tailnet Link 会读取该 tailnet 的 MagicDNS 名称（例如 `capybara-iguana.ts.net`），并通过它路由 `*.capybara-iguana.ts.net`。
3. **打开设备。** 在浏览器中输入名称，或从列表中选择设备来打开它、复制地址，或为它转发端口。

## 忽略代理的应用

浏览器和大多数工具都会遵循系统代理设置，但远程桌面、数据库客户端等应用不会。对于这类应用，点击设备旁的插头按钮并选择端口：系统会选定并保留一个空闲的本地端口，你只需连接 `127.0.0.1:<port>`。在 Windows 上，远程桌面转发还会有专门的 **打开远程桌面** 按钮。

![转发远程桌面后的对话框：可复制的本地地址和打开远程桌面的按钮](../images/forward.png)

## 支持平台与下载

支持 Windows、macOS（菜单栏）和 Linux（GNOME 与 KDE）。从 [最新版本](https://github.com/Azazel-Labs/tailnet-link/releases/latest) 下载：Windows 用 `tailnet-link-windows-setup.exe`，Mac 用 `tailnet-link-macos-universal.dmg`（Apple 芯片和 Intel），Ubuntu / Debian 用 `tailnet-link-linux-amd64.deb`（`sudo apt install ./tailnet-link-linux-amd64.deb`）。另有无需安装的独立版本。

**未进行代码签名。** 在 Windows 上出现 SmartScreen 警告时，选择 **更多信息 → 仍要运行**。在 macOS 上，首次运行时请右键点按应用并选择 **打开**。

---

完整信息（代理设置的处理方式、Windows 安装程序的行为、文件位置等）请参阅 [英文 README](../../README.md)。欢迎通过 [docs/translations.md](../../docs/translations.md) 改进翻译。

Copyright © 2026 Azazel Labs LLC. 以 [MIT-0](../../LICENSE) 发布。Tailnet Link 并非由 Tailscale Inc. 开发，也与其无关。Tailscale 是 Tailscale Inc. 的商标。
