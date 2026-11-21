# Tailnet Link

[![CI](https://github.com/Azazel-Labs/tailnet-link/actions/workflows/ci.yml/badge.svg)](https://github.com/Azazel-Labs/tailnet-link/actions/workflows/ci.yml)
[![Release](https://img.shields.io/github/v/release/Azazel-Labs/tailnet-link)](https://github.com/Azazel-Labs/tailnet-link/releases)
[![License: MIT-0](https://img.shields.io/badge/license-MIT--0-blue.svg)](../../LICENSE)
[![Rust: 1.95+](https://img.shields.io/badge/rust-1.95%2B-orange.svg)](../../Cargo.toml)
[![Edition: 2024](https://img.shields.io/badge/edition-2024-orange.svg)](../../Cargo.toml)
[![Platforms](https://img.shields.io/badge/platforms-Windows%20%7C%20macOS%20%7C%20Linux-lightgrey.svg)](../../README.md#download)

[English](../../README.md) · [Afrikaans](README.af.md) · [Català](README.ca.md) · [Čeština](README.cs.md) · [Dansk](README.da.md) · [Deutsch](README.de.md) · [Ελληνικά](README.el.md) · Español (Latinoamérica) · [Español (España)](README.es-ES.md) · [Suomi](README.fi.md) · [Français](README.fr.md) · [Magyar](README.hu.md) · [Bahasa Indonesia](README.id.md) · [Italiano](README.it.md) · [日本語](README.ja.md) · [한국어](README.ko.md) · [Norsk bokmål](README.nb.md) · [Nederlands](README.nl.md) · [Polski](README.pl.md) · [Português (Brasil)](README.pt-BR.md) · [Português (Portugal)](README.pt-PT.md) · [Română](README.ro.md) · [Русский](README.ru.md) · [Српски](README.sr-Cyrl.md) · [Svenska](README.sv.md) · [ไทย](README.th.md) · [Türkçe](README.tr.md) · [Українська](README.uk.md) · [Tiếng Việt](README.vi.md) · [简体中文](README.zh-Hans.md) · [繁體中文](README.zh-Hant.md)

![Tailnet Link](../images/hero.svg)

**Quédate en tu propio tailnet. Accede a los equipos de todos los demás, al mismo tiempo.**

Tailscale solo te permite tener la sesión iniciada en un tailnet a la vez. Si tu laboratorio en casa, tu empresa y un cliente tienen cada uno el suyo, vives cambiando de cuenta, y todo lo que tenías conectado se corta. Tailnet Link termina con eso. Tu aplicación de Tailscale se queda exactamente como está y Tailnet Link agrega discretamente los demás tailnets a su lado, así que `https://wiki.studio.example/` y `build-pc.home.example` simplemente se abren.

**[Descarga la versión más reciente](https://github.com/Azazel-Labs/tailnet-link/releases/latest)** para Windows, macOS o Linux. Es gratuita y de código abierto.

![Tailnet Link](../images/tailnets.png)

*Las capturas de pantalla usan tailnets ficticios; todos los nombres y direcciones son inventados.*

## Por qué Tailnet Link

- **Olvídate de cambiar de cuenta.** Agrega todos los tailnets que necesites y úsalos al mismo tiempo. Tu propio tailnet nunca se desconecta.
- **Nada que configurar.** Inicia sesión y el dominio del tailnet se detecta solo. Abre sus equipos por nombre en cualquier navegador.
- **No interfiere con Tailscale.** Sin adaptador VPN, sin rutas, sin cambios de DNS. Cada tailnet adicional se ejecuta como un nodo independiente dentro de la aplicación, sin conflictos con la aplicación de Tailscale ni entre ellos.
- **Protegido de forma predeterminada.** Cada nodo adicional se une con los escudos activados: tú llegas a esos tailnets, pero nada en ellos puede llegar a tu computadora.
- **Solo su tráfico pasa por él.** Las direcciones de tus otros tailnets pasan por Tailnet Link; todo lo demás va directo, como siempre.
- **Funciona con apps que ignoran el proxy.** Escritorio remoto, SSH y los clientes de bases de datos obtienen con un clic un puerto local que lleva al equipo.
- **Deja todo como estaba.** El proxy del sistema solo está activado mientras algo se enruta, y se restablece al salir, al pausar, si la aplicación falla o si se corta la luz.
- **Habla tu idioma.** La interfaz está traducida a 31 idiomas.

## Cómo funciona

1. **Agrega un tailnet.** La página de inicio de sesión de Tailscale se abre en tu navegador, igual que con la aplicación de Tailscale.
2. **Su dominio se detecta automáticamente.** Después de iniciar sesión, Tailnet Link lee el nombre MagicDNS del tailnet (por ejemplo, `example.ts.net`) y enruta `*.example.ts.net` a través de él.
3. **Abre sus equipos.** Escribe un nombre en el navegador, o elige un equipo de la lista para abrirlo, copiar su dirección o redirigirle un puerto.

## Apps que ignoran el proxy

Los navegadores y la mayoría de las herramientas siguen el proxy del sistema. Escritorio remoto, los clientes de bases de datos y apps similares, no. Para ellas, haz clic en el botón del enchufe junto a un equipo y elige un puerto: se asigna y se conserva un puerto local libre, y te conectas a `127.0.0.1:<puerto>`. En Windows, las redirecciones de Escritorio remoto tienen su propio botón **Abrir Escritorio remoto**.

![Tailnet Link](../images/forward.png)

## Plataformas y descarga

Tailnet Link funciona en Windows, macOS (en la barra de menús) y Linux (GNOME con la extensión AppIndicator, o KDE). En Windows, ejecuta **`tailnet-link-windows-setup.exe`**; en Mac, abre **`tailnet-link-macos-universal.dmg`** (Apple Silicon e Intel); en Ubuntu o Debian, ejecuta `sudo apt install ./tailnet-link-linux-amd64.deb`. También hay versiones sin instalador, y `SHA256SUMS.txt` incluye las sumas de verificación.

**Sin firma de código.** En Windows, ante la advertencia de SmartScreen, elige **Más información → Ejecutar de todas formas**. En macOS, haz clic derecho en la aplicación y elige **Abrir** la primera vez.

## Más información

Todos los detalles (funcionamiento interno, proxy del sistema, instalador de Windows, archivos, cómo contribuir) están en el [README en inglés](../../README.md). Para mejorar una traducción, consulta [docs/translations.md](../../docs/translations.md).

Copyright © 2026 Azazel Labs LLC. Publicado bajo [MIT-0](../../LICENSE). Tailnet Link no está hecho por Tailscale Inc. ni afiliado a ella. Tailscale es una marca comercial de Tailscale Inc.
