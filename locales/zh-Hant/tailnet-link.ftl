### Tailnet Link：繁體中文目錄。
### 產品名稱 Tailnet Link、Tailscale 以及 Tailscale 的術語「tailnet」保持不變。

-app-name = Tailnet Link

## Window header

tab-tailnets = Tailnet
tab-settings = 設定

## Unsaved-changes bar at the bottom of Settings

unsaved-changes = 有尚未儲存的變更。
save = 儲存
revert = 還原
revert-tooltip = 復原變更
settings-saved = 設定已儲存

## Short notes at the bottom of the window

copied-address = 已複製 { $address }
copied-sign-in-link = 已複製登入連結

## Errors shown in the "Something went wrong" dialog

start-failed =
    { -app-name } 無法啟動：
    { $error }
add-tailnet-failed =
    無法新增 tailnet：
    { $error }
add-forward-failed =
    無法新增連接埠轉送：
    { $error }
remote-desktop-failed = 無法啟動遠端桌面：{ $error }
remote-desktop-windows-only = 只有 Windows 內建遠端桌面。
no-free-port = 找不到可用的本機連接埠。

## Dialog after "Add a tailnet"

sign-in-dialog-title = 登入新的 tailnet
sign-in-dialog-text =
    瀏覽器正在開啟 Tailscale 的登入頁面，它可能會出現在這個視窗後方。
    
    請使用該 tailnet 的帳號登入，然後回到這裡。系統會自動取得它的網域。

## One tailnet's state, shown as a coloured label beside its name

state-waiting-sign-in = 等待登入
state-signed-out = 已登出
state-problem = 發生問題
state-connecting = 連線中
state-paused = 已暫停
state-no-domain = 尚無網域
state-not-routing = 未路由
state-routing = 路由中

## The whole app's state, in the status card and the tray menu

summary-no-tailnets = 尚未新增 tailnet
summary-paused = 已暫停
summary-routing-one = 正透過 { $tailnet } 路由
summary-routing-all = 正透過 { $count } 個 tailnet 路由
summary-routing-some = 正透過 { $count } 個 tailnet 中的 { $routing } 個路由
summary-signed-out = 未登入
summary-problem = 問題：{ $problem }
summary-connecting = 連線中…
new-tailnet = 新的 tailnet

## Status card at the top of the Tailnets tab

hero-starting = 正在啟動…
hero-connecting = 正在連線到你的 tailnet。
hero-paused = 目前沒有任何流量經過其他 tailnet。你自己的網路和 tailnet 照常運作。
hero-finish-sign-in = 請在瀏覽器中完成 { $tailnet } 的登入。
hero-sign-in = 登入 { $tailnet } 即可連到其中的裝置。
hero-routing-example = 你可以開啟 { $address } 或這些 tailnet 中的任何其他位址。其餘流量一律直接連線。
hero-routing = 這些 tailnet 中的位址可直接在瀏覽器中開啟。其餘流量一律直接連線。
add-tailnet = 新增 tailnet
pause-all = 全部暫停
pause-all-tooltip = 暫時停止透過其他 tailnet 路由
resume = 恢復
resume-tooltip = 重新開始透過其他 tailnet 路由

## First run, before any tailnet is added

welcome-title = 連到其他 tailnet 中的裝置
welcome-text = 留在你自己的 tailnet，同時開啟其他 tailnet 中的裝置。你的 Tailscale 應用程式照常運作。
welcome-sign-in = 登入另一個 tailnet
welcome-sign-in-detail = Tailscale 的登入頁面會在瀏覽器中開啟。
welcome-open = 用名稱開啟裝置
welcome-open-detail = 像 { $example } 這樣的位址可直接在瀏覽器中使用。
welcome-forward = 應用程式需要時轉送連接埠
welcome-forward-detail = 遠端桌面、SSH 和資料庫應用程式會取得一個通往裝置的本機連接埠。

## A tailnet's card

machine-search-hint = 依名稱、作業系統或位址尋找裝置
clear-search = 清除搜尋
more-actions = 更多動作
edit-tailnet-menu = 重新命名或新增網域…
log-out-menu = 登出…
remove-menu = 移除…
sign-in = 登入
pause-tailnet = 暫停這個 tailnet
resume-tailnet = 恢復這個 tailnet
detail-tailnet = Tailnet
detail-routes = 路由
detail-this-computer = 這台電腦
detail-problem = 問題
routes-after-sign-in = 登入後取得
hostname-after-sign-in = { $hostname }（登入後）
sign-in-help = 瀏覽器沒有開啟，或開啟了錯誤的設定檔？
sign-in-open-again = 再次開啟登入頁面
sign-in-copy-link = 複製連結
sign-in-copy-link-tooltip = 貼到你用於這個 tailnet 的瀏覽器或瀏覽器設定檔中

## Machine list inside a tailnet's card

machines-online = 裝置 · { $total } 台中有 { $online } 台上線
machines-matching = 裝置 · { $total } 台中有 { $shown } 台符合
no-machines = 這個 tailnet 中看不到其他裝置。
no-machine-matches = 沒有符合搜尋的裝置。
machine-offline = { $name }（離線）
forward-port-tooltip = 轉送連接埠：適用於忽略代理伺服器設定的應用程式，例如遠端桌面或資料庫用戶端
copy-address = 複製 { $address }
open-in-browser = 在瀏覽器中開啟 { $url }
not-routing-tooltip = 這個 tailnet 目前沒有在路由。是否已暫停？

## Websites found on the machines

sites-heading = 網站
sites-help = 你的 tailnet 中透過 HTTPS 提供網站的裝置。每台裝置每天最多檢查一次。
# $done and $total count machines.
sites-checking = 正在檢查第 { $done } 台，共 { $total } 台…
sites-recheck-tooltip = 立即重新檢查所有裝置
site-untrusted = 它的憑證不受信任，因此瀏覽器會顯示警告。
site-favorite-add = 加入我的最愛
site-favorite-remove = 從我的最愛中移除
sites-show-all = 顯示所有網站（{ $count }）
sites-show-fewer = 收合

## Settings: port forwards

forwards-heading = 連接埠轉送
forwards-help = 適用於忽略代理伺服器設定的應用程式，例如遠端桌面、SSH 和資料庫用戶端。每個轉送都是這台電腦上的一個連接埠，會通往某個 tailnet 中的裝置。
edit-forwards = 編輯轉送
forwards-format-help = 每行一個：LOCALPORT = host:port，或寫 auto = host:port 自動挑選可用的連接埠。主機名稱決定經由哪個 tailnet。若要快速新增，請在「Tailnet」分頁中使用裝置旁的插頭按鈕。
forward-cant-listen = 無法監聽：{ $error }
forward-port-on-save = 儲存時會挑選連接埠
forward-no-tailnet = 沒有正在路由的 tailnet 符合這個名稱
forward-via = 經由 { $tailnet }
open-remote-desktop-to = 開啟到 { $address } 的遠端桌面

## Settings: system proxy

proxy-heading = 系統代理伺服器設定
proxy-on = 開啟（建議）
proxy-force = 開啟，並在執行期間取代公司設定的代理伺服器指令碼
proxy-off = 關閉：我會自己設定應用程式
proxy-help-windows = 「開啟」會讓 Windows 只在本應用程式執行並路由時套用它的規則，並在應用程式停止、暫停、中斷連線或當機時恢復原設定。
proxy-help-macos = 「開啟」會在應用程式執行期間為你的網路服務設定代理伺服器，之後再恢復原設定。如果你的 Mac 需要管理員密碼才能變更，系統會在開始路由和結束時要求你輸入。
proxy-help-linux = 「開啟」會在應用程式執行並路由期間設定 GNOME 或 KDE 的代理伺服器，之後再恢復原設定。在 Firefox 中，請開啟「設定 > 網路設定 > 使用系統代理伺服器設定」。

## Settings: general

general-heading = 一般
start-at-login = 登入時啟動 { -app-name }
language = 語言
system-default = 跟隨系統

## Settings: troubleshooting

troubleshooting-heading = 疑難排解
troubleshooting-help = 測試網址或「名稱:連接埠」，查看它經由哪個 tailnet，以及能否連線。
test = 測試
testing = 測試中…
open-log = 開啟記錄檔
open-settings-folder = 開啟設定資料夾
about-line = { -app-name } { $version } · 本機代理伺服器 { $proxy } · PAC { $pac }
settings-location = 設定位於 { $path }

## Results of "Test" in Troubleshooting

check-empty = 請輸入裝置名稱或網址。
check-bad-port = { $input }：不是有效的連接埠。
check-not-routed = { -app-name } 不會路由 { $host }：它不屬於任何正在路由之 tailnet 的網域，因此會直接連線（透過你的一般網路和你自己的 Tailscale）。
check-gone = 該 tailnet 剛剛消失了。
check-not-running = { $tailnet } 未在執行。
check-ok = { $address } 可正常使用：已經由 { $tailnet } 連線，耗時 { $ms } 毫秒。
check-failed =
    { $host } 經由 { $tailnet } 路由，但連線到連接埠 { $port } 失敗：{ $error }
    請確認該裝置在線上，且有程式在監聽該連接埠。
check-timeout = { $host } 經由 { $tailnet } 路由，但連接埠 { $port } 在 10 秒內沒有回應。
domain-conflict = { $domain } 也由 { $tailnet } 路由；以後者為準。

## Mistakes in typed settings

forwards-line-format = 第 { $line } 行：請寫成 LOCALPORT = host:port。
forwards-line-port = 第 { $line } 行：「{ $value }」不是連接埠號碼（或 auto）。
forwards-line-target = 第 { $line } 行：「{ $value }」應為 host:port。
forwards-line-duplicate = 第 { $line } 行：本機連接埠 { $port } 被使用了兩次。
domain-invalid = 「{ $domain }」不是網域；請使用類似 example.ts.net 的格式。
domain-characters = 「{ $domain }」包含網域不允許的字元。
autostart-unsupported = 此系統不支援登入時啟動。

## Dialogs

ok = 確定
cancel = 取消
done = 完成
copy = 複製
error-title = 發生錯誤
error-details = 詳細資訊位於 { $path }
edit-title = 編輯 { $tailnet }
tailnet-name = 名稱
tailnet-name-hint = 顯示在這個應用程式和系統匣選單中
extra-domains = 額外網域（選填）
extra-domains-help = tailnet 本身的網域會自動路由。每行新增一個。
forward-dialog-title = 轉送連接埠
forward-dialog-text = 在這台電腦上取得一個通往 { $host } 的連接埠。要連到那台裝置的哪個連接埠？
port-preset-remote-desktop = 遠端桌面
port-tooltip = 連接埠 { $port }
port = 連接埠
port-hint = 例如 8080
add-forward = 新增轉送
not-a-port = 「{ $value }」不是連接埠號碼（1-65535）。
forward-ready-title = 連接埠轉送已就緒
forward-ready-text = 將應用程式指向這個位址，即可連到 { $target }：
forward-ready-note = 連接埠會保持不變，你可以在「設定」中找到它。
open-remote-desktop = 開啟遠端桌面
remove-title = 要移除這個 tailnet 嗎？
remove-text = { -app-name } 會登出 { $tailnet }，並從這台電腦上移除它。你之後可以再新增回來。
remove = 移除
log-out-title = 要登出嗎？
log-out-text = 要登出 { $tailnet } 嗎？在你重新登入之前，它的位址在這台電腦上都無法使用。
log-out = 登出

## Tray (Windows, Linux) or menu bar (macOS) menu

tray-sign-in = { $tailnet }：登入…
tray-tailnet = { $tailnet }：{ $state }
tray-add-tailnet = 新增 tailnet…
tray-route = 透過其他 tailnet 路由
tray-open = 開啟 { -app-name }…
tray-quit = 結束
tray-tooltip = { -app-name }：{ $summary }

## Notification the first time the window is closed

still-running-title = { -app-name } 仍在執行
still-running-windows = 它會在背景繼續路由。你可以在系統匣中找到它；Windows 可能會把它收在時鐘旁的 ^ 箭號裡。
still-running-macos = 它會在背景繼續路由。你可以在選單列中找到它。
still-running-linux = 它會在背景繼續路由。你可以在系統匣中找到它。

## Language names in Settings, after each language's own name

english = 英文
french = 法文
german = 德文
spanish-latin-america = 西班牙文（拉丁美洲）
spanish-spain = 西班牙文（西班牙）
chinese-simplified = 簡體中文
chinese-traditional = 繁體中文
korean = 韓文
japanese = 日文
polish = 波蘭文
russian = 俄文
portuguese-brazil = 葡萄牙文（巴西）
italian = 義大利文
turkish = 土耳其文
ukrainian = 烏克蘭文
czech = 捷克文
portuguese-portugal = 葡萄牙葡萄牙文
dutch = 荷蘭文
indonesian = 印尼文
vietnamese = 越南文
thai = 泰文
swedish = 瑞典文
romanian = 羅馬尼亞文
hungarian = 匈牙利文
afrikaans = 南非荷蘭文
catalan = 加泰蘭文
serbian-cyrillic = 塞爾維亞文（西里爾文）
danish = 丹麥文
finnish = 芬蘭文
greek = 希臘文
norwegian-bokmal = 巴克摩挪威文
summary-proxy-problem = 已連線，但你的應用程式沒有使用
hero-proxy-taken = 瀏覽器無法開啟這些 tailnet 的位址：系統代理伺服器設定正在使用另一個設定指令碼（{ $script }）。
hero-proxy-other-copy = 瀏覽器無法開啟這些 tailnet 的位址：另一個 { -app-name } 正在使用系統代理伺服器設定。結束那一個之後，這一個就會接手。
hero-proxy-changed = 瀏覽器無法開啟這些 tailnet 的位址：其他程式變更了系統代理伺服器設定。
hero-proxy-failed = 瀏覽器無法開啟這些 tailnet 的位址：無法變更系統代理伺服器設定（{ $error }）。
hero-proxy-manual = 系統代理伺服器設定已關閉，因此只有你自己設定的應用程式才能連到這些 tailnet。請將它們指向 { $pac }
proxy-replace = 取代
proxy-replace-tooltip = 執行期間使用 { -app-name } 的設定指令碼，之後再恢復原本的指令碼
proxy-retry = 重試
proxy-retry-tooltip = 讓系統代理伺服器設定重新指向 { -app-name }
system-setting = 目前的系統代理伺服器設定：{ $value }
system-setting-none = 無
check-updates = 檢查新版本
find-websites = 在你的 tailnet 裝置上尋找網站
# $version is the version that's running, such as 0.6.0.
version-current = 版本 { $version }
update-check-now = 立即檢查
update-checking = 正在檢查…
update-up-to-date = 已是最新版本
update-check-failed = 無法檢查更新
tray-update = 下載 { -app-name } { $version }…
update-available = { $version } 版已推出
update-available-tooltip = 你目前的版本是 { $current }。開啟下載頁面。
update-notify-title = { -app-name } { $version } 已推出
update-notify-text = 開啟 { -app-name } 即可下載。
migrate-failed = 無法移轉你在 tailnet-proxy（本應用程式的舊版）中的登入資訊（{ $error }）。它可能仍在執行。請結束 tailnet-proxy，然後在這裡登入之前重新啟動 { -app-name }：再次登入會把這台電腦第二次加入每個 tailnet。
