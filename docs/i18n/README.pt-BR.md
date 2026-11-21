# Tailnet Link

[![CI](https://github.com/Azazel-Labs/tailnet-link/actions/workflows/ci.yml/badge.svg)](https://github.com/Azazel-Labs/tailnet-link/actions/workflows/ci.yml)
[![Release](https://img.shields.io/github/v/release/Azazel-Labs/tailnet-link)](https://github.com/Azazel-Labs/tailnet-link/releases)
[![License: MIT-0](https://img.shields.io/badge/license-MIT--0-blue.svg)](../../LICENSE)
[![Rust: 1.95+](https://img.shields.io/badge/rust-1.95%2B-orange.svg)](../../Cargo.toml)
[![Edition: 2024](https://img.shields.io/badge/edition-2024-orange.svg)](../../Cargo.toml)
[![Platforms](https://img.shields.io/badge/platforms-Windows%20%7C%20macOS%20%7C%20Linux-lightgrey.svg)](../../README.md#download)

[English](../../README.md) · [Afrikaans](README.af.md) · [Català](README.ca.md) · [Čeština](README.cs.md) · [Dansk](README.da.md) · [Deutsch](README.de.md) · [Ελληνικά](README.el.md) · [Español (Latinoamérica)](README.es-419.md) · [Español (España)](README.es-ES.md) · [Suomi](README.fi.md) · [Français](README.fr.md) · [Magyar](README.hu.md) · [Bahasa Indonesia](README.id.md) · [Italiano](README.it.md) · [日本語](README.ja.md) · [한국어](README.ko.md) · [Norsk bokmål](README.nb.md) · [Nederlands](README.nl.md) · [Polski](README.pl.md) · Português (Brasil) · [Português (Portugal)](README.pt-PT.md) · [Română](README.ro.md) · [Русский](README.ru.md) · [Српски](README.sr-Cyrl.md) · [Svenska](README.sv.md) · [ไทย](README.th.md) · [Türkçe](README.tr.md) · [Українська](README.uk.md) · [Tiếng Việt](README.vi.md) · [简体中文](README.zh-Hans.md) · [繁體中文](README.zh-Hant.md)

![Tailnet Link](../images/hero.svg)

**Fique na sua tailnet. Acesse máquinas em todas as outras, ao mesmo tempo.**

O Tailscale só deixa você ficar conectado a uma tailnet por vez. Se o seu home lab, a sua empresa e um cliente têm cada um a sua, você vive trocando de conta, e tudo o que estava conectado cai. O Tailnet Link acaba com isso. Seu aplicativo do Tailscale continua exatamente onde está, e o Tailnet Link adiciona discretamente as outras tailnets ao lado dele: `https://wiki.studio.example/` e `build-pc.home.example` simplesmente abrem.

**[Baixe a versão mais recente](https://github.com/Azazel-Labs/tailnet-link/releases/latest)** para Windows, macOS ou Linux. É gratuito e de código aberto.

![Tailnet Link](../images/tailnets.png)

*As capturas de tela usam tailnets fictícias; todos os nomes e endereços nelas são inventados.*

## Por que o Tailnet Link

- **Chega de trocar de conta.** Adicione quantas tailnets precisar e use todas ao mesmo tempo. Sua própria tailnet nunca desconecta.
- **Nada para configurar.** Faça login e o domínio da tailnet é encontrado para você. Abra as máquinas dela pelo nome em qualquer navegador.
- **Não briga com o Tailscale.** Sem adaptador de VPN, sem rotas, sem mudanças de DNS. Cada tailnet extra roda como um nó separado dentro do aplicativo, sem conflito com o aplicativo do Tailscale nem entre si.
- **Protegido por padrão.** Cada nó extra entra com os escudos levantados: você acessa essas tailnets, e nada nelas consegue acessar o seu computador.
- **Só o tráfego delas passa por ele.** Endereços das suas outras tailnets passam pelo Tailnet Link. Todo o resto vai direto, exatamente como antes.
- **Funciona com aplicativos que ignoram proxies.** Área de Trabalho Remota, SSH e clientes de banco de dados ganham, com um clique, uma porta local que leva à máquina.
- **Arruma tudo ao sair.** A configuração de proxy do sistema só fica ativa enquanto algo está roteando, e é restaurada ao sair, pausar, travar ou faltar energia.
- **Fala o seu idioma.** A interface está traduzida para 31 idiomas.

## Como funciona

1. **Adicione uma tailnet.** A própria página de login do Tailscale abre no seu navegador, como no aplicativo do Tailscale.
2. **O domínio é detectado automaticamente.** Depois do login, o Tailnet Link lê o nome MagicDNS da tailnet (por exemplo `example.ts.net`) e roteia `*.example.ts.net` por ela.
3. **Abra as máquinas dela.** Digite um nome no navegador ou escolha uma máquina na lista para abri-la, copiar o endereço ou encaminhar uma porta para ela.

## Aplicativos que ignoram proxies

Navegadores e a maioria das ferramentas seguem a configuração de proxy do sistema. A Área de Trabalho Remota, os clientes de banco de dados e aplicativos parecidos, não. Para esses, clique no botão de plugue ao lado de uma máquina e escolha uma porta: uma porta local livre é escolhida e mantida, e você se conecta a `127.0.0.1:<port>`. No Windows, os encaminhamentos da Área de Trabalho Remota ganham um botão próprio **Abrir Área de Trabalho Remota**.

![Tailnet Link](../images/forward.png)

## Plataformas e download

O Tailnet Link funciona no Windows, no macOS (na barra de menus) e no Linux (GNOME com a extensão AppIndicator, ou KDE). No Windows, execute **`tailnet-link-windows-setup.exe`**; no Mac, abra **`tailnet-link-macos-universal.dmg`** (Apple Silicon e Intel); no Ubuntu ou Debian, execute `sudo apt install ./tailnet-link-linux-amd64.deb`. Também há versões sem instalador, e o `SHA256SUMS.txt` lista as somas de verificação.

**Sem assinatura de código.** No Windows, no aviso do SmartScreen, escolha **Mais informações → Executar assim mesmo**. No macOS, clique com o botão direito no aplicativo e escolha **Abrir** na primeira vez.

## Saiba mais

Os detalhes (funcionamento interno, proxy do sistema, instalador do Windows, arquivos, contribuições) estão no [README em inglês](../../README.md). Para melhorar uma tradução, consulte [docs/translations.md](../../docs/translations.md).

Copyright © 2026 Azazel Labs LLC. Publicado sob [MIT-0](../../LICENSE). O Tailnet Link não é desenvolvido pela Tailscale Inc. nem afiliado a ela. Tailscale é uma marca comercial da Tailscale Inc.
