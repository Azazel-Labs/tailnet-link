# Tailnet Link

[![CI](https://github.com/Azazel-Labs/tailnet-link/actions/workflows/ci.yml/badge.svg)](https://github.com/Azazel-Labs/tailnet-link/actions/workflows/ci.yml)
[![Release](https://img.shields.io/github/v/release/Azazel-Labs/tailnet-link)](https://github.com/Azazel-Labs/tailnet-link/releases)
[![License: MIT-0](https://img.shields.io/badge/license-MIT--0-blue.svg)](../../LICENSE)
[![Rust: 1.95+](https://img.shields.io/badge/rust-1.95%2B-orange.svg)](../../Cargo.toml)
[![Edition: 2024](https://img.shields.io/badge/edition-2024-orange.svg)](../../Cargo.toml)
[![Platforms](https://img.shields.io/badge/platforms-Windows%20%7C%20macOS%20%7C%20Linux-lightgrey.svg)](../../README.md#download)

[English](../../README.md) · [Afrikaans](README.af.md) · [Català](README.ca.md) · [Čeština](README.cs.md) · [Dansk](README.da.md) · [Deutsch](README.de.md) · [Ελληνικά](README.el.md) · [Español (Latinoamérica)](README.es-419.md) · [Español (España)](README.es-ES.md) · [Suomi](README.fi.md) · [Français](README.fr.md) · [Magyar](README.hu.md) · [Bahasa Indonesia](README.id.md) · [Italiano](README.it.md) · [日本語](README.ja.md) · [한국어](README.ko.md) · [Norsk bokmål](README.nb.md) · [Nederlands](README.nl.md) · [Polski](README.pl.md) · [Português (Brasil)](README.pt-BR.md) · [Português (Portugal)](README.pt-PT.md) · [Română](README.ro.md) · [Русский](README.ru.md) · [Српски](README.sr-Cyrl.md) · [Svenska](README.sv.md) · ไทย · [Türkçe](README.tr.md) · [Українська](README.uk.md) · [Tiếng Việt](README.vi.md) · [简体中文](README.zh-Hans.md) · [繁體中文](README.zh-Hant.md)

![Tailnet Link](../images/hero.svg)

**อยู่ใน tailnet ของคุณเอง แล้วเข้าถึงเครื่องในทุก tailnet อื่นได้ในเวลาเดียวกัน**

Tailscale ให้คุณลงชื่อเข้าใช้ได้ครั้งละหนึ่ง tailnet เท่านั้น หากโฮมแล็บ บริษัท และลูกค้าของคุณต่างมี tailnet ของตัวเอง คุณต้องสลับบัญชีอยู่ตลอด และการเชื่อมต่อที่ใช้อยู่ก็หลุดทุกครั้ง Tailnet Link แก้ปัญหานี้ได้ แอป Tailscale ของคุณยังอยู่ที่เดิมทุกอย่าง ส่วน Tailnet Link จะเพิ่ม tailnet อื่นๆ เข้ามาข้างกันอย่างเงียบๆ ทำให้ทั้ง `https://wiki.comet-bebop.ts.net/` และ `build-pc.capybara-iguana.ts.net` เปิดได้ทันที

**[ดาวน์โหลดรุ่นล่าสุด](https://github.com/Azazel-Labs/tailnet-link/releases/latest)** สำหรับ Windows, macOS หรือ Linux ใช้ได้ฟรีและเป็นโอเพนซอร์ส

![แท็บ Tailnet ที่มีสอง tailnet กำลังกำหนดเส้นทาง พร้อมรายการเครื่อง](../images/tailnets.png)

*ภาพหน้าจอใช้ tailnet สมมติ ชื่อและที่อยู่ทั้งหมดในภาพเป็นข้อมูลที่แต่งขึ้น*

## ทำไมต้อง Tailnet Link

- **ไม่ต้องสลับบัญชีอีกต่อไป** เพิ่ม tailnet ได้มากเท่าที่ต้องการและใช้ทั้งหมดพร้อมกัน tailnet ของคุณเองไม่หลุดการเชื่อมต่อเลย
- **ไม่ต้องตั้งค่าอะไร** เพียงลงชื่อเข้าใช้ ระบบจะหาโดเมนของ tailnet ให้เอง แล้วเปิดเครื่องต่างๆ ด้วยชื่อได้ในเบราว์เซอร์ใดก็ได้
- **ค้นหาเว็บไซต์บนเครื่องของคุณ** เครื่องที่ให้บริการหน้าเว็บ HTTPS จะแสดงในรายการพร้อมชื่อและไอคอนของหน้า เปิดได้ในคลิกเดียว ติดดาวเว็บไซต์ที่คุณใช้ แล้วจะกลายเป็นไทล์พร้อมภาพของหน้านั้น แต่ละเครื่องจะถูกตรวจสอบไม่เกินวันละครั้ง
- **ไม่ขัดกับ Tailscale** ไม่มีอะแดปเตอร์ VPN ไม่เพิ่มเส้นทาง ไม่แก้ DNS แต่ละ tailnet ที่เพิ่มจะทำงานเป็นโหนดแยกภายในแอป จึงไม่ชนกับแอป Tailscale หรือชนกันเอง
- **ปิดกั้นไว้ตั้งแต่ต้น** โหนดที่เพิ่มทุกโหนดเข้าร่วมแบบ shields up คุณเข้าถึง tailnet เหล่านั้นได้ แต่ไม่มีอะไรใน tailnet เหล่านั้นเข้าถึงคอมพิวเตอร์ของคุณได้
- **ส่งผ่านเฉพาะทราฟฟิกของ tailnet เหล่านั้น** ที่อยู่ใน tailnet อื่นของคุณจะผ่าน Tailnet Link ส่วนอย่างอื่นทั้งหมดไปโดยตรงเหมือนเดิม
- **ใช้ได้กับแอปที่ไม่ทำตามพร็อกซี** เดสก์ท็อประยะไกล SSH และไคลเอ็นต์ฐานข้อมูลได้พอร์ตในเครื่องที่นำไปยังเครื่องปลายทางในคลิกเดียว
- **ใช้ในเทอร์มินัลได้ด้วย** ใส่ `tl` ไว้หน้า curl, git, ssh หรือ ping หรือรัน `tl` อย่างเดียวเพื่อเปิดเชลล์ที่ใช้ชื่อใน tailnet ของคุณได้
- **เก็บกวาดให้เรียบร้อย** การตั้งค่าพร็อกซีของระบบจะเปิดเฉพาะขณะที่มีการกำหนดเส้นทาง และจะคืนค่าเดิมเมื่อออก หยุดชั่วคราว แอปขัดข้อง หรือไฟดับ
- **พูดภาษาของคุณ** ส่วนติดต่อแปลไว้แล้ว 31 ภาษา

## วิธีการทำงาน

1. **เพิ่ม tailnet** หน้าลงชื่อเข้าใช้ของ Tailscale เองจะเปิดในเบราว์เซอร์ เหมือนกับในแอป Tailscale
2. **ตรวจหาโดเมนให้โดยอัตโนมัติ** หลังลงชื่อเข้าใช้ Tailnet Link จะอ่านชื่อ MagicDNS ของ tailnet (เช่น `capybara-iguana.ts.net`) แล้วกำหนดเส้นทาง `*.capybara-iguana.ts.net` ผ่าน tailnet นั้น
3. **เปิดเครื่องต่างๆ** พิมพ์ชื่อในเบราว์เซอร์ หรือเลือกเครื่องจากรายการเพื่อเปิด คัดลอกที่อยู่ หรือส่งต่อพอร์ตไปยังเครื่องนั้น

## แอปที่ไม่ทำตามพร็อกซี

เบราว์เซอร์และเครื่องมือส่วนใหญ่ทำตามการตั้งค่าพร็อกซีของระบบ แต่เดสก์ท็อประยะไกล ไคลเอ็นต์ฐานข้อมูล และแอปลักษณะเดียวกันไม่ทำตาม สำหรับแอปเหล่านี้ ให้คลิกปุ่มปลั๊กข้างเครื่องแล้วเลือกพอร์ต ระบบจะเลือกพอร์ตในเครื่องที่ว่างและเก็บไว้ให้ จากนั้นคุณเชื่อมต่อที่ `127.0.0.1:<port>` บน Windows การส่งต่อเดสก์ท็อประยะไกลจะมีปุ่ม **เปิดเดสก์ท็อประยะไกล** ของตัวเอง

![กล่องโต้ตอบหลังส่งต่อเดสก์ท็อประยะไกล: ที่อยู่ในเครื่องสำหรับคัดลอกและปุ่มเปิดเดสก์ท็อประยะไกล](../images/forward.png)

## ในเทอร์มินัล

เครื่องมือบรรทัดคำสั่งไม่อ่านการตั้งค่าพร็อกซีของระบบ ใส่ `tl` ซึ่งติดตั้งมาพร้อมแอปไว้หน้าคำสั่ง หรือรัน `tl` อย่างเดียวเพื่อเปิดเชลล์ที่ใช้ชื่อใน tailnet ของคุณได้ ปุ่มเทอร์มินัลในแท็บ **Tailnet** ก็เปิดเชลล์แบบนี้ได้เช่นกัน

```sh
tl curl http://wiki.capybara-iguana.ts.net/
tl ssh admin@build-pc.capybara-iguana.ts.net
tl ping build-pc.capybara-iguana.ts.net
```

curl, git, npm, pip และเครื่องมืออื่นๆ ส่วนใหญ่ทำงานแบบนี้ รวมถึง ssh, scp และ sftp ด้วย ส่วน `tl ping` ใช้ ping ของ Tailscale เอง ดูรายละเอียดได้ใน [README ภาษาอังกฤษ](../../README.md#in-a-terminal-tl)

## ดาวน์โหลดและแพลตฟอร์ม

Tailnet Link ทำงานบน Windows, macOS และ Linux (GNOME และ KDE) ใน[รุ่นล่าสุด](https://github.com/Azazel-Labs/tailnet-link/releases/latest) มีตัวติดตั้งสำหรับ Windows `tailnet-link-windows-setup.exe` ไฟล์ `tailnet-link-macos-universal.dmg` สำหรับ Mac (Apple Silicon และ Intel) และ `tailnet-link-linux-amd64.deb` สำหรับ Ubuntu และ Debian (`sudo apt install ./tailnet-link-linux-amd64.deb`)

**ไม่ได้ลงนามโค้ด** บน Windows เมื่อ SmartScreen แสดงคำเตือน ให้เลือก **ข้อมูลเพิ่มเติม → เรียกใช้ต่อไป** (More info → Run anyway) บน macOS ให้คลิกขวาที่แอปแล้วเลือก **เปิด** ในครั้งแรก

## ข้อมูลเพิ่มเติม

รายละเอียดทั้งหมด (การตั้งค่า เมนูถาด การคืนค่าพร็อกซี ตัวติดตั้ง Windows และตำแหน่งไฟล์) อยู่ใน [README ภาษาอังกฤษ](../../README.md) หากต้องการช่วยปรับปรุงคำแปล ดูที่ [docs/translations.md](../../docs/translations.md)

Copyright © 2026 Azazel Labs LLC เผยแพร่ภายใต้สัญญาอนุญาต [MIT-0](../../LICENSE) Tailnet Link ไม่ได้สร้างโดยหรือเกี่ยวข้องกับ Tailscale Inc. และ Tailscale เป็นเครื่องหมายการค้าของ Tailscale Inc.
