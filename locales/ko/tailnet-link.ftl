### Tailnet Link: 한국어 카탈로그.
### 제품 이름 Tailnet Link, Tailscale과 Tailscale 용어 "tailnet"은 그대로 둡니다.

-app-name = Tailnet Link

## Window header

tab-tailnets = Tailnet
tab-settings = 설정

## Unsaved-changes bar at the bottom of Settings

unsaved-changes = 저장하지 않은 변경 사항이 있습니다.
save = 저장
revert = 되돌리기
revert-tooltip = 변경 사항을 취소합니다
settings-saved = 설정을 저장했습니다

## Short notes at the bottom of the window

copied-address = { $address } 복사됨
copied-sign-in-link = 로그인 링크를 복사했습니다

## Errors shown in the "Something went wrong" dialog

start-failed =
    { -app-name }를 시작할 수 없습니다:
    { $error }
add-tailnet-failed =
    tailnet을 추가할 수 없습니다:
    { $error }
add-forward-failed =
    포트 포워딩을 추가할 수 없습니다:
    { $error }
remote-desktop-failed = 원격 데스크톱을 시작할 수 없습니다: { $error }
remote-desktop-windows-only = 원격 데스크톱은 Windows에만 기본 제공됩니다.
no-free-port = 사용 가능한 로컬 포트를 찾을 수 없습니다.

## Dialog after "Add a tailnet"

sign-in-dialog-title = 새 tailnet에 로그인
sign-in-dialog-text =
    브라우저에서 Tailscale 로그인 페이지를 여는 중입니다. 이 창 뒤에 열릴 수도 있습니다.
    
    해당 tailnet의 계정으로 로그인한 다음 여기로 돌아오세요. 도메인은 자동으로 감지됩니다.

## One tailnet's state, shown as a coloured label beside its name

state-waiting-sign-in = 로그인 대기 중
state-signed-out = 로그아웃됨
state-problem = 문제 있음
state-connecting = 연결 중
state-paused = 일시 중지됨
state-no-domain = 도메인 없음
state-not-routing = 라우팅 안 함
state-routing = 라우팅 중

## The whole app's state, in the status card and the tray menu

summary-no-tailnets = 아직 tailnet이 없습니다
summary-paused = 일시 중지됨
summary-routing-one = { $tailnet } 경유 라우팅 중
summary-routing-all = tailnet { $count }개를 통해 라우팅 중
summary-routing-some = tailnet { $count }개 중 { $routing }개를 통해 라우팅 중
summary-signed-out = 로그인하지 않음
summary-problem = 문제: { $problem }
summary-connecting = 연결 중…
new-tailnet = 새 tailnet

## Status card at the top of the Tailnets tab

hero-starting = 시작하는 중…
hero-connecting = tailnet에 연결하는 중입니다.
hero-paused = 지금은 다른 tailnet을 거치는 트래픽이 없습니다. 내 네트워크와 tailnet은 평소처럼 작동합니다.
hero-finish-sign-in = 브라우저에서 { $tailnet } 로그인을 완료하세요.
hero-sign-in = { $tailnet }의 머신에 접속하려면 로그인하세요.
hero-routing-example = { $address } 등 이 tailnet들에 있는 주소를 바로 열 수 있습니다. 나머지는 모두 직접 연결됩니다.
hero-routing = 이 tailnet들에 있는 주소가 브라우저에서 열립니다. 나머지는 모두 직접 연결됩니다.
add-tailnet = tailnet 추가
pause-all = 모두 일시 중지
pause-all-tooltip = 다른 tailnet을 통한 라우팅을 잠시 중지합니다
resume = 재개
resume-tooltip = 다른 tailnet을 통한 라우팅을 다시 시작합니다

## First run, before any tailnet is added

welcome-title = 다른 tailnet의 머신에 접속하세요
welcome-text = 내 tailnet에 연결된 채로 다른 tailnet의 머신도 동시에 열 수 있습니다. Tailscale 앱은 평소처럼 계속 작동합니다.
welcome-sign-in = 다른 tailnet에 로그인
welcome-sign-in-detail = 브라우저에서 Tailscale 로그인 페이지가 열립니다.
welcome-open = 이름으로 머신 열기
welcome-open-detail = { $example } 같은 주소를 브라우저에서 바로 사용할 수 있습니다.
welcome-forward = 앱에 필요하면 포트 포워딩
welcome-forward-detail = 원격 데스크톱, SSH, 데이터베이스 앱에 머신으로 이어지는 로컬 포트가 제공됩니다.

## A tailnet's card

machine-search-hint = 이름, OS 또는 주소로 머신 찾기
clear-search = 검색 지우기
more-actions = 추가 작업
edit-tailnet-menu = 이름 변경 또는 도메인 추가…
log-out-menu = 로그아웃…
remove-menu = 제거…
sign-in = 로그인
pause-tailnet = 이 tailnet 일시 중지
resume-tailnet = 이 tailnet 재개
detail-tailnet = Tailnet
detail-routes = 경로
detail-this-computer = 이 컴퓨터
detail-problem = 문제
routes-after-sign-in = 로그인 후 확인됩니다
hostname-after-sign-in = { $hostname }(로그인 후)
sign-in-help = 브라우저가 열리지 않았거나 다른 프로필로 열렸나요?
sign-in-open-again = 로그인 페이지 다시 열기
sign-in-copy-link = 링크 복사
sign-in-copy-link-tooltip = 이 tailnet에 사용하는 브라우저나 브라우저 프로필에 붙여 넣으세요

## Machine list inside a tailnet's card

machines-online = 머신 · { $total }대 중 { $online }대 온라인
machines-matching = 머신 · { $total }대 중 { $shown }대 일치
no-machines = 이 tailnet에는 다른 머신이 보이지 않습니다.
no-machine-matches = 검색과 일치하는 머신이 없습니다.
machine-offline = { $name }(오프라인)
forward-port-tooltip = 포트 포워딩: 원격 데스크톱이나 데이터베이스 클라이언트처럼 프록시 설정을 무시하는 앱용
copy-address = { $address } 복사
open-in-browser = 브라우저에서 { $url } 열기
not-routing-tooltip = 이 tailnet은 지금 라우팅하고 있지 않습니다. 일시 중지되었나요?

## Websites found on the machines

sites-heading = 웹사이트
sites-help = tailnet에서 HTTPS로 웹사이트를 제공하는 머신입니다. 각 머신은 하루에 한 번까지만 확인합니다.
# $done and $total count machines.
sites-checking = { $total }대 중 { $done }번째 확인 중…
sites-recheck-tooltip = 지금 모든 머신 다시 확인
site-untrusted = 인증서를 신뢰할 수 없으므로 브라우저에 경고가 표시됩니다.
site-favorite-add = 즐겨찾기에 추가
site-favorite-remove = 즐겨찾기에서 제거
sites-show-all = 모든 웹사이트 보기({ $count })
sites-show-fewer = 간단히 보기

## Settings: port forwards

forwards-heading = 포트 포워딩
forwards-help = 원격 데스크톱, SSH, 데이터베이스 클라이언트처럼 프록시 설정을 무시하는 앱용입니다. 각 포워딩은 이 컴퓨터의 포트를 tailnet에 있는 머신으로 연결합니다.
edit-forwards = 포워딩 편집
forwards-format-help = 한 줄에 하나씩 LOCALPORT = host:port 형식으로 쓰고, 빈 포트를 자동으로 고르려면 auto = host:port로 씁니다. 어느 tailnet을 거칠지는 호스트 이름으로 정해집니다. 빠르게 추가하려면 Tailnet 탭에서 머신의 플러그 버튼을 사용하세요.
forward-cant-listen = 수신 대기할 수 없음: { $error }
forward-port-on-save = 저장할 때 포트가 선택됩니다
forward-no-tailnet = 이 이름으로 라우팅 중인 tailnet이 없습니다
forward-via = { $tailnet } 경유
open-remote-desktop-to = 원격 데스크톱으로 { $address } 열기

## Settings: system proxy

proxy-heading = 시스템 프록시 설정
proxy-on = 켜기(권장)
proxy-force = 켜기, 실행 중에는 회사에서 설정한 프록시 스크립트도 대체
proxy-off = 끄기: 앱은 직접 설정하겠습니다
proxy-help-windows = “켜기”를 선택하면 앱이 실행되어 라우팅하는 동안에만 Windows가 이 앱의 규칙을 사용하며, 앱이 중지, 일시 중지, 연결 해제되거나 비정상 종료되면 원래대로 되돌립니다.
proxy-help-macos = “켜기”를 선택하면 앱이 실행되는 동안 네트워크 서비스의 프록시를 설정하고 이후 원래대로 되돌립니다. Mac에서 이 작업에 관리자 암호가 필요하면 라우팅을 시작할 때와 종료할 때 암호를 묻습니다.
proxy-help-linux = “켜기”를 선택하면 앱이 실행되어 라우팅하는 동안 GNOME 또는 KDE 프록시 설정을 변경하고 이후 원래대로 되돌립니다. Firefox에서는 설정 > 네트워크 설정에서 “시스템 프록시 설정 사용”을 켜세요.

## Settings: general

general-heading = 일반
start-at-login = 로그인할 때 { -app-name } 시작
language = 언어
system-default = 시스템 기본값

## Settings: troubleshooting

troubleshooting-heading = 문제 해결
troubleshooting-help = 웹 주소나 이름:포트를 테스트하여 어느 tailnet을 거치는지, 연결되는지 확인합니다.
test = 테스트
testing = 테스트 중…
open-log = 로그 열기
open-settings-folder = 설정 폴더 열기
about-line = { -app-name } { $version } · 로컬 프록시 { $proxy } · PAC { $pac }
settings-location = 설정 위치: { $path }

## Results of "Test" in Troubleshooting

check-empty = 머신 이름이나 웹 주소를 입력하세요.
check-bad-port = { $input }: 올바른 포트가 아닙니다.
check-not-routed = { $host }: { -app-name }에서 라우팅하지 않습니다. 현재 라우팅 중인 어떤 tailnet의 도메인으로도 끝나지 않으므로 직접 연결됩니다(일반 네트워크와 내 Tailscale을 통해).
check-gone = 해당 tailnet이 방금 사라졌습니다.
check-not-running = { $tailnet }: 실행 중이 아닙니다.
check-ok = { $address } 정상: { $tailnet } 경유로 { $ms }ms 만에 연결되었습니다.
check-failed =
    { $host }: { $tailnet } 경유로 라우팅되지만 포트 { $port }에 연결하지 못했습니다: { $error }
    머신이 온라인 상태이고 해당 포트에서 수신 대기 중인 서비스가 있는지 확인하세요.
check-timeout = { $host }: { $tailnet } 경유로 라우팅되지만 포트 { $port }에서 10초 안에 응답이 없었습니다.
domain-conflict = { $domain }: { $tailnet }에서도 라우팅하며, 그쪽이 우선합니다.

## Mistakes in typed settings

forwards-line-format = { $line }번째 줄: LOCALPORT = host:port 형식으로 작성하세요.
forwards-line-port = { $line }번째 줄: “{ $value }”은(는) 포트 번호(또는 auto)가 아닙니다.
forwards-line-target = { $line }번째 줄: “{ $value }”은(는) host:port 형식이어야 합니다.
forwards-line-duplicate = { $line }번째 줄: 로컬 포트 { $port }이(가) 두 번 사용되었습니다.
domain-invalid = “{ $domain }”은(는) 도메인이 아닙니다. example.ts.net 같은 형식을 사용하세요.
domain-characters = “{ $domain }”에 도메인에 쓸 수 없는 문자가 있습니다.
autostart-unsupported = 이 시스템에서는 로그인 시 시작을 지원하지 않습니다.

## Dialogs

ok = 확인
cancel = 취소
done = 완료
copy = 복사
error-title = 문제가 발생했습니다
error-details = 자세한 내용은 { $path }에 있습니다
edit-title = { $tailnet } 편집
tailnet-name = 이름
tailnet-name-hint = 이 앱과 트레이 메뉴에 표시됩니다
extra-domains = 추가 도메인(선택 사항)
extra-domains-help = tailnet 자체 도메인은 자동으로 라우팅됩니다. 한 줄에 하나씩 추가하세요.
forward-dialog-title = 포트 포워딩
forward-dialog-text = 이 컴퓨터에 { $host }(으)로 이어지는 포트를 만듭니다. 해당 머신의 어느 포트에 연결할까요?
port-preset-remote-desktop = 원격 데스크톱
port-tooltip = 포트 { $port }
port = 포트
port-hint = 예: 8080
add-forward = 포워딩 추가
not-a-port = “{ $value }”은(는) 포트 번호(1-65535)가 아닙니다.
forward-ready-title = 포트 포워딩 준비 완료
forward-ready-text = { $target }에 접속하려면 앱에서 이 주소를 지정하세요:
forward-ready-note = 포트는 바뀌지 않습니다. 설정에서 언제든 확인할 수 있습니다.
open-remote-desktop = 원격 데스크톱 열기
remove-title = 이 tailnet을 제거할까요?
remove-text = { -app-name }가 { $tailnet }에서 로그아웃하고 이 컴퓨터에서 해당 정보를 삭제합니다. 나중에 다시 추가할 수 있습니다.
remove = 제거
log-out-title = 로그아웃할까요?
log-out-text = { $tailnet }에서 로그아웃할까요? 다시 로그인할 때까지 이 컴퓨터에서 해당 주소를 사용할 수 없습니다.
log-out = 로그아웃

## Tray (Windows, Linux) or menu bar (macOS) menu

tray-sign-in = { $tailnet }: 로그인…
tray-tailnet = { $tailnet }: { $state }
tray-add-tailnet = tailnet 추가…
tray-route = 다른 tailnet을 통해 라우팅
tray-open = { -app-name } 열기…
tray-quit = 종료
tray-tooltip = { -app-name }: { $summary }

## Notification the first time the window is closed

still-running-title = { -app-name }가 계속 실행 중입니다
still-running-windows = 백그라운드에서 계속 라우팅합니다. 시스템 트레이에서 찾을 수 있으며, Windows에서는 시계 옆 ^ 화살표 안에 숨겨져 있을 수 있습니다.
still-running-macos = 백그라운드에서 계속 라우팅합니다. 메뉴 막대에서 찾을 수 있습니다.
still-running-linux = 백그라운드에서 계속 라우팅합니다. 시스템 트레이에서 찾을 수 있습니다.

## Language names in Settings, after each language's own name

english = 영어
french = 프랑스어
german = 독일어
spanish-latin-america = 스페인어(라틴 아메리카)
spanish-spain = 스페인어(스페인)
chinese-simplified = 중국어 간체
chinese-traditional = 중국어 번체
korean = 한국어
japanese = 일본어
polish = 폴란드어
russian = 러시아어
portuguese-brazil = 포르투갈어(브라질)
italian = 이탈리아어
turkish = 튀르키예어
ukrainian = 우크라이나어
czech = 체코어
portuguese-portugal = 포르투갈 포르투갈어
dutch = 네덜란드어
indonesian = 인도네시아어
vietnamese = 베트남어
thai = 태국어
swedish = 스웨덴어
romanian = 루마니아어
hungarian = 헝가리어
afrikaans = 아프리칸스어
catalan = 카탈로니아어
serbian-cyrillic = 세르비아어, 키릴 문자
danish = 덴마크어
finnish = 핀란드어
greek = 그리스어
norwegian-bokmal = 노르웨이어(보크몰)
summary-proxy-problem = 연결되었지만 앱에서 사용하지 않음
hero-proxy-taken = 브라우저에서 이 tailnet들의 주소를 열 수 없습니다. 시스템 프록시 설정이 다른 설정 스크립트({ $script })를 사용하고 있습니다.
hero-proxy-other-copy = 브라우저에서 이 tailnet들의 주소를 열 수 없습니다. 다른 { -app-name } 인스턴스가 시스템 프록시 설정을 사용하고 있습니다. 그쪽을 종료하면 이쪽이 이어받습니다.
hero-proxy-changed = 브라우저에서 이 tailnet들의 주소를 열 수 없습니다. 다른 프로그램이 시스템 프록시 설정을 변경했습니다.
hero-proxy-failed = 브라우저에서 이 tailnet들의 주소를 열 수 없습니다. 시스템 프록시 설정을 변경하지 못했습니다({ $error }).
hero-proxy-manual = 시스템 프록시 설정이 꺼져 있어 직접 설정한 앱만 이 tailnet들에 접속할 수 있습니다. 앱에서 다음 주소를 지정하세요: { $pac }
proxy-replace = 대체하기
proxy-replace-tooltip = 실행 중에는 { -app-name }의 설정 스크립트를 사용하고, 끝나면 원래 스크립트로 되돌립니다
proxy-retry = 다시 시도
proxy-retry-tooltip = 시스템 프록시 설정이 다시 { -app-name }를 가리키도록 합니다
system-setting = 현재 시스템 프록시 설정: { $value }
system-setting-none = 없음
check-updates = 새 버전 확인
find-websites = tailnet의 머신에서 웹사이트 찾기
# $version is the version that's running, such as 0.6.0.
version-current = 버전 { $version }
update-check-now = 지금 확인
update-checking = 확인 중…
update-up-to-date = 최신 버전입니다
update-check-failed = 업데이트를 확인할 수 없습니다
tray-update = { -app-name } { $version } 다운로드…
update-available = { $version } 버전 출시
update-available-tooltip = 현재 버전은 { $current }입니다. 다운로드 페이지를 엽니다.
update-notify-title = { -app-name } { $version } 사용 가능
update-notify-text = { -app-name }를 열어 다운로드하세요.
migrate-failed = 이 앱의 이전 버전인 tailnet-proxy에서 로그인 정보를 옮기지 못했습니다({ $error }). 아마 아직 실행 중일 것입니다. tailnet-proxy를 종료한 다음, 여기서 로그인하기 전에 { -app-name }를 다시 시작하세요. 다시 로그인하면 이 컴퓨터가 각 tailnet에 한 번 더 추가됩니다.
