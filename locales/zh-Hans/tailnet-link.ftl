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
open-terminal-tooltip = 打开一个可以使用你的 tailnet 中名称的终端，适用于 curl、git、ssh、ping 等。也可以在任意终端中，在任意命令前加上 tl。
open-terminal-missing = { -app-name } 在应用旁边找不到它的终端辅助程序 tl。请重新安装 { -app-name } 以获取它。
open-terminal-failed = 无法打开终端：{ $error }
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

## Websites found on the machines

sites-heading = 网站
sites-help = 你的 tailnet 中通过 HTTPS 提供网站的设备。每台设备每天最多检查一次。
# $done and $total count machines.
sites-checking = 正在检查第 { $done } 台，共 { $total } 台…
sites-recheck-tooltip = 立即重新检查所有设备
site-untrusted = 它的证书不受信任，因此浏览器会显示警告。
site-favorite-add = 添加到收藏
site-favorite-remove = 从收藏中移除
sites-show-all = 显示所有网站（{ $count }）
sites-show-fewer = 收起

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

## Settings: names

names-heading = 名称
names-help = 为 tailnet 中的地址自定义名称，例如子网路由器后面的服务器。这些名称只在本机的浏览器和端口转发中有效。
edit-names = 编辑名称
# Keep "name = address" and the example as they are: they are what you type.
names-format-help = 每行一个：name = address，例如 wiki = 192.168.20.15。地址可以是 IP 地址或设备名称。打开时使用 http://wiki:8080/ 这样的地址，并带上网站使用的端口。

## Results of "Test" in Troubleshooting

check-empty = 请输入设备名称或网址。
check-bad-port = { $input }：不是有效的端口。
check-not-routed = { -app-name } 不会路由 { $host }：它不是任何正在路由的 tailnet 的名称、地址或子网，因此会直连（经过你的普通网络和你自己的 Tailscale）。
# $tailnets lists the tailnets, separated by commas.
check-ambiguous = { $host } 位于多个 tailnet 中（{ $tailnets }），因此不会被路由。请改用设备名称，或为其中一个 tailnet 关闭子网。
check-gone = 该 tailnet 刚刚消失了。
check-not-running = { $tailnet } 未在运行。
ping-no-machine = { $host } 经由 { $tailnet }，但它不是该 tailnet 中的设备，因此 Tailscale 没有可以 ping 的对象。
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
names-line-format = 第 { $line } 行：请写成 name = address。
names-line-name = 第 { $line } 行：“{ $value }”不能用作名称。请使用字母、数字、连字符和点。
names-line-target = 第 { $line } 行：“{ $value }”不是 IP 地址或设备名称。
names-line-duplicate = 第 { $line } 行：名称 { $value } 出现了两次。
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
route-subnets = 路由其子网
route-subnets-help = 此 tailnet 通过其子网路由器访问的网络，例如云网络。如果其中某个网络与本机所在的网络重叠，请关闭此项。
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
summary-proxy-problem = 已连接，但你的应用没有使用它
hero-proxy-taken = 浏览器无法打开这些 tailnet 的地址：系统代理设置正在使用另一个配置脚本（{ $script }）。
hero-proxy-other-copy = 浏览器无法打开这些 tailnet 的地址：另一个 { -app-name } 副本占用了系统代理设置。退出那个副本后，这个副本会接管。
hero-proxy-changed = 浏览器无法打开这些 tailnet 的地址：其他程序更改了系统代理设置。
hero-proxy-failed = 浏览器无法打开这些 tailnet 的地址：无法更改系统代理设置（{ $error }）。
hero-proxy-manual = 系统代理设置已关闭，因此只有你自己配置的应用才能访问这些 tailnet。请将它们指向 { $pac }
proxy-replace = 替换
proxy-replace-tooltip = 运行期间使用 { -app-name } 的配置脚本，之后再恢复原来的脚本
proxy-retry = 重试
proxy-retry-tooltip = 让系统代理设置重新指向 { -app-name }
system-setting = 当前系统代理设置：{ $value }
system-setting-none = 无
check-updates = 检查新版本
find-websites = 在你的 tailnet 设备上查找网站
# $version is the version that's running, such as 0.6.0.
version-current = 版本 { $version }
update-check-now = 立即检查
update-checking = 正在检查…
update-up-to-date = 已是最新版本
update-check-failed = 无法检查更新
tray-update = 下载 { -app-name } { $version }…
update-available = { $version } 版已发布
update-available-tooltip = 你当前的版本是 { $current }。打开下载页面。
update-notify-title = { -app-name } { $version } 已发布
update-notify-text = 打开 { -app-name } 即可下载。
migrate-failed = 无法迁移你在 tailnet-proxy（本应用的旧版本）中的登录信息（{ $error }）。它可能仍在运行。请退出 tailnet-proxy，然后在此处登录之前重新启动 { -app-name }：再次登录会把这台电脑第二次添加到每个 tailnet。
