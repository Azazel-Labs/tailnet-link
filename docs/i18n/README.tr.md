# Tailnet Link

[![CI](https://github.com/Azazel-Labs/tailnet-link/actions/workflows/ci.yml/badge.svg)](https://github.com/Azazel-Labs/tailnet-link/actions/workflows/ci.yml)
[![Release](https://img.shields.io/github/v/release/Azazel-Labs/tailnet-link)](https://github.com/Azazel-Labs/tailnet-link/releases)
[![License: MIT-0](https://img.shields.io/badge/license-MIT--0-blue.svg)](../../LICENSE)
[![Rust: 1.95+](https://img.shields.io/badge/rust-1.95%2B-orange.svg)](../../Cargo.toml)
[![Edition: 2024](https://img.shields.io/badge/edition-2024-orange.svg)](../../Cargo.toml)
[![Platforms](https://img.shields.io/badge/platforms-Windows%20%7C%20macOS%20%7C%20Linux-lightgrey.svg)](../../README.md#download)

[English](../../README.md) · [Afrikaans](README.af.md) · [Català](README.ca.md) · [Čeština](README.cs.md) · [Dansk](README.da.md) · [Deutsch](README.de.md) · [Ελληνικά](README.el.md) · [Español (Latinoamérica)](README.es-419.md) · [Español (España)](README.es-ES.md) · [Suomi](README.fi.md) · [Français](README.fr.md) · [Magyar](README.hu.md) · [Bahasa Indonesia](README.id.md) · [Italiano](README.it.md) · [日本語](README.ja.md) · [한국어](README.ko.md) · [Norsk bokmål](README.nb.md) · [Nederlands](README.nl.md) · [Polski](README.pl.md) · [Português (Brasil)](README.pt-BR.md) · [Português (Portugal)](README.pt-PT.md) · [Română](README.ro.md) · [Русский](README.ru.md) · [Српски](README.sr-Cyrl.md) · [Svenska](README.sv.md) · [ไทย](README.th.md) · Türkçe · [Українська](README.uk.md) · [Tiếng Việt](README.vi.md) · [简体中文](README.zh-Hans.md) · [繁體中文](README.zh-Hant.md)

![Tailnet Link](../images/hero.svg)

**Kendi tailnet'inizde kalın. Diğer tüm tailnet'lerdeki makinelere aynı anda erişin.**

Tailscale'de aynı anda yalnızca bir tailnet'te oturum açabilirsiniz. Ev laboratuvarınızın, şirketinizin ve bir müşterinizin ayrı tailnet'leri varsa sürekli hesap değiştirirsiniz ve bağlı olduğunuz her şey kopar. Tailnet Link buna son verir. Tailscale uygulamanız olduğu yerde kalır; Tailnet Link diğer tailnet'leri sessizce yanına ekler. Böylece hem `https://wiki.studio.example/` hem de `build-pc.home.example` doğrudan açılır.

Windows, macOS veya Linux için **[en son sürümü indirin](https://github.com/Azazel-Labs/tailnet-link/releases/latest)**. Ücretsiz ve açık kaynaklıdır.

![Yönlendirme yapan iki tailnet ve makinelerinin listelendiği Tailnet'ler sekmesi](../images/tailnets.png)

*Ekran görüntülerinde uydurma tailnet'ler kullanılmıştır; içlerindeki tüm adlar ve adresler hayalîdir.*

## Neden Tailnet Link

- **Hesap değiştirmeye son.** İhtiyacınız kadar tailnet ekleyin ve hepsini aynı anda kullanın. Kendi tailnet'inizin bağlantısı hiç kesilmez.
- **Yapılandıracak bir şey yok.** Oturum açın, tailnet'in alan adı sizin için bulunur. Makinelerini herhangi bir tarayıcıda adlarıyla açın.
- **Tailscale ile çatışmaz.** VPN bağdaştırıcısı yok, rota yok, DNS değişikliği yok. Her ek tailnet uygulamanın içinde ayrı bir düğüm olarak çalışır; bu yüzden ne Tailscale uygulamasıyla ne de birbiriyle çakışır.
- **Varsayılan olarak kilitli.** Her ek düğüm "shields up" ile katılır: o tailnet'lere siz erişebilirsiniz, ama onlardaki hiçbir şey bilgisayarınıza erişemez.
- **Yalnızca onların trafiği geçer.** Diğer tailnet'lerinizdeki adresler Tailnet Link üzerinden gider. Geri kalan her şey eskisi gibi doğrudan gider.
- **Proxy'yi yok sayan uygulamalarla da çalışır.** Uzak Masaüstü, SSH ve veritabanı istemcileri tek tıklamayla makineye giden yerel bir port alır.
- **Arkasını toplar.** Sistem proxy ayarı yalnızca bir şey yönlendirilirken açıktır; çıkışta, duraklatmada, çökmede veya elektrik kesintisinde eski haline getirilir.
- **Sizin dilinizi konuşur.** Arayüz 31 dile çevrilmiştir.

## Nasıl çalışır

1. **Bir tailnet ekleyin.** Tailscale'in kendi oturum açma sayfası, tıpkı Tailscale uygulamasında olduğu gibi tarayıcınızda açılır.
2. **Alan adı otomatik olarak algılanır.** Oturum açtıktan sonra Tailnet Link, tailnet'in MagicDNS adını (örneğin `example.ts.net`) okur ve `*.example.ts.net` adreslerini onun üzerinden yönlendirir.
3. **Makinelerini açın.** Tarayıcınıza bir ad yazın ya da listeden bir makine seçerek açın, adresini kopyalayın veya ona bir port yönlendirin.

## Proxy'yi yok sayan uygulamalar

Tarayıcılar ve çoğu araç sistem proxy ayarına uyar; Uzak Masaüstü, veritabanı istemcileri ve benzeri uygulamalar uymaz. Bunlar için bir makinenin yanındaki fiş düğmesine tıklayın ve bir port seçin: boş bir yerel port seçilip saklanır, siz de `127.0.0.1:<port>` adresine bağlanırsınız. Windows'ta Uzak Masaüstü yönlendirmelerinin kendi **Uzak Masaüstü'nü aç** düğmesi vardır.

![Uzak Masaüstü yönlendirildikten sonraki iletişim kutusu: kopyalanacak yerel adres ve Uzak Masaüstü'nü açan düğme](../images/forward.png)

## İndirme ve platformlar

Tailnet Link; Windows, macOS ve Linux'ta (GNOME ve KDE) çalışır. [En son sürümde](https://github.com/Azazel-Labs/tailnet-link/releases/latest) Windows yükleyicisi `tailnet-link-windows-setup.exe`, Mac (Apple Silicon ve Intel) için `tailnet-link-macos-universal.dmg` ve Ubuntu / Debian için `tailnet-link-linux-amd64.deb` (`sudo apt install ./tailnet-link-linux-amd64.deb`) bulunur.

**Kod imzalı değildir.** Windows'ta SmartScreen uyarısında **Daha fazla bilgi → Yine de çalıştır** seçeneğini seçin. macOS'te ilk seferde uygulamaya sağ tıklayıp **Aç** komutunu seçin.

## Daha fazlası

Tüm ayrıntılar (ayarlar, tepsi menüsü, proxy ayarının geri yüklenmesi, Windows yükleyicisi, dosya konumları) [İngilizce README](../../README.md) dosyasındadır. Çeviriyi iyileştirmek için [docs/translations.md](../../docs/translations.md) belgesine bakın.

Telif hakkı © 2026 Azazel Labs LLC. [MIT-0](../../LICENSE) lisansıyla yayımlanmıştır. Tailnet Link, Tailscale Inc. tarafından yapılmamıştır ve Tailscale Inc. ile bağlantılı değildir. Tailscale, Tailscale Inc.'in ticari markasıdır.
