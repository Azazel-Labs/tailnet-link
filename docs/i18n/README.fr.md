# Tailnet Link

[![CI](https://github.com/Azazel-Labs/tailnet-link/actions/workflows/ci.yml/badge.svg)](https://github.com/Azazel-Labs/tailnet-link/actions/workflows/ci.yml)
[![Release](https://img.shields.io/github/v/release/Azazel-Labs/tailnet-link)](https://github.com/Azazel-Labs/tailnet-link/releases)
[![License: MIT-0](https://img.shields.io/badge/license-MIT--0-blue.svg)](../../LICENSE)
[![Rust: 1.95+](https://img.shields.io/badge/rust-1.95%2B-orange.svg)](../../Cargo.toml)
[![Edition: 2024](https://img.shields.io/badge/edition-2024-orange.svg)](../../Cargo.toml)
[![Platforms](https://img.shields.io/badge/platforms-Windows%20%7C%20macOS%20%7C%20Linux-lightgrey.svg)](../../README.md#download)

[English](../../README.md) · [Afrikaans](README.af.md) · [Català](README.ca.md) · [Čeština](README.cs.md) · [Dansk](README.da.md) · [Deutsch](README.de.md) · [Ελληνικά](README.el.md) · [Español (Latinoamérica)](README.es-419.md) · [Español (España)](README.es-ES.md) · [Suomi](README.fi.md) · Français · [Magyar](README.hu.md) · [Bahasa Indonesia](README.id.md) · [Italiano](README.it.md) · [日本語](README.ja.md) · [한국어](README.ko.md) · [Norsk bokmål](README.nb.md) · [Nederlands](README.nl.md) · [Polski](README.pl.md) · [Português (Brasil)](README.pt-BR.md) · [Português (Portugal)](README.pt-PT.md) · [Română](README.ro.md) · [Русский](README.ru.md) · [Српски](README.sr-Cyrl.md) · [Svenska](README.sv.md) · [ไทย](README.th.md) · [Türkçe](README.tr.md) · [Українська](README.uk.md) · [Tiếng Việt](README.vi.md) · [简体中文](README.zh-Hans.md) · [繁體中文](README.zh-Hant.md)

![Tailnet Link](../images/hero.svg)

**Restez sur votre tailnet. Accédez aux machines de tous les autres, en même temps.**

Tailscale ne vous connecte qu’à un seul tailnet à la fois. Si votre labo maison, votre entreprise et un client ont chacun le leur, vous passez votre temps à changer de compte, et tout ce qui était ouvert se coupe. Tailnet Link y met fin. Votre application Tailscale reste exactement où elle est, et Tailnet Link ajoute discrètement les autres tailnets à côté : `https://wiki.comet-bebop.ts.net/` et `build-pc.capybara-iguana.ts.net` s’ouvrent tout simplement.

**[Téléchargez la dernière version](https://github.com/Azazel-Labs/tailnet-link/releases/latest)** pour Windows, macOS ou Linux. Gratuit et open source.

![Tailnet Link](../images/tailnets.png)

*Les captures d’écran utilisent des tailnets fictifs ; tous les noms et adresses sont inventés.*

## Pourquoi Tailnet Link

- **Fini les changements de compte.** Ajoutez autant de tailnets que nécessaire et utilisez-les tous à la fois. Votre propre tailnet ne se déconnecte jamais.
- **Rien à configurer.** Connectez-vous, et le domaine du tailnet est trouvé pour vous. Ouvrez ses machines par leur nom dans n’importe quel navigateur.
- **En bonne entente avec Tailscale.** Pas d’adaptateur VPN, pas de routes, pas de changement DNS. Chaque tailnet supplémentaire tourne comme un nœud distinct dans l’application, sans conflit avec l’application Tailscale ni entre eux.
- **Verrouillé par défaut.** Chaque nœud supplémentaire rejoint son tailnet avec les boucliers levés : vous accédez à ces tailnets, mais rien chez eux ne peut atteindre votre ordinateur.
- **Seul leur trafic passe par lui.** Les adresses de vos autres tailnets passent par Tailnet Link ; tout le reste va en direct, comme avant.
- **Compatible avec les applications qui ignorent les proxys.** Bureau à distance, SSH et les clients de bases de données obtiennent en un clic un port local qui mène à la machine.
- **Range derrière lui.** Le proxy système n’est activé que pendant le routage, et il est rétabli à la fermeture, à la pause, en cas de plantage ou de coupure de courant.
- **Parle votre langue.** L’interface est traduite en 31 langues.

## Comment ça marche

1. **Ajoutez un tailnet.** La page de connexion de Tailscale s’ouvre dans votre navigateur, comme avec l’application Tailscale.
2. **Son domaine est détecté automatiquement.** Après la connexion, Tailnet Link lit le nom MagicDNS du tailnet (par exemple `capybara-iguana.ts.net`) et route `*.capybara-iguana.ts.net` par celui-ci.
3. **Ouvrez ses machines.** Tapez un nom dans votre navigateur, ou choisissez une machine dans la liste pour l’ouvrir, copier son adresse ou lui rediriger un port.

## Applications qui ignorent les proxys

Les navigateurs et la plupart des outils suivent le proxy système. Bureau à distance, les clients de bases de données et les applications similaires, non. Pour celles-ci, cliquez sur le bouton en forme de prise à côté d’une machine et choisissez un port : un port local libre est attribué et conservé, et vous vous connectez à `127.0.0.1:<port>`. Sous Windows, les redirections Bureau à distance ont leur propre bouton **Ouvrir Bureau à distance**.

![Tailnet Link](../images/forward.png)

## Plateformes et téléchargement

Tailnet Link fonctionne sous Windows, macOS (dans la barre des menus) et Linux (GNOME avec l’extension AppIndicator, ou KDE). Sous Windows, lancez **`tailnet-link-windows-setup.exe`** ; sur Mac, ouvrez **`tailnet-link-macos-universal.dmg`** (Apple Silicon et Intel) ; sous Ubuntu ou Debian, exécutez `sudo apt install ./tailnet-link-linux-amd64.deb`. Les applications sont aussi disponibles sans installeur, et `SHA256SUMS.txt` liste les sommes de contrôle.

**Pas de signature de code.** Sous Windows, à l’avertissement SmartScreen, choisissez **Informations complémentaires → Exécuter quand même**. Sous macOS, faites un clic droit sur l’application et choisissez **Ouvrir** la première fois.

## En savoir plus

Les détails (fonctionnement interne, proxy système, installeur Windows, fichiers, contribution) sont dans le [README en anglais](../../README.md). Pour améliorer une traduction, consultez [docs/translations.md](../../docs/translations.md).

Copyright © 2026 Azazel Labs LLC. Publié sous [MIT-0](../../LICENSE). Tailnet Link n’est ni développé par Tailscale Inc. ni affilié à cette société. Tailscale est une marque de Tailscale Inc.
