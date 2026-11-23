# Tailnet Link

[![CI](https://github.com/Azazel-Labs/tailnet-link/actions/workflows/ci.yml/badge.svg)](https://github.com/Azazel-Labs/tailnet-link/actions/workflows/ci.yml)
[![Release](https://img.shields.io/github/v/release/Azazel-Labs/tailnet-link)](https://github.com/Azazel-Labs/tailnet-link/releases)
[![License: MIT-0](https://img.shields.io/badge/license-MIT--0-blue.svg)](../../LICENSE)
[![Rust: 1.95+](https://img.shields.io/badge/rust-1.95%2B-orange.svg)](../../Cargo.toml)
[![Edition: 2024](https://img.shields.io/badge/edition-2024-orange.svg)](../../Cargo.toml)
[![Platforms](https://img.shields.io/badge/platforms-Windows%20%7C%20macOS%20%7C%20Linux-lightgrey.svg)](../../README.md#download)

[English](../../README.md) · [Afrikaans](README.af.md) · [Català](README.ca.md) · [Čeština](README.cs.md) · [Dansk](README.da.md) · [Deutsch](README.de.md) · [Ελληνικά](README.el.md) · [Español (Latinoamérica)](README.es-419.md) · [Español (España)](README.es-ES.md) · [Suomi](README.fi.md) · [Français](README.fr.md) · [Magyar](README.hu.md) · [Bahasa Indonesia](README.id.md) · [Italiano](README.it.md) · [日本語](README.ja.md) · [한국어](README.ko.md) · [Norsk bokmål](README.nb.md) · [Nederlands](README.nl.md) · [Polski](README.pl.md) · [Português (Brasil)](README.pt-BR.md) · [Português (Portugal)](README.pt-PT.md) · [Română](README.ro.md) · [Русский](README.ru.md) · [Српски](README.sr-Cyrl.md) · [Svenska](README.sv.md) · [ไทย](README.th.md) · [Türkçe](README.tr.md) · [Українська](README.uk.md) · Tiếng Việt · [简体中文](README.zh-Hans.md) · [繁體中文](README.zh-Hant.md)

![Tailnet Link](../images/hero.svg)

**Vẫn ở trên tailnet của bạn, đồng thời truy cập máy trên mọi tailnet khác.**

Tailscale chỉ cho bạn đăng nhập vào một tailnet mỗi lúc. Nếu phòng lab ở nhà, công ty và khách hàng của bạn mỗi nơi có một tailnet riêng, bạn sẽ phải liên tục chuyển tài khoản, và kết nối đang dùng sẽ bị ngắt mỗi lần như vậy. Tailnet Link chấm dứt chuyện đó. Ứng dụng Tailscale của bạn vẫn giữ nguyên, còn Tailnet Link lặng lẽ thêm các tailnet khác bên cạnh, nên cả `https://wiki.comet-bebop.ts.net/` lẫn `build-pc.capybara-iguana.ts.net` đều mở được ngay.

**[Tải bản phát hành mới nhất](https://github.com/Azazel-Labs/tailnet-link/releases/latest)** cho Windows, macOS hoặc Linux. Miễn phí và mã nguồn mở.

![Thẻ Tailnet với hai tailnet đang định tuyến và danh sách máy của từng tailnet](../images/tailnets.png)

*Ảnh chụp màn hình dùng các tailnet hư cấu; mọi tên và địa chỉ trong đó đều là bịa ra.*

## Vì sao chọn Tailnet Link

- **Không còn phải chuyển tài khoản.** Thêm bao nhiêu tailnet tùy ý và dùng tất cả cùng lúc. Tailnet của riêng bạn không bao giờ bị ngắt.
- **Không cần cấu hình.** Chỉ cần đăng nhập, tên miền của tailnet sẽ được tìm tự động. Mở máy theo tên trong bất kỳ trình duyệt nào.
- **Tìm các trang web trên máy của bạn.** Những máy đang phục vụ trang HTTPS hiện thành ô với tên và biểu tượng của trang, chỉ cách một cú nhấp. Mỗi máy được kiểm tra tối đa một lần mỗi ngày.
- **Không xung đột với Tailscale.** Không có bộ điều hợp VPN, không thêm tuyến, không đổi DNS. Mỗi tailnet bổ sung chạy như một nút riêng bên trong ứng dụng, nên không đụng chạm tới ứng dụng Tailscale hay lẫn nhau.
- **An toàn ngay từ đầu.** Mỗi nút bổ sung tham gia với chế độ Shields Up: bạn truy cập được các tailnet đó, nhưng không gì trong đó truy cập được máy tính của bạn.
- **Chỉ lưu lượng liên quan mới đi qua.** Chỉ địa chỉ trong các tailnet khác mới đi qua Tailnet Link. Mọi thứ khác vẫn đi trực tiếp như trước.
- **Hoạt động với cả ứng dụng bỏ qua proxy.** Máy tính Từ xa, SSH và trình khách cơ sở dữ liệu có ngay một cổng cục bộ dẫn tới máy, chỉ với một cú nhấp.
- **Dùng được cả trong terminal.** Thêm `tl` vào trước curl, git, ssh hay ping, hoặc chạy riêng `tl` để mở một shell dùng được tên trong các tailnet của bạn.
- **Tự dọn dẹp.** Cài đặt proxy hệ thống chỉ bật khi đang định tuyến, và được khôi phục khi thoát, tạm dừng, gặp sự cố hay mất điện.
- **Nói ngôn ngữ của bạn.** Giao diện đã được dịch sang 31 ngôn ngữ.

## Cách hoạt động

1. **Thêm một tailnet.** Trang đăng nhập của chính Tailscale mở trong trình duyệt, giống như với ứng dụng Tailscale.
2. **Tên miền được nhận tự động.** Sau khi bạn đăng nhập, Tailnet Link đọc tên MagicDNS của tailnet (ví dụ `capybara-iguana.ts.net`) và định tuyến `*.capybara-iguana.ts.net` qua tailnet đó.
3. **Mở máy.** Gõ tên vào trình duyệt, hoặc chọn một máy trong danh sách để mở, sao chép địa chỉ hay chuyển tiếp cổng tới máy đó.

## Ứng dụng bỏ qua proxy

Trình duyệt và hầu hết công cụ đều tuân theo cài đặt proxy hệ thống. Máy tính Từ xa, trình khách cơ sở dữ liệu và các ứng dụng tương tự thì không. Với những ứng dụng này, hãy nhấp nút phích cắm cạnh một máy và chọn cổng: một cổng cục bộ còn trống sẽ được chọn và giữ cố định, và bạn chỉ cần kết nối tới `127.0.0.1:<port>`. Trên Windows, các chuyển tiếp Máy tính Từ xa còn có nút **Mở Máy tính Từ xa** riêng.

![Hộp thoại sau khi chuyển tiếp Máy tính Từ xa: một địa chỉ cục bộ để sao chép và nút mở Máy tính Từ xa](../images/forward.png)

## Trong terminal

Các công cụ dòng lệnh không đọc cài đặt proxy hệ thống. Thêm `tl`, được cài cùng ứng dụng, vào trước một lệnh, hoặc chạy riêng `tl` để mở một shell dùng được tên trong các tailnet của bạn. Nút terminal trong thẻ **Tailnet** cũng mở một shell như vậy.

```sh
tl curl http://wiki.capybara-iguana.ts.net/
tl ssh admin@build-pc.capybara-iguana.ts.net
tl ping build-pc.capybara-iguana.ts.net
```

curl, git, npm, pip và hầu hết các công cụ khác đều hoạt động theo cách này, ssh, scp và sftp cũng vậy. `tl ping` dùng lệnh ping riêng của Tailscale. Xem chi tiết trong [README tiếng Anh](../../README.md#in-a-terminal-tl).

## Nền tảng và tải xuống

Hỗ trợ Windows, macOS (thanh menu) và Linux (GNOME và KDE). Tải từ [bản phát hành mới nhất](https://github.com/Azazel-Labs/tailnet-link/releases/latest): `tailnet-link-windows-setup.exe` cho Windows, `tailnet-link-macos-universal.dmg` cho Mac (Apple Silicon và Intel), `tailnet-link-linux-amd64.deb` cho Ubuntu / Debian (`sudo apt install ./tailnet-link-linux-amd64.deb`). Ngoài ra còn có bản chạy trực tiếp không cần trình cài đặt.

**Chưa được ký mã.** Trên Windows, khi gặp cảnh báo SmartScreen, hãy chọn **Thông tin bổ sung → Vẫn chạy**. Trên macOS, lần đầu tiên hãy nhấp chuột phải vào ứng dụng và chọn **Mở**.

---

Xem đầy đủ chi tiết (cách xử lý cài đặt proxy, trình cài đặt Windows làm gì, vị trí tệp…) trong [README tiếng Anh](../../README.md). Mọi góp ý cải thiện bản dịch đều được chào đón qua [docs/translations.md](../../docs/translations.md).

Copyright © 2026 Azazel Labs LLC. Phát hành theo giấy phép [MIT-0](../../LICENSE). Tailnet Link không do Tailscale Inc. tạo ra và không liên kết với Tailscale Inc. Tailscale là nhãn hiệu của Tailscale Inc.
