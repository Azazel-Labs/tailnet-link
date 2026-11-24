# Tailnet Link

[![CI](https://github.com/Azazel-Labs/tailnet-link/actions/workflows/ci.yml/badge.svg)](https://github.com/Azazel-Labs/tailnet-link/actions/workflows/ci.yml)
[![Release](https://img.shields.io/github/v/release/Azazel-Labs/tailnet-link)](https://github.com/Azazel-Labs/tailnet-link/releases)
[![License: MIT-0](https://img.shields.io/badge/license-MIT--0-blue.svg)](../../LICENSE)
[![Rust: 1.95+](https://img.shields.io/badge/rust-1.95%2B-orange.svg)](../../Cargo.toml)
[![Edition: 2024](https://img.shields.io/badge/edition-2024-orange.svg)](../../Cargo.toml)
[![Platforms](https://img.shields.io/badge/platforms-Windows%20%7C%20macOS%20%7C%20Linux-lightgrey.svg)](../../README.md#download)

[English](../../README.md) · [Afrikaans](README.af.md) · [Català](README.ca.md) · [Čeština](README.cs.md) · [Dansk](README.da.md) · [Deutsch](README.de.md) · [Ελληνικά](README.el.md) · [Español (Latinoamérica)](README.es-419.md) · [Español (España)](README.es-ES.md) · [Suomi](README.fi.md) · [Français](README.fr.md) · [Magyar](README.hu.md) · [Bahasa Indonesia](README.id.md) · [Italiano](README.it.md) · 日本語 · [한국어](README.ko.md) · [Norsk bokmål](README.nb.md) · [Nederlands](README.nl.md) · [Polski](README.pl.md) · [Português (Brasil)](README.pt-BR.md) · [Português (Portugal)](README.pt-PT.md) · [Română](README.ro.md) · [Русский](README.ru.md) · [Српски](README.sr-Cyrl.md) · [Svenska](README.sv.md) · [ไทย](README.th.md) · [Türkçe](README.tr.md) · [Українська](README.uk.md) · [Tiếng Việt](README.vi.md) · [简体中文](README.zh-Hans.md) · [繁體中文](README.zh-Hant.md)

![Tailnet Link](../images/hero.svg)

**自分の tailnet に接続したまま、他のすべての tailnet のマシンにも同時にアクセス。**

Tailscale では、一度にサインインできる tailnet は 1 つだけです。自宅のラボ、会社、取引先がそれぞれ tailnet を持っていると、そのたびにアカウントを切り替えることになり、接続中だったものは切れてしまいます。Tailnet Link はこの手間をなくします。Tailscale アプリはそのままに、Tailnet Link が他の tailnet をそっと横に追加するので、`https://wiki.comet-bebop.ts.net/` も `build-pc.capybara-iguana.ts.net` も、そのまま開けます。

Windows、macOS、Linux 向けの **[最新リリースをダウンロード](https://github.com/Azazel-Labs/tailnet-link/releases/latest)**。無料のオープンソースです。

![Tailnet タブ: 2 つの tailnet がルーティング中で、それぞれのマシンが一覧表示されている](../images/tailnets.png)

*スクリーンショットの tailnet は架空のもので、名前やアドレスはすべて作り物です。*

## Tailnet Link を選ぶ理由

- **アカウントの切り替えはもう不要。** 必要なだけ tailnet を追加して、すべて同時に使えます。自分の tailnet が切断されることはありません。
- **設定いらず。** サインインするだけで tailnet のドメインが自動的に見つかります。マシンはどのブラウザーからでも名前で開けます。
- **マシン上の Web サイトを自動で発見。** HTTPS のページを提供しているマシンが、ページの名前とアイコン付きで一覧に表示され、クリックひとつで開けます。よく使うものに星を付けると、ページの画像付きのタイルになります。確認は各マシンにつき 1 日 1 回までです。
- **Tailscale とぶつからない。** VPN アダプターもルートも DNS の変更もありません。追加の tailnet はそれぞれアプリ内の独立したノードとして動くので、Tailscale アプリとも互いとも競合しません。
- **初期状態で安全。** 追加のノードはすべて Shields Up で参加します。こちらからはその tailnet にアクセスできても、向こうからこのコンピューターにはアクセスできません。
- **通るのは対象の通信だけ。** 他の tailnet のアドレスだけが Tailnet Link を経由し、それ以外はこれまでどおり直接つながります。
- **プロキシを無視するアプリにも対応。** リモート デスクトップ、SSH、データベース クライアントには、マシンにつながるローカル ポートをワンクリックで用意できます。
- **ターミナルでも使える。** curl、git、ssh、ping の前に `tl` を付けるか、`tl` だけを実行すると、tailnet の名前が使えるシェルになります。
- **後片付けも自動。** システムのプロキシ設定はルーティング中だけオンになり、終了、一時停止、クラッシュ、停電のあとには元に戻ります。
- **31 言語に対応。** インターフェースは日本語を含む 31 言語に翻訳されています。

## しくみ

1. **tailnet を追加する。** Tailscale アプリと同じように、Tailscale 自身のサインイン ページがブラウザーで開きます。
2. **ドメインは自動で取得。** サインインすると、Tailnet Link が tailnet の MagicDNS 名 (例: `capybara-iguana.ts.net`) を読み取り、`*.capybara-iguana.ts.net` をその tailnet 経由でルーティングします。
3. **マシンを開く。** ブラウザーに名前を入力するか、一覧からマシンを選んで開く、アドレスをコピーする、ポートを転送する、のいずれかを選ぶだけです。

## プロキシを無視するアプリ

ブラウザーや多くのツールはシステムのプロキシ設定に従いますが、リモート デスクトップやデータベース クライアントなどは従いません。その場合は、マシンの横にあるプラグ ボタンをクリックしてポートを選びます。空いているローカル ポートが選ばれて固定されるので、`127.0.0.1:<port>` に接続するだけです。Windows では、リモート デスクトップの転送に専用の **リモート デスクトップを開く** ボタンが付きます。

![リモート デスクトップを転送したあとのダイアログ: コピーできるローカル アドレスと、リモート デスクトップを開くボタン](../images/forward.png)

## ターミナルで使う

コマンドライン ツールはシステムのプロキシ設定を読みません。アプリと一緒にインストールされる `tl` をコマンドの前に付けるか、`tl` だけを実行すると、tailnet の名前が使えるシェルになります。**Tailnet** タブのターミナル ボタンからも、このシェルを開けます。

```sh
tl curl http://wiki.capybara-iguana.ts.net/
tl ssh admin@build-pc.capybara-iguana.ts.net
tl ping build-pc.capybara-iguana.ts.net
```

curl、git、npm、pip をはじめ、ほとんどのツールがこの方法で動き、ssh、scp、sftp も同様です。`tl ping` は Tailscale 独自の ping を使います。詳しくは [英語の README](../../README.md#in-a-terminal-tl) をご覧ください。

## 対応プラットフォームとダウンロード

Windows、macOS (メニュー バー)、Linux (GNOME と KDE) に対応しています。[最新リリース](https://github.com/Azazel-Labs/tailnet-link/releases/latest) から、Windows は `tailnet-link-windows-setup.exe`、Mac は `tailnet-link-macos-universal.dmg` (Apple Silicon と Intel)、Ubuntu / Debian は `tailnet-link-linux-amd64.deb` (`sudo apt install ./tailnet-link-linux-amd64.deb`) を入手してください。インストーラーなしの単体版もあります。

**コード署名はされていません。** Windows で SmartScreen の警告が出たら **詳細情報 → 実行** を選びます。macOS では、初回はアプリを右クリックして **開く** を選んでください。

---

詳しい情報 (プロキシ設定の扱い、Windows インストーラーの動作、ファイルの場所など) は [英語の README](../../README.md) をご覧ください。翻訳の改善は [docs/translations.md](../../docs/translations.md) から歓迎しています。

Copyright © 2026 Azazel Labs LLC. [MIT-0](../../LICENSE) で公開しています。Tailnet Link は Tailscale Inc. が開発したものではなく、同社とは関係ありません。Tailscale は Tailscale Inc. の商標です。
