### Tailnet Link: danh mục tiếng Việt.
### Giữ nguyên tên sản phẩm Tailnet Link, Tailscale và thuật ngữ "tailnet" của Tailscale.

-app-name = Tailnet Link

## Window header

tab-tailnets = Tailnet
tab-settings = Cài đặt

## Unsaved-changes bar at the bottom of Settings

unsaved-changes = Bạn có thay đổi chưa lưu.
save = Lưu
revert = Hoàn nguyên
revert-tooltip = Hủy các thay đổi
settings-saved = Đã lưu cài đặt

## Short notes at the bottom of the window

copied-address = Đã sao chép { $address }
copied-sign-in-link = Đã sao chép liên kết đăng nhập

## Errors shown in the "Something went wrong" dialog

start-failed =
    { -app-name } không thể khởi động:
    { $error }
add-tailnet-failed =
    Không thể thêm tailnet:
    { $error }
add-forward-failed =
    Không thể thêm chuyển tiếp cổng:
    { $error }
remote-desktop-failed = Không thể khởi động Máy tính Từ xa: { $error }
remote-desktop-windows-only = Máy tính Từ xa chỉ được tích hợp sẵn trên Windows.
no-free-port = Không tìm thấy cổng cục bộ nào còn trống.

## Dialog after "Add a tailnet"

sign-in-dialog-title = Đăng nhập vào tailnet mới
sign-in-dialog-text =
    Trình duyệt đang mở trang đăng nhập của Tailscale. Trang có thể hiện ra phía sau cửa sổ này.
    
    Hãy đăng nhập bằng tài khoản của tailnet đó, rồi quay lại đây. Tên miền của nó sẽ được nhận tự động.

## One tailnet's state, shown as a coloured label beside its name

state-waiting-sign-in = Đang chờ đăng nhập
state-signed-out = Đã đăng xuất
state-problem = Có sự cố
state-connecting = Đang kết nối
state-paused = Đã tạm dừng
state-no-domain = Chưa có tên miền
state-not-routing = Không định tuyến
state-routing = Đang định tuyến

## The whole app's state, in the status card and the tray menu

summary-no-tailnets = Chưa có tailnet nào
summary-paused = Đã tạm dừng
summary-routing-one = Đang định tuyến qua { $tailnet }
summary-routing-all = Đang định tuyến qua { $count } tailnet
summary-routing-some = Đang định tuyến qua { $routing }/{ $count } tailnet
summary-signed-out = Chưa đăng nhập
summary-problem = Sự cố: { $problem }
summary-connecting = Đang kết nối…
new-tailnet = Tailnet mới

## Status card at the top of the Tailnets tab

hero-starting = Đang khởi động…
hero-connecting = Đang kết nối tới các tailnet của bạn.
hero-paused = Hiện không có gì đi qua các tailnet khác. Mạng và tailnet của riêng bạn vẫn hoạt động như bình thường.
hero-finish-sign-in = Hãy hoàn tất việc đăng nhập vào { $tailnet } trong trình duyệt.
hero-sign-in = Đăng nhập vào { $tailnet } để truy cập các máy trong đó.
hero-routing-example = Mở { $address } hoặc bất kỳ địa chỉ nào khác trong các tailnet này. Mọi thứ khác vẫn đi trực tiếp.
hero-routing = Các địa chỉ trong những tailnet này mở được ngay trong trình duyệt. Mọi thứ khác vẫn đi trực tiếp.
add-tailnet = Thêm tailnet
pause-all = Tạm dừng tất cả
pause-all-tooltip = Tạm ngừng định tuyến qua các tailnet khác
resume = Tiếp tục
resume-tooltip = Định tuyến lại qua các tailnet khác

## First run, before any tailnet is added

welcome-title = Truy cập máy trên các tailnet khác
welcome-text = Vẫn ở trên tailnet của bạn mà đồng thời mở được các máy ở tailnet khác. Ứng dụng Tailscale của bạn vẫn hoạt động như bình thường.
welcome-sign-in = Đăng nhập vào một tailnet khác
welcome-sign-in-detail = Trang đăng nhập của Tailscale sẽ mở trong trình duyệt.
welcome-open = Mở máy theo tên
welcome-open-detail = Các địa chỉ như { $example } dùng được ngay trong trình duyệt.
welcome-forward = Chuyển tiếp cổng khi ứng dụng cần
welcome-forward-detail = Máy tính Từ xa, SSH và ứng dụng cơ sở dữ liệu sẽ có một cổng cục bộ dẫn tới máy.

## A tailnet's card

machine-search-hint = Tìm máy theo tên, hệ điều hành hoặc địa chỉ
clear-search = Xóa tìm kiếm
more-actions = Thao tác khác
edit-tailnet-menu = Đổi tên hoặc thêm tên miền…
log-out-menu = Đăng xuất…
remove-menu = Gỡ bỏ…
sign-in = Đăng nhập
pause-tailnet = Tạm dừng tailnet này
resume-tailnet = Tiếp tục tailnet này
detail-tailnet = Tailnet
detail-routes = Tuyến
detail-this-computer = Máy tính này
detail-problem = Sự cố
routes-after-sign-in = Sẽ có sau khi bạn đăng nhập
hostname-after-sign-in = { $hostname } (sau khi bạn đăng nhập)
sign-in-help = Trình duyệt không mở, hoặc mở nhầm hồ sơ?
sign-in-open-again = Mở lại trang đăng nhập
sign-in-copy-link = Sao chép liên kết
sign-in-copy-link-tooltip = Dán vào trình duyệt hoặc hồ sơ trình duyệt mà bạn dùng cho tailnet này

## Machine list inside a tailnet's card

machines-online = Máy · { $online }/{ $total } trực tuyến
machines-matching = Máy · { $shown }/{ $total } khớp
no-machines = Không thấy máy nào khác trong tailnet này.
no-machine-matches = Không có máy nào khớp với tìm kiếm.
machine-offline = { $name } (ngoại tuyến)
forward-port-tooltip = Chuyển tiếp cổng: dành cho ứng dụng bỏ qua cài đặt proxy, như Máy tính Từ xa hoặc trình khách cơ sở dữ liệu
copy-address = Sao chép { $address }
open-in-browser = Mở { $url } trong trình duyệt
not-routing-tooltip = Tailnet này hiện không định tuyến. Có phải nó đang tạm dừng?

## Websites found on the machines

sites-heading = Trang web
sites-help = Các máy trong tailnet của bạn có phục vụ trang web qua HTTPS. Mỗi máy được kiểm tra tối đa một lần mỗi ngày.
# $done and $total count machines.
sites-checking = Đang kiểm tra { $done }/{ $total }…
sites-recheck-tooltip = Kiểm tra lại tất cả các máy ngay
site-untrusted = Chứng chỉ của trang này không được tin cậy, vì vậy trình duyệt sẽ cảnh báo bạn.

## Settings: port forwards

forwards-heading = Chuyển tiếp cổng
forwards-help = Dành cho ứng dụng bỏ qua cài đặt proxy, như Máy tính Từ xa, SSH và trình khách cơ sở dữ liệu. Mỗi chuyển tiếp là một cổng trên máy tính này dẫn tới một máy trong tailnet.
edit-forwards = Sửa chuyển tiếp
forwards-format-help = Mỗi dòng một mục: LOCALPORT = host:port, hoặc auto = host:port để tự chọn một cổng trống. Tên máy chủ quyết định tailnet nào sẽ chuyển nó. Để thêm nhanh, dùng nút phích cắm trên một máy trong thẻ Tailnet.
forward-cant-listen = Không thể lắng nghe: { $error }
forward-port-on-save = Cổng sẽ được chọn khi bạn lưu
forward-no-tailnet = Không có tailnet đang định tuyến nào có tên này
forward-via = qua { $tailnet }
open-remote-desktop-to = Mở Máy tính Từ xa tới { $address }

## Settings: system proxy

proxy-heading = Cài đặt proxy hệ thống
proxy-on = Bật (khuyên dùng)
proxy-force = Bật, và thay thế tập lệnh proxy do công ty đặt trong khi chạy
proxy-off = Tắt: tôi sẽ tự thiết lập ứng dụng
proxy-help-windows = “Bật” khiến Windows chỉ dùng quy tắc của ứng dụng này khi ứng dụng đang chạy và định tuyến, rồi khôi phục lại khi ứng dụng dừng, tạm dừng, ngắt kết nối hoặc gặp sự cố.
proxy-help-macos = “Bật” đặt proxy cho các dịch vụ mạng của bạn khi ứng dụng đang chạy và khôi phục lại sau đó. Nếu máy Mac cần mật khẩu quản trị viên để làm việc này, bạn sẽ được hỏi khi bắt đầu định tuyến và khi thoát.
proxy-help-linux = “Bật” thay đổi cài đặt proxy của GNOME hoặc KDE khi ứng dụng đang chạy và định tuyến, rồi khôi phục lại sau đó. Trong Firefox, hãy bật Cài đặt > Cài đặt mạng > “Sử dụng cài đặt proxy của hệ thống”.

## Settings: general

general-heading = Chung
start-at-login = Khởi động { -app-name } khi tôi đăng nhập
language = Ngôn ngữ
system-default = Mặc định hệ thống

## Settings: troubleshooting

troubleshooting-heading = Khắc phục sự cố
troubleshooting-help = Kiểm tra một địa chỉ web hoặc tên:cổng để xem tailnet nào chuyển nó và có kết nối được không.
test = Kiểm tra
testing = Đang kiểm tra…
open-log = Mở nhật ký
open-settings-folder = Mở thư mục cài đặt
about-line = { -app-name } { $version } · proxy cục bộ { $proxy } · PAC { $pac }
settings-location = Cài đặt nằm trong { $path }

## Results of "Test" in Troubleshooting

check-empty = Hãy nhập tên máy hoặc địa chỉ web.
check-bad-port = { $input }: đó không phải là cổng hợp lệ.
check-not-routed = { $host } không được { -app-name } định tuyến: nó không kết thúc bằng tên miền của tailnet nào đang định tuyến, nên sẽ đi trực tiếp (qua mạng thông thường và Tailscale của riêng bạn).
check-gone = Tailnet đó vừa biến mất.
check-not-running = { $tailnet } không chạy.
check-ok = { $address } hoạt động: đã kết nối qua { $tailnet } trong { $ms } ms.
check-failed =
    { $host } được định tuyến qua { $tailnet }, nhưng không thể kết nối tới cổng { $port }: { $error }
    Hãy kiểm tra xem máy có trực tuyến không và có dịch vụ nào đang lắng nghe trên cổng đó không.
check-timeout = { $host } được định tuyến qua { $tailnet }, nhưng cổng { $port } không phản hồi trong vòng 10 giây.
domain-conflict = { $domain } cũng được { $tailnet } định tuyến; tailnet đó được ưu tiên.

## Mistakes in typed settings

forwards-line-format = Dòng { $line }: hãy viết LOCALPORT = host:port.
forwards-line-port = Dòng { $line }: “{ $value }” không phải số cổng (hoặc auto).
forwards-line-target = Dòng { $line }: “{ $value }” phải có dạng host:port.
forwards-line-duplicate = Dòng { $line }: cổng cục bộ { $port } bị dùng hai lần.
domain-invalid = “{ $domain }” không phải tên miền; hãy dùng dạng như example.ts.net.
domain-characters = “{ $domain }” chứa ký tự không được phép trong tên miền.
autostart-unsupported = Hệ thống này không hỗ trợ khởi động khi đăng nhập.

## Dialogs

ok = OK
cancel = Hủy
done = Xong
copy = Sao chép
error-title = Đã xảy ra lỗi
error-details = Chi tiết nằm trong { $path }
edit-title = Sửa { $tailnet }
tailnet-name = Tên
tailnet-name-hint = Hiển thị trong ứng dụng này và menu khay hệ thống
extra-domains = Tên miền bổ sung (tùy chọn)
extra-domains-help = Tên miền riêng của tailnet được định tuyến tự động. Thêm mỗi dòng một tên miền.
forward-dialog-title = Chuyển tiếp cổng
forward-dialog-text = Tạo một cổng trên máy tính này dẫn tới { $host }. Bạn muốn dùng cổng nào trên máy đó?
port-preset-remote-desktop = Máy tính Từ xa
port-tooltip = Cổng { $port }
port = Cổng
port-hint = vd: 8080
add-forward = Thêm chuyển tiếp
not-a-port = “{ $value }” không phải số cổng (1-65535).
forward-ready-title = Chuyển tiếp cổng đã sẵn sàng
forward-ready-text = Trỏ ứng dụng của bạn tới địa chỉ này để truy cập { $target }:
forward-ready-note = Cổng sẽ không đổi. Bạn có thể tìm lại trong Cài đặt.
open-remote-desktop = Mở Máy tính Từ xa
remove-title = Gỡ bỏ tailnet này?
remove-text = { -app-name } sẽ đăng xuất khỏi { $tailnet } và xóa nó khỏi máy tính này. Bạn có thể thêm lại sau.
remove = Gỡ bỏ
log-out-title = Đăng xuất?
log-out-text = Đăng xuất khỏi { $tailnet }? Các địa chỉ của nó sẽ ngừng hoạt động trên máy này cho đến khi bạn đăng nhập lại.
log-out = Đăng xuất

## Tray (Windows, Linux) or menu bar (macOS) menu

tray-sign-in = { $tailnet }: đăng nhập…
tray-tailnet = { $tailnet }: { $state }
tray-add-tailnet = Thêm tailnet…
tray-route = Định tuyến qua các tailnet khác
tray-open = Mở { -app-name }…
tray-quit = Thoát
tray-tooltip = { -app-name }: { $summary }

## Notification the first time the window is closed

still-running-title = { -app-name } vẫn đang chạy
still-running-windows = Ứng dụng vẫn tiếp tục định tuyến trong nền. Bạn có thể tìm thấy nó trong khay hệ thống; Windows có thể ẩn nó dưới mũi tên ^ cạnh đồng hồ.
still-running-macos = Ứng dụng vẫn tiếp tục định tuyến trong nền. Bạn có thể tìm thấy nó trên thanh menu.
still-running-linux = Ứng dụng vẫn tiếp tục định tuyến trong nền. Bạn có thể tìm thấy nó trong khay hệ thống.

## Language names in Settings, after each language's own name

english = Tiếng Anh
french = Tiếng Pháp
german = Tiếng Đức
spanish-latin-america = Tiếng Tây Ban Nha (Mỹ Latinh)
spanish-spain = Tiếng Tây Ban Nha (Tây Ban Nha)
chinese-simplified = Tiếng Trung giản thể
chinese-traditional = Tiếng Trung phồn thể
korean = Tiếng Hàn
japanese = Tiếng Nhật
polish = Tiếng Ba Lan
russian = Tiếng Nga
portuguese-brazil = Tiếng Bồ Đào Nha (Brasil)
italian = Tiếng Ý
turkish = Tiếng Thổ Nhĩ Kỳ
ukrainian = Tiếng Ukraina
czech = Tiếng Séc
portuguese-portugal = Tiếng Bồ Đào Nha (Bồ Đào Nha)
dutch = Tiếng Hà Lan
indonesian = Tiếng Indonesia
vietnamese = Tiếng Việt
thai = Tiếng Thái
swedish = Tiếng Thụy Điển
romanian = Tiếng Romania
hungarian = Tiếng Hungary
afrikaans = Tiếng Afrikaans
catalan = Tiếng Catalan
serbian-cyrillic = Tiếng Serbia, Kirin
danish = Tiếng Đan Mạch
finnish = Tiếng Phần Lan
greek = Tiếng Hy Lạp
norwegian-bokmal = Tiếng Na Uy Bokmål
summary-proxy-problem = Đã kết nối, nhưng các ứng dụng của bạn không dùng kết nối này
hero-proxy-taken = Trình duyệt sẽ không mở được địa chỉ của các tailnet này: cài đặt proxy hệ thống đang dùng một tập lệnh thiết lập khác ({ $script }).
hero-proxy-other-copy = Trình duyệt sẽ không mở được địa chỉ của các tailnet này: một bản { -app-name } khác đang giữ cài đặt proxy hệ thống. Hãy thoát bản đó, bản này sẽ tiếp quản.
hero-proxy-changed = Trình duyệt sẽ không mở được địa chỉ của các tailnet này: một thứ khác đã thay đổi cài đặt proxy hệ thống.
hero-proxy-failed = Trình duyệt sẽ không mở được địa chỉ của các tailnet này: không thể thay đổi cài đặt proxy hệ thống ({ $error }).
hero-proxy-manual = Cài đặt proxy hệ thống đang tắt, nên chỉ những ứng dụng bạn tự thiết lập mới truy cập được các tailnet này. Hãy trỏ chúng tới { $pac }
proxy-replace = Thay thế
proxy-replace-tooltip = Dùng tập lệnh thiết lập của { -app-name } trong khi ứng dụng chạy, rồi khôi phục tập lệnh kia sau đó
proxy-retry = Thử lại
proxy-retry-tooltip = Trỏ lại cài đặt proxy hệ thống tới { -app-name }
system-setting = Cài đặt proxy hệ thống hiện tại: { $value }
system-setting-none = không có
check-updates = Kiểm tra phiên bản mới
find-websites = Tìm trang web trên các máy trong tailnet của bạn
tray-update = Tải xuống { -app-name } { $version }…
update-available = Đã có phiên bản { $version }
update-available-tooltip = Bạn đang dùng { $current }. Mở trang tải xuống.
update-notify-title = Đã có { -app-name } { $version }
update-notify-text = Mở { -app-name } để tải xuống.
migrate-failed = Không thể chuyển các phiên đăng nhập của bạn từ tailnet-proxy, phiên bản trước của ứng dụng này ({ $error }). Có lẽ nó vẫn đang chạy. Hãy thoát tailnet-proxy, rồi khởi động lại { -app-name } trước khi đăng nhập ở đây: đăng nhập lại sẽ thêm máy tính này vào mỗi tailnet lần thứ hai.
