### Tailnet Link：简体中文目录。
### 产品名称 Tailnet Link、Tailscale 以及 Tailscale 的术语“tailnet”保持不变。

-app-name = Tailnet Link

## Window header

tab-tailnets = Tailnet
tab-settings = 设置

## Unsaved-changes bar at the bottom of Settings

unsaved-changes = 有未保存的更改。
save = 保存
revert = 还原
revert-tooltip = 撤消更改
settings-saved = 设置已保存

## Short notes at the bottom of the window

copied-address = 已复制 { $address }
copied-sign-in-link = 已复制登录链接

## Errors shown in the "Something went wrong" dialog

start-failed =
    { -app-name } 无法启动：
    { $error }
add-tailnet-failed =
    无法添加 tailnet：
    { $error }
add-forward-failed =
    无法添加端口转发：
    { $error }
remote-desktop-failed = 无法启动远程桌面：{ $error }
remote-desktop-windows-only = 只有 Windows 内置远程桌面。
no-free-port = 找不到空闲的本地端口。

## Dialog after "Add a tailnet"

sign-in-dialog-title = 登录新的 tailnet
sign-in-dialog-text =
    浏览器正在打开 Tailscale 的登录页面，它可能出现在此窗口后面。
    
    请用该 tailnet 的账户登录，然后回到这里。其域名会自动获取。

## One tailnet's state, shown as a coloured label beside its name

state-waiting-sign-in = 等待登录
state-signed-out = 已退出登录
state-problem = 有问题
state-connecting = 正在连接
state-paused = 已暂停
state-no-domain = 尚无域名
state-not-routing = 未路由
state-routing = 路由中

## The whole app's state, in the status card and the tray menu

summary-no-tailnets = 还没有 tailnet
summary-paused = 已暂停
summary-routing-one = 正在通过 { $tailnet } 路由
summary-routing-all = 正在通过 { $count } 个 tailnet 路由
summary-routing-some = 正在通过 { $count } 个 tailnet 中的 { $routing } 个路由
summary-signed-out = 未登录
summary-problem = 问题：{ $problem }
summary-connecting = 正在连接…
new-tailnet = 新 tailnet

## Status card at the top of the Tailnets tab

hero-starting = 正在启动…
hero-connecting = 正在连接到你的 tailnet。
hero-paused = 目前没有流量经过其他 tailnet。你自己的网络和 tailnet 照常工作。
hero-finish-sign-in = 请在浏览器中完成 { $tailnet } 的登录。
hero-sign-in = 登录 { $tailnet } 即可访问其中的设备。
hero-routing-example = 可以打开 { $address } 或这些 tailnet 中的任何其他地址。其他流量一律直连。
hero-routing = 这些 tailnet 中的地址可直接在浏览器中打开。其他流量一律直连。
add-tailnet = 添加 tailnet
pause-all = 全部暂停
pause-all-tooltip = 暂时停止通过其他 tailnet 路由
resume = 恢复
resume-tooltip = 重新开始通过其他 tailnet 路由

## First run, before any tailnet is added

welcome-title = 访问其他 tailnet 中的设备
welcome-text = 留在你自己的 tailnet 上，同时打开其他 tailnet 中的设备。你的 Tailscale 应用照常工作。
welcome-sign-in = 登录另一个 tailnet
welcome-sign-in-detail = Tailscale 的登录页面会在浏览器中打开。
welcome-open = 按名称打开设备
welcome-open-detail = 像 { $example } 这样的地址可以直接在浏览器中使用。
welcome-forward = 应用需要时转发端口
welcome-forward-detail = 远程桌面、SSH 和数据库应用会获得一个通往设备的本地端口。

## A tailnet's card

machine-search-hint = 按名称、操作系统或地址查找设备
clear-search = 清除搜索
more-actions = 更多操作
edit-tailnet-menu = 重命名或添加域名…
log-out-menu = 退出登录…
remove-menu = 移除…
sign-in = 登录
pause-tailnet = 暂停此 tailnet
resume-tailnet = 恢复此 tailnet
detail-tailnet = Tailnet
detail-routes = 路由
detail-this-computer = 本机
detail-problem = 问题
routes-after-sign-in = 登录后获取
hostname-after-sign-in = { $hostname }（登录后）
sign-in-help = 浏览器没有打开，或打开了错误的配置文件？
sign-in-open-again = 重新打开登录页面
sign-in-copy-link = 复制链接
sign-in-copy-link-tooltip = 粘贴到你用于此 tailnet 的浏览器或浏览器配置文件中

## Machine list inside a tailnet's card

machines-online = 设备 · { $total } 台中 { $online } 台在线
machines-matching = 设备 · { $total } 台中 { $shown } 台匹配
no-machines = 此 tailnet 中没有其他可见设备。
no-machine-matches = 没有与搜索匹配的设备。
machine-offline = { $name }（离线）
forward-port-tooltip = 转发端口：适用于忽略代理设置的应用，例如远程桌面或数据库客户端
copy-address = 复制 { $address }
open-in-browser = 在浏览器中打开 { $url }
not-routing-tooltip = 此 tailnet 目前未在路由。是否已暂停？

## Settings: port forwards

forwards-heading = 端口转发
forwards-help = 适用于忽略代理设置的应用，例如远程桌面、SSH 和数据库客户端。每个转发都是本机上的一个端口，通往某个 tailnet 中的设备。
edit-forwards = 编辑转发
forwards-format-help = 每行一个：LOCALPORT = host:port，或写 auto = host:port 自动选择空闲端口。主机名决定经过哪个 tailnet。要快速添加，请在“Tailnet”选项卡中使用设备旁的插头按钮。
forward-cant-listen = 无法监听：{ $error }
forward-port-on-save = 保存时选择端口
forward-no-tailnet = 没有正在路由的 tailnet 使用此名称
forward-via = 经由 { $tailnet }
open-remote-desktop-to = 打开到 { $address } 的远程桌面

## Settings: system proxy

proxy-heading = 系统代理设置
proxy-on = 开启（推荐）
proxy-force = 开启，并在运行时替换公司设置的代理脚本
proxy-off = 关闭：我自己配置应用
proxy-help-windows = “开启”后，仅在本应用运行并路由时让 Windows 使用本应用的规则；当它停止、暂停、断开连接或崩溃时，会恢复原设置。
proxy-help-macos = “开启”后，会在应用运行期间为你的网络服务设置代理，之后再恢复原设置。如果你的 Mac 需要管理员密码才能更改，会在开始路由和退出时提示你输入。
proxy-help-linux = “开启”后，会在应用运行并路由期间设置 GNOME 或 KDE 的代理，之后再恢复原设置。在 Firefox 中，请开启“设置 > 网络设置 > 使用系统代理设置”。

## Settings: general

general-heading = 常规
start-at-login = 登录时启动 { -app-name }
language = 语言
system-default = 跟随系统

## Settings: troubleshooting

troubleshooting-heading = 故障排除
troubleshooting-help = 测试一个网址或“名称:端口”，查看它经过哪个 tailnet 以及能否连接。
test = 测试
testing = 正在测试…
open-log = 打开日志
open-settings-folder = 打开设置文件夹
about-line = { -app-name } { $version } · 本地代理 { $proxy } · PAC { $pac }
settings-location = 设置位于 { $path }

## Results of "Test" in Troubleshooting

check-empty = 请输入设备名称或网址。
check-bad-port = { $input }：不是有效的端口。
check-not-routed = { -app-name } 不会路由 { $host }：它不以任何正在路由的 tailnet 的域名结尾，因此会直连（经过你的普通网络和你自己的 Tailscale）。
check-gone = 该 tailnet 刚刚消失了。
check-not-running = { $tailnet } 未在运行。
check-ok = { $address } 可用：已经由 { $tailnet } 连接，用时 { $ms } 毫秒。
check-failed =
    { $host } 经由 { $tailnet } 路由，但连接端口 { $port } 失败：{ $error }
    请检查该设备是否在线，以及是否有程序在监听该端口。
check-timeout = { $host } 经由 { $tailnet } 路由，但端口 { $port } 在 10 秒内没有响应。
domain-conflict = { $domain } 也由 { $tailnet } 路由；以后者为准。

## Mistakes in typed settings

forwards-line-format = 第 { $line } 行：请写成 LOCALPORT = host:port。
forwards-line-port = 第 { $line } 行：“{ $value }”不是端口号（或 auto）。
forwards-line-target = 第 { $line } 行：“{ $value }”应为 host:port。
forwards-line-duplicate = 第 { $line } 行：本地端口 { $port } 被使用了两次。
domain-invalid = “{ $domain }”不是域名；请使用类似 example.ts.net 的格式。
domain-characters = “{ $domain }”包含域名中不允许的字符。
autostart-unsupported = 此系统不支持登录时启动。

## Dialogs

ok = 确定
cancel = 取消
done = 完成
copy = 复制
error-title = 出错了
error-details = 详细信息位于 { $path }
edit-title = 编辑 { $tailnet }
tailnet-name = 名称
tailnet-name-hint = 显示在此应用和托盘菜单中
extra-domains = 额外域名（可选）
extra-domains-help = tailnet 自身的域名会自动路由。每行添加一个。
forward-dialog-title = 转发端口
forward-dialog-text = 在本机上获得一个通往 { $host } 的端口。要连接那台设备的哪个端口？
port-preset-remote-desktop = 远程桌面
port-tooltip = 端口 { $port }
port = 端口
port-hint = 例如 8080
add-forward = 添加转发
not-a-port = “{ $value }”不是端口号（1-65535）。
forward-ready-title = 端口转发已就绪
forward-ready-text = 在应用中使用此地址即可访问 { $target }：
forward-ready-note = 端口保持不变，你可以在“设置”中找到它。
open-remote-desktop = 打开远程桌面
remove-title = 移除此 tailnet？
remove-text = { -app-name } 将退出 { $tailnet } 的登录，并在本机上删除它。之后你可以重新添加。
remove = 移除
log-out-title = 退出登录？
log-out-text = 要退出 { $tailnet } 的登录吗？重新登录之前，它的地址在本机上将无法使用。
log-out = 退出登录

## Tray (Windows, Linux) or menu bar (macOS) menu

tray-sign-in = { $tailnet }：登录…
tray-tailnet = { $tailnet }：{ $state }
tray-add-tailnet = 添加 tailnet…
tray-route = 通过其他 tailnet 路由
tray-open = 打开 { -app-name }…
tray-quit = 退出
tray-tooltip = { -app-name }：{ $summary }

## Notification the first time the window is closed

still-running-title = { -app-name } 仍在运行
still-running-windows = 它会在后台继续路由。可以在系统托盘中找到它；Windows 可能会把它收在时钟旁的 ^ 箭头里。
still-running-macos = 它会在后台继续路由。可以在菜单栏中找到它。
still-running-linux = 它会在后台继续路由。可以在系统托盘中找到它。

## Language names in Settings, after each language's own name

english = 英语
french = 法语
german = 德语
spanish-latin-america = 西班牙语（拉丁美洲）
spanish-spain = 西班牙语（西班牙）
chinese-simplified = 简体中文
chinese-traditional = 繁体中文
korean = 韩语
japanese = 日语
polish = 波兰语
russian = 俄语
portuguese-brazil = 葡萄牙语（巴西）
italian = 意大利语
turkish = 土耳其语
ukrainian = 乌克兰语
czech = 捷克语
portuguese-portugal = 葡萄牙葡萄牙语
dutch = 荷兰语
indonesian = 印度尼西亚语
vietnamese = 越南语
thai = 泰语
swedish = 瑞典语
romanian = 罗马尼亚语
hungarian = 匈牙利语
afrikaans = 南非荷兰语
catalan = 加泰罗尼亚语
serbian-cyrillic = 塞尔维亚语（西里尔文）
danish = 丹麦语
finnish = 芬兰语
greek = 希腊语
norwegian-bokmal = 书面挪威语
