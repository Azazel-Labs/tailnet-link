# Tailnet Link

[![CI](https://github.com/Azazel-Labs/tailnet-link/actions/workflows/ci.yml/badge.svg)](https://github.com/Azazel-Labs/tailnet-link/actions/workflows/ci.yml)
[![Release](https://img.shields.io/github/v/release/Azazel-Labs/tailnet-link)](https://github.com/Azazel-Labs/tailnet-link/releases)
[![License: MIT-0](https://img.shields.io/badge/license-MIT--0-blue.svg)](../../LICENSE)
[![Rust: 1.95+](https://img.shields.io/badge/rust-1.95%2B-orange.svg)](../../Cargo.toml)
[![Edition: 2024](https://img.shields.io/badge/edition-2024-orange.svg)](../../Cargo.toml)
[![Platforms](https://img.shields.io/badge/platforms-Windows%20%7C%20macOS%20%7C%20Linux-lightgrey.svg)](../../README.md#download)

[English](../../README.md) · [Afrikaans](README.af.md) · [Català](README.ca.md) · [Čeština](README.cs.md) · [Dansk](README.da.md) · [Deutsch](README.de.md) · [Ελληνικά](README.el.md) · [Español (Latinoamérica)](README.es-419.md) · [Español (España)](README.es-ES.md) · [Suomi](README.fi.md) · [Français](README.fr.md) · [Magyar](README.hu.md) · [Bahasa Indonesia](README.id.md) · [Italiano](README.it.md) · [日本語](README.ja.md) · [한국어](README.ko.md) · [Norsk bokmål](README.nb.md) · [Nederlands](README.nl.md) · [Polski](README.pl.md) · [Português (Brasil)](README.pt-BR.md) · Português (Portugal) · [Română](README.ro.md) · [Русский](README.ru.md) · [Српски](README.sr-Cyrl.md) · [Svenska](README.sv.md) · [ไทย](README.th.md) · [Türkçe](README.tr.md) · [Українська](README.uk.md) · [Tiếng Việt](README.vi.md) · [简体中文](README.zh-Hans.md) · [繁體中文](README.zh-Hant.md)

![Tailnet Link](../images/hero.svg)

**Mantenha-se na sua tailnet. Aceda a máquinas em todas as outras, ao mesmo tempo.**

O Tailscale só permite ter sessão iniciada numa tailnet de cada vez. Se o seu laboratório doméstico, a sua empresa e um cliente têm cada um a sua, está sempre a trocar de conta, e tudo aquilo a que estava ligado cai. O Tailnet Link acaba com isso. A sua aplicação Tailscale fica exatamente onde está, e o Tailnet Link junta discretamente as outras tailnets ao lado dela: `https://wiki.studio.example/` e `build-pc.home.example` abrem simplesmente.

**[Transfira a versão mais recente](https://github.com/Azazel-Labs/tailnet-link/releases/latest)** para Windows, macOS ou Linux. É gratuito e de código aberto.

![Tailnet Link](../images/tailnets.png)

*As capturas de ecrã usam tailnets fictícias; todos os nomes e endereços nelas são inventados.*

## Porquê o Tailnet Link

- **Acabou a troca de contas.** Adicione as tailnets de que precisar e use-as todas ao mesmo tempo. A sua própria tailnet nunca perde a ligação.
- **Nada para configurar.** Inicie sessão e o domínio da tailnet é encontrado por si. Abra as respetivas máquinas pelo nome em qualquer browser.
- **Não entra em conflito com o Tailscale.** Sem adaptador VPN, sem rotas, sem alterações de DNS. Cada tailnet adicional funciona como um nó separado dentro da aplicação, sem colidir com a aplicação Tailscale nem entre si.
- **Protegido por predefinição.** Cada nó adicional entra com os escudos levantados: pode aceder a essas tailnets, mas nada nelas consegue chegar ao seu computador.
- **Só o tráfego delas passa por ele.** Os endereços das suas outras tailnets passam pelo Tailnet Link. Tudo o resto segue diretamente, como antes.
- **Funciona com aplicações que ignoram proxies.** O Ambiente de Trabalho Remoto, o SSH e os clientes de bases de dados recebem, com um clique, uma porta local que leva à máquina.
- **Arruma a casa ao sair.** A definição de proxy do sistema só fica ativa enquanto algo está a ser encaminhado, e é reposta ao sair, ao suspender, numa falha ou num corte de energia.
- **Fala a sua língua.** A interface está traduzida em 31 línguas.

## Como funciona

1. **Adicione uma tailnet.** A própria página de início de sessão do Tailscale abre no seu browser, tal como na aplicação Tailscale.
2. **O domínio é detetado automaticamente.** Depois de iniciar sessão, o Tailnet Link lê o nome MagicDNS da tailnet (por exemplo `example.ts.net`) e encaminha `*.example.ts.net` através dela.
3. **Abra as respetivas máquinas.** Escreva um nome no browser, ou escolha uma máquina na lista para a abrir, copiar o endereço ou reencaminhar-lhe uma porta.

## Aplicações que ignoram proxies

Os browsers e a maioria das ferramentas seguem a definição de proxy do sistema. O Ambiente de Trabalho Remoto, os clientes de bases de dados e aplicações semelhantes, não. Para essas, clique no botão de ficha ao lado de uma máquina e escolha uma porta: é escolhida e mantida uma porta local livre, e liga-se a `127.0.0.1:<port>`. No Windows, os reencaminhamentos do Ambiente de Trabalho Remoto têm um botão próprio **Abrir Ambiente de Trabalho Remoto**.

![Tailnet Link](../images/forward.png)

## Plataformas e transferência

O Tailnet Link funciona em Windows, macOS (na barra de menus) e Linux (GNOME com a extensão AppIndicator, ou KDE). Em Windows, execute **`tailnet-link-windows-setup.exe`**; no Mac, abra **`tailnet-link-macos-universal.dmg`** (Apple Silicon e Intel); em Ubuntu ou Debian, execute `sudo apt install ./tailnet-link-linux-amd64.deb`. Também existem versões sem instalador, e o `SHA256SUMS.txt` lista as somas de verificação.

**Sem assinatura de código.** No Windows, no aviso do SmartScreen, escolha **Mais informações → Executar mesmo assim**. No macOS, clique com o botão direito do rato na aplicação e escolha **Abrir** da primeira vez.

## Saiba mais

Os detalhes (funcionamento interno, proxy do sistema, instalador para Windows, ficheiros, contribuições) estão no [README em inglês](../../README.md). Para melhorar uma tradução, consulte [docs/translations.md](../../docs/translations.md).

Copyright © 2026 Azazel Labs LLC. Publicado sob [MIT-0](../../LICENSE). O Tailnet Link não é desenvolvido pela Tailscale Inc. nem afiliado a ela. Tailscale é uma marca comercial da Tailscale Inc.
