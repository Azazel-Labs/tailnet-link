### Tailnet Link: 日本語カタログ。
### 製品名 Tailnet Link と Tailscale、および Tailscale の用語「tailnet」はそのまま使います。

-app-name = Tailnet Link

## Window header

tab-tailnets = Tailnet
tab-settings = 設定

## Unsaved-changes bar at the bottom of Settings

unsaved-changes = 保存されていない変更があります。
save = 保存
revert = 元に戻す
revert-tooltip = 変更を取り消します
settings-saved = 設定を保存しました

## Short notes at the bottom of the window

copied-address = { $address } をコピーしました
copied-sign-in-link = サインイン リンクをコピーしました

## Errors shown in the "Something went wrong" dialog

start-failed =
    { -app-name } を起動できません:
    { $error }
add-tailnet-failed =
    tailnet を追加できませんでした:
    { $error }
add-forward-failed =
    ポート転送を追加できませんでした:
    { $error }
remote-desktop-failed = リモート デスクトップを起動できませんでした: { $error }
remote-desktop-windows-only = リモート デスクトップが標準搭載されているのは Windows だけです。
no-free-port = 空いているローカル ポートが見つかりませんでした。

## Dialog after "Add a tailnet"

sign-in-dialog-title = 新しい tailnet にサインイン
sign-in-dialog-text =
    ブラウザーで Tailscale のサインイン ページを開いています。このウィンドウの後ろに表示される場合があります。
    
    その tailnet のアカウントでサインインしてから、ここに戻ってください。ドメインは自動的に取得されます。

## One tailnet's state, shown as a coloured label beside its name

state-waiting-sign-in = サインイン待ち
state-signed-out = サインアウト済み
state-problem = 問題あり
state-connecting = 接続中
state-paused = 一時停止中
state-no-domain = ドメイン未取得
state-not-routing = 未ルーティング
state-routing = ルーティング中

## The whole app's state, in the status card and the tray menu

summary-no-tailnets = tailnet はまだありません
summary-paused = 一時停止中
summary-routing-one = { $tailnet } 経由でルーティング中
summary-routing-all = { $count } 個の tailnet 経由でルーティング中
summary-routing-some = { $count } 個中 { $routing } 個の tailnet 経由でルーティング中
summary-signed-out = ログインしていません
summary-problem = 問題: { $problem }
summary-connecting = 接続中…
new-tailnet = 新しい tailnet

## Status card at the top of the Tailnets tab

hero-starting = 起動中…
hero-connecting = tailnet に接続しています。
hero-paused = 現在、他の tailnet を経由する通信はありません。自分のネットワークと tailnet は通常どおり使えます。
hero-finish-sign-in = ブラウザーで { $tailnet } へのサインインを完了してください。
hero-sign-in = { $tailnet } にサインインすると、そのマシンにアクセスできます。
hero-routing-example = { $address } をはじめ、これらの tailnet 内のアドレスを開けます。それ以外の通信は直接接続されます。
hero-routing = これらの tailnet 内のアドレスをブラウザーで開けます。それ以外の通信は直接接続されます。
add-tailnet = tailnet を追加
pause-all = すべて一時停止
pause-all-tooltip = 他の tailnet 経由のルーティングを一時的に停止します
resume = 再開
resume-tooltip = 他の tailnet 経由のルーティングを再開します

## First run, before any tailnet is added

welcome-title = 他の tailnet のマシンにアクセス
welcome-text = 自分の tailnet に接続したまま、他の tailnet のマシンも同時に開けます。Tailscale アプリはこれまでどおり動作します。
welcome-sign-in = 別の tailnet にサインイン
welcome-sign-in-detail = Tailscale のサインイン ページがブラウザーで開きます。
welcome-open = マシンを名前で開く
welcome-open-detail = { $example } のようなアドレスがブラウザーで使えます。
welcome-forward = 必要に応じてポートを転送
welcome-forward-detail = リモート デスクトップ、SSH、データベース アプリには、マシンにつながるローカル ポートが割り当てられます。

## A tailnet's card

machine-search-hint = 名前、OS、アドレスでマシンを検索
clear-search = 検索をクリア
open-terminal-tooltip = tailnet の名前が使えるターミナルを開きます (curl、git、ssh、ping など)。どのターミナルでも、コマンドの前に tl を付けて実行することもできます。
open-terminal-missing = { -app-name } のターミナル ヘルパーである tl がアプリと同じ場所に見つかりません。{ -app-name } を再インストールして入手してください。
open-terminal-failed = ターミナルを開けませんでした: { $error }
more-actions = その他の操作
edit-tailnet-menu = 名前の変更・ドメインの追加…
log-out-menu = ログアウト…
remove-menu = 削除…
sign-in = サインイン
pause-tailnet = この tailnet を一時停止
resume-tailnet = この tailnet を再開
detail-tailnet = Tailnet
detail-routes = ルート
detail-this-computer = このコンピューター
detail-problem = 問題
routes-after-sign-in = サインイン後に取得されます
hostname-after-sign-in = { $hostname } (サインイン後)
sign-in-help = ブラウザーが開かない、または別のプロファイルで開きましたか?
sign-in-open-again = サインイン ページをもう一度開く
sign-in-copy-link = リンクをコピー
sign-in-copy-link-tooltip = この tailnet で使うブラウザー (またはブラウザーのプロファイル) に貼り付けてください

## Machine list inside a tailnet's card

machines-online = マシン · { $total } 台中 { $online } 台がオンライン
machines-matching = マシン · { $total } 台中 { $shown } 台が一致
no-machines = この tailnet には他のマシンが見当たりません。
no-machine-matches = 検索に一致するマシンはありません。
machine-offline = { $name } (オフライン)
forward-port-tooltip = ポートを転送: リモート デスクトップやデータベース クライアントなど、プロキシ設定を無視するアプリ向けです
copy-address = { $address } をコピー
open-in-browser = { $url } をブラウザーで開く
not-routing-tooltip = この tailnet は現在ルーティングしていません。一時停止していませんか?

## Websites found on the machines

sites-heading = Web サイト
sites-help = tailnet 内で HTTPS の Web サイトを提供しているマシンです。各マシンの確認は 1 日 1 回までです。
# $done and $total count machines.
sites-checking = 確認中 ({ $total } 台中 { $done } 台目)…
sites-recheck-tooltip = すべてのマシンを今すぐ再確認
site-untrusted = 証明書が信頼されていないため、ブラウザーに警告が表示されます。
site-favorite-add = お気に入りに追加
site-favorite-remove = お気に入りから削除
sites-show-all = すべてのウェブサイトを表示（{ $count }）
sites-show-fewer = 表示を減らす

## Settings: port forwards

forwards-heading = ポート転送
forwards-help = リモート デスクトップ、SSH、データベース クライアントなど、プロキシ設定を無視するアプリ向けです。各転送は、このコンピューター上のポートを tailnet 内のマシンにつなぎます。
edit-forwards = 転送を編集
forwards-format-help = 1 行に 1 つずつ、LOCALPORT = host:port と書きます。空いているポートを自動で選ぶには auto = host:port と書きます。どの tailnet を経由するかはホスト名で決まります。すばやく追加するには、「Tailnet」タブでマシンのプラグ ボタンを使います。
forward-cant-listen = 待ち受けできません: { $error }
forward-port-on-save = 保存時にポートが選ばれます
forward-no-tailnet = この名前に一致するルーティング中の tailnet はありません
forward-via = { $tailnet } 経由
open-remote-desktop-to = { $address } へのリモート デスクトップを開く

## Settings: system proxy

proxy-heading = システムのプロキシ設定
proxy-on = オン (推奨)
proxy-force = オン (実行中は会社が設定したプロキシ スクリプトも置き換える)
proxy-off = オフ: アプリは自分で設定する
proxy-help-windows = 「オン」にすると、このアプリが実行中でルーティングしている間だけ Windows がこのアプリのルールを使います。停止、一時停止、切断、クラッシュ時には元の設定に戻ります。
proxy-help-macos = 「オン」にすると、アプリの実行中はネットワーク サービスのプロキシを設定し、終了後に元に戻します。Mac で管理者パスワードが必要な場合は、ルーティングの開始時と終了時に入力を求められます。
proxy-help-linux = 「オン」にすると、アプリが実行中でルーティングしている間は GNOME または KDE のプロキシ設定を変更し、終了後に元に戻します。Firefox では、[設定] > [ネットワーク設定] で「システムのプロキシ設定を利用する」をオンにしてください。

## Settings: general

general-heading = 全般
start-at-login = ログイン時に { -app-name } を起動
language = 言語
system-default = システムの既定値

## Settings: troubleshooting

troubleshooting-heading = トラブルシューティング
troubleshooting-help = Web アドレスまたは「名前:ポート」をテストして、どの tailnet を経由するか、接続できるかを確認します。
test = テスト
testing = テスト中…
open-log = ログを開く
open-settings-folder = 設定フォルダーを開く
about-line = { -app-name } { $version } · ローカル プロキシ { $proxy } · PAC { $pac }
settings-location = 設定の保存先: { $path }

## Settings: names

names-heading = 名前
names-help = tailnet 内のアドレスに付ける独自の名前です (サブネット ルーターの背後にあるサーバーなど)。このコンピューター上のブラウザーとポート転送でのみ使えます。
edit-names = 名前を編集
# Keep "name = address" and the example as they are: they are what you type.
names-format-help = 1 行に 1 つずつ、name = address と書きます (例: wiki = 192.168.20.15)。アドレスには IP アドレスまたはマシン名を指定できます。http://wiki:8080/ のように、Web サイトが使うポートを付けて開きます。

## Results of "Test" in Troubleshooting

check-empty = マシン名または Web アドレスを入力してください。
check-bad-port = { $input }: 有効なポートではありません。
check-not-routed = { $host } は { -app-name } でルーティングされません。現在ルーティング中のどの tailnet の名前、アドレス、サブネットにも当てはまらないため、直接接続されます (通常のネットワークと自分の Tailscale を経由します)。
# $tailnets lists the tailnets, separated by commas.
check-ambiguous = { $host } は複数の tailnet ({ $tailnets }) に含まれるため、ルーティングされません。代わりにマシン名を使うか、いずれかの tailnet でサブネットをオフにしてください。
check-gone = その tailnet はたった今なくなりました。
check-not-running = { $tailnet } は実行されていません。
ping-no-machine = { $host } は { $tailnet } を経由しますが、その tailnet のマシンではないため、Tailscale で ping する対象がありません。
check-ok = { $address } に接続できました: { $tailnet } 経由、{ $ms } ms。
check-failed =
    { $host } は { $tailnet } 経由でルーティングされますが、ポート { $port } への接続に失敗しました: { $error }
    マシンがオンラインで、そのポートで待ち受けているサービスがあるか確認してください。
check-timeout = { $host } は { $tailnet } 経由でルーティングされますが、ポート { $port } から 10 秒以内に応答がありませんでした。
domain-conflict = { $domain } は { $tailnet } でもルーティングされています。そちらが優先されます。

## Mistakes in typed settings

forwards-line-format = { $line } 行目: LOCALPORT = host:port の形式で書いてください。
forwards-line-port = { $line } 行目: 「{ $value }」はポート番号 (または auto) ではありません。
forwards-line-target = { $line } 行目: 「{ $value }」は host:port の形式にしてください。
forwards-line-duplicate = { $line } 行目: ローカル ポート { $port } が 2 回使われています。
domain-invalid = 「{ $domain }」はドメインではありません。example.ts.net のような形式で入力してください。
domain-characters = 「{ $domain }」にはドメインに使えない文字が含まれています。
names-line-format = { $line } 行目: name = address の形式で書いてください。
names-line-name = { $line } 行目: 「{ $value }」は名前に使えません。英字、数字、ハイフン、ドットを使ってください。
names-line-target = { $line } 行目: 「{ $value }」は IP アドレスでもマシン名でもありません。
names-line-duplicate = { $line } 行目: 名前 { $value } が 2 回使われています。
autostart-unsupported = このシステムではログイン時の起動はサポートされていません。

## Dialogs

ok = OK
cancel = キャンセル
done = 完了
copy = コピー
error-title = 問題が発生しました
error-details = 詳細は { $path } にあります
edit-title = { $tailnet } を編集
tailnet-name = 名前
tailnet-name-hint = このアプリとトレイ メニューに表示されます
extra-domains = 追加のドメイン (省略可)
extra-domains-help = tailnet 自体のドメインは自動的にルーティングされます。1 行に 1 つずつ追加してください。
route-subnets = サブネットをルーティング
route-subnets-help = この tailnet がサブネット ルーター経由で到達するネットワーク (クラウド ネットワークなど) です。このコンピューターが接続しているネットワークと重なる場合はオフにしてください。
forward-dialog-title = ポートを転送
forward-dialog-text = このコンピューター上に、{ $host } につながるポートを用意します。そのマシンのどのポートに接続しますか?
port-preset-remote-desktop = リモート デスクトップ
port-tooltip = ポート { $port }
port = ポート
port-hint = 例: 8080
add-forward = 転送を追加
not-a-port = 「{ $value }」はポート番号 (1-65535) ではありません。
forward-ready-title = ポート転送の準備ができました
forward-ready-text = { $target } にアクセスするには、アプリでこのアドレスを指定してください:
forward-ready-note = ポートは変わりません。[設定] でいつでも確認できます。
open-remote-desktop = リモート デスクトップを開く
remove-title = この tailnet を削除しますか?
remove-text = { -app-name } は { $tailnet } からログアウトし、このコンピューターからその情報を削除します。後でもう一度追加できます。
remove = 削除
log-out-title = ログアウトしますか?
log-out-text = { $tailnet } からログアウトしますか? 再びサインインするまで、このコンピューターではそのアドレスが使えなくなります。
log-out = ログアウト

## Tray (Windows, Linux) or menu bar (macOS) menu

tray-sign-in = { $tailnet }: サインイン…
tray-tailnet = { $tailnet }: { $state }
tray-add-tailnet = tailnet を追加…
tray-route = 他の tailnet 経由でルーティング
tray-open = { -app-name } を開く…
tray-quit = 終了
tray-tooltip = { -app-name }: { $summary }

## Notification the first time the window is closed

still-running-title = { -app-name } は実行中です
still-running-windows = バックグラウンドでルーティングを続けます。システム トレイから開けます。Windows では時計の横にある ^ 矢印の中に隠れている場合があります。
still-running-macos = バックグラウンドでルーティングを続けます。メニュー バーから開けます。
still-running-linux = バックグラウンドでルーティングを続けます。システム トレイから開けます。

## Language names in Settings, after each language's own name

english = 英語
french = フランス語
german = ドイツ語
spanish-latin-america = スペイン語（ラテンアメリカ）
spanish-spain = スペイン語（スペイン）
chinese-simplified = 中国語（簡体字）
chinese-traditional = 中国語（繁体字）
korean = 韓国語
japanese = 日本語
polish = ポーランド語
russian = ロシア語
portuguese-brazil = ポルトガル語（ブラジル）
italian = イタリア語
turkish = トルコ語
ukrainian = ウクライナ語
czech = チェコ語
portuguese-portugal = ポルトガルのポルトガル語
dutch = オランダ語
indonesian = インドネシア語
vietnamese = ベトナム語
thai = タイ語
swedish = スウェーデン語
romanian = ルーマニア語
hungarian = ハンガリー語
afrikaans = アフリカーンス語
catalan = カタロニア語
serbian-cyrillic = セルビア語（キリル文字）
danish = デンマーク語
finnish = フィンランド語
greek = ギリシャ語
norwegian-bokmal = ノルウェー語（ブークモール）
summary-proxy-problem = 接続済みですが、アプリが使用していません
hero-proxy-taken = ブラウザーでこれらの tailnet のアドレスを開けません。システムのプロキシ設定が別のセットアップ スクリプト ({ $script }) を使っています。
hero-proxy-other-copy = ブラウザーでこれらの tailnet のアドレスを開けません。別の { -app-name } がシステムのプロキシ設定を使っています。そちらを終了すると、こちらが引き継ぎます。
hero-proxy-changed = ブラウザーでこれらの tailnet のアドレスを開けません。システムのプロキシ設定が他のプログラムによって変更されました。
hero-proxy-failed = ブラウザーでこれらの tailnet のアドレスを開けません。システムのプロキシ設定を変更できませんでした ({ $error })。
hero-proxy-manual = システムのプロキシ設定がオフのため、これらの tailnet にアクセスできるのは自分で設定したアプリだけです。アプリで次のアドレスを指定してください: { $pac }
proxy-replace = 置き換える
proxy-replace-tooltip = 実行中は { -app-name } のセットアップ スクリプトを使い、終了後に元のスクリプトに戻します
proxy-retry = 再試行
proxy-retry-tooltip = システムのプロキシ設定をもう一度 { -app-name } に向けます
system-setting = 現在のシステムのプロキシ設定: { $value }
system-setting-none = なし
check-updates = 新しいバージョンを確認
find-websites = tailnet 内のマシンで Web サイトを探す
# $version is the version that's running, such as 0.6.0.
version-current = バージョン { $version }
update-check-now = 今すぐ確認
update-checking = 確認中…
update-up-to-date = 最新バージョンです
update-check-failed = 更新を確認できませんでした
tray-update = { -app-name } { $version } をダウンロード…
update-available = バージョン { $version } 公開
update-available-tooltip = 現在のバージョンは { $current } です。ダウンロード ページを開きます。
update-notify-title = { -app-name } { $version } が利用可能です
update-notify-text = { -app-name } を開いてダウンロードしてください。
migrate-failed = このアプリの以前のバージョンである tailnet-proxy からサインイン情報を移行できませんでした ({ $error })。tailnet-proxy がまだ実行中の可能性があります。tailnet-proxy を終了し、ここでサインインする前に { -app-name } を再起動してください。もう一度サインインすると、このコンピューターが各 tailnet に二重に追加されます。
