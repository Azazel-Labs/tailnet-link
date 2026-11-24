### Tailnet Link: српски каталог (ћирилица, екавица).
### Tailnet Link и Tailscale остају непромењени. „tailnet“ се не мења по падежима:
### користите спој „мрежа tailnet“ и мењајте реч „мрежа“.

-app-name = Tailnet Link

## Window header

tab-tailnets = Мреже tailnet
tab-settings = Подешавања

## Unsaved-changes bar at the bottom of Settings

unsaved-changes = Имате несачуване измене.
save = Сачувај
revert = Врати
revert-tooltip = Поништи измене
settings-saved = Подешавања су сачувана

## Short notes at the bottom of the window

copied-address = Копирано: { $address }
copied-sign-in-link = Веза за пријаву је копирана

## Errors shown in the "Something went wrong" dialog

start-failed =
    { -app-name } не може да се покрене:
    { $error }
add-tailnet-failed =
    Додавање мреже tailnet није успело:
    { $error }
add-forward-failed =
    Додавање прослеђивања порта није успело:
    { $error }
remote-desktop-failed = Покретање програма „Веза са удаљеном радном површином“ није успело: { $error }
remote-desktop-windows-only = Удаљена радна површина је уграђена само у Windows.
no-free-port = Није пронађен слободан локални порт.

## Dialog after "Add a tailnet"

sign-in-dialog-title = Пријава на нову мрежу tailnet
sign-in-dialog-text =
    Прегледач отвара страницу за пријаву на Tailscale. Можда ће се отворити иза овог прозора.
    
    Пријавите се налогом за ту мрежу tailnet, па се вратите овде. Њен домен се препознаје аутоматски.

## One tailnet's state, shown as a coloured label beside its name

state-waiting-sign-in = Чека пријаву
state-signed-out = Одјављено
state-problem = Проблем
state-connecting = Повезивање
state-paused = Паузирано
state-no-domain = Још нема домена
state-not-routing = Без рутирања
state-routing = Рутирање

## The whole app's state, in the status card and the tray menu

summary-no-tailnets = Још нема мрежа tailnet
summary-paused = Паузирано
summary-routing-one = Рутирање преко { $tailnet }
summary-routing-all =
    { $count ->
        [one] Рутирање преко { $count } мреже tailnet
        [few] Рутирање преко { $count } мреже tailnet
       *[other] Рутирање преко { $count } мрежа tailnet
    }
summary-routing-some =
    { $count ->
        [one] Рутирање преко { $routing } од { $count } мреже tailnet
        [few] Рутирање преко { $routing } од { $count } мреже tailnet
       *[other] Рутирање преко { $routing } од { $count } мрежа tailnet
    }
summary-signed-out = Нисте пријављени
summary-problem = Проблем: { $problem }
summary-connecting = Повезивање…
new-tailnet = Нова мрежа tailnet

## Status card at the top of the Tailnets tab

hero-starting = Покретање…
hero-connecting = Повезивање са вашим мрежама tailnet.
hero-paused = Тренутно ништа не иде кроз друге мреже tailnet. Ваша локална мрежа и ваша мрежа tailnet раде као и обично.
hero-finish-sign-in = Довршите пријаву на { $tailnet } у прегледачу.
hero-sign-in = Пријавите се на { $tailnet } да бисте приступили уређајима те мреже.
hero-routing-example = Отворите { $address } или било коју другу адресу у овим мрежама tailnet. Све остало иде директно.
hero-routing = Адресе у овим мрежама tailnet отварају се у прегледачу. Све остало иде директно.
add-tailnet = Додај мрежу tailnet
pause-all = Паузирај све
pause-all-tooltip = Привремено заустави рутирање кроз друге мреже tailnet
resume = Настави
resume-tooltip = Поново рутирај саобраћај кроз друге мреже tailnet

## First run, before any tailnet is added

welcome-title = Приступите уређајима у другим мрежама tailnet
welcome-text = Останите на својој мрежи tailnet и истовремено отварајте уређаје у другима. Апликација Tailscale ради као и обично.
welcome-sign-in = Пријавите се на другу мрежу tailnet
welcome-sign-in-detail = Страница за пријаву на Tailscale отвара се у прегледачу.
welcome-open = Отварајте њене уређаје по имену
welcome-open-detail = Адресе као што је { $example } раде у прегледачу.
welcome-forward = Проследите порт када је апликацији потребан
welcome-forward-detail = Удаљена радна површина, SSH и клијенти база података добијају локални порт који води до уређаја.

## A tailnet's card

machine-search-hint = Пронађите уређај по имену, ОС-у или адреси
clear-search = Обриши претрагу
open-terminal-tooltip = Отворите терминал у ком раде имена из ваших мрежа tailnet, за curl, git, ssh, ping и још много тога. Или ставите tl испред било које команде у било ком терминалу.
open-terminal-missing = { -app-name } не може да пронађе tl, свој помоћни програм за терминал, поред апликације. Поново инсталирајте { -app-name } да бисте га добили.
open-terminal-failed = Отварање терминала није успело: { $error }
more-actions = Још радњи
edit-tailnet-menu = Преименуј или додај домене…
log-out-menu = Одјави се…
remove-menu = Уклони…
sign-in = Пријави се
pause-tailnet = Паузирај ову мрежу tailnet
resume-tailnet = Настави ову мрежу tailnet
detail-tailnet = Мрежа tailnet
detail-routes = Руте
detail-this-computer = Овај рачунар
detail-problem = Проблем
routes-after-sign-in = Биће пронађене након пријаве
hostname-after-sign-in = { $hostname } (након пријаве)
sign-in-help = Прегледач се није отворио или је отворио погрешан профил?
sign-in-open-again = Поново отвори страницу за пријаву
sign-in-copy-link = Копирај везу
sign-in-copy-link-tooltip = Налепите је у прегледач или профил прегледача који користите за ову мрежу tailnet

## Machine list inside a tailnet's card

machines-online = Уређаји · на мрежи { $online } од { $total }
machines-matching = Уређаји · пронађено { $shown } од { $total }
no-machines = У овој мрежи tailnet нису видљиви други уређаји.
no-machine-matches = Ниједан уређај не одговара претрази.
machine-offline = { $name } (ван мреже)
forward-port-tooltip = Проследи порт: за апликације које занемарују подешавање проксија, као што су Удаљена радна површина или клијент базе података
copy-address = Копирај { $address }
open-in-browser = Отвори { $url } у прегледачу
not-routing-tooltip = Ова мрежа tailnet тренутно не рутира саобраћај. Да ли је паузирана?

## Websites found on the machines

sites-heading = Веб-сајтови
sites-help = Уређаји у вашим мрежама tailnet који пружају веб-сајт преко HTTPS-а. Сваки уређај се проверава највише једном дневно.
# $done and $total count machines.
sites-checking = Провера: { $done } од { $total }…
sites-recheck-tooltip = Поново провери све уређаје сада
site-untrusted = Његов сертификат није поуздан, па ће вас прегледач упозорити.
site-favorite-add = Додај у омиљене
site-favorite-remove = Уклони из омиљених
sites-all = Сви веб-сајтови · { $count }
sites-matching = Веб-сајтови · пронађено { $shown } од { $total }
sites-favorites-hint = Означите веб-сајт звездицом на листи испод да бисте га закачили овде.

## Settings: port forwards

forwards-heading = Прослеђивање портова
forwards-help = За апликације које занемарују подешавање проксија, као што су Удаљена радна површина, SSH и клијенти база података. Свако прослеђивање је порт на овом рачунару који води до уређаја у мрежи tailnet.
edit-forwards = Уреди прослеђивања
# LOCALPORT, auto и host:port остају непромењени: то корисник уноси.
forwards-format-help = Једно по реду: LOCALPORT = host:port, или auto = host:port да би се изабрао слободан порт. Име хоста одређује која мрежа tailnet преноси саобраћај. За брзо додавање користите дугме са утикачем поред уређаја на картици „Мреже tailnet“.
forward-cant-listen = Ослушкивање није могуће: { $error }
forward-port-on-save = Порт се бира када сачувате
forward-no-tailnet = Ниједна активна мрежа tailnet нема ово име
forward-via = преко { $tailnet }
open-remote-desktop-to = Повежи се са { $address } преко удаљене радне површине

## Settings: system proxy

proxy-heading = Системско подешавање проксија
proxy-on = Укључено (препоручено)
proxy-force = Укључено, уз замену прокси скрипте ваше компаније док апликација ради
proxy-off = Искључено: подесићу апликације ручно
proxy-help-windows = „Укључено“ усмерава Windows на правила ове апликације само док ради и рутира саобраћај, а враћа претходно стање када се заустави, паузира, прекине везу или сруши.
proxy-help-macos = „Укључено“ подешава прокси за ваше мрежне услуге док апликација ради, а после враћа претходно стање. Ако ваш Mac за то тражи администраторску лозинку, биће затражена када рутирање почне и када изађете.
proxy-help-linux = „Укључено“ подешава прокси у окружењу GNOME или KDE док апликација ради и рутира саобраћај, а после враћа претходно стање. У прегледачу Firefox укључите Подешавања > Подешавања мреже > „Користи системска подешавања проксија“.

## Settings: general

general-heading = Опште
start-at-login = Покрени { -app-name } при пријављивању
language = Језик
system-default = Подразумевано у систему

## Settings: troubleshooting

troubleshooting-heading = Решавање проблема
troubleshooting-help = Тестирајте веб адресу или име:порт да бисте видели која мрежа tailnet је преноси и да ли се повезивање успоставља.
test = Тестирај
testing = Тестирање…
open-log = Отвори дневник
open-settings-folder = Отвори фасциклу подешавања
about-line = { -app-name } { $version } · локални прокси { $proxy } · PAC { $pac }
settings-location = Подешавања се налазе у { $path }

## Settings: names

names-heading = Имена
names-help = Ваша сопствена имена за адресе у вашим мрежама tailnet, на пример за сервер иза рутера подмреже. Раде само у прегледачима и прослеђивањима портова на овом рачунару.
edit-names = Уреди имена
# „name = address“ и пример остају непромењени: то корисник уноси.
names-format-help = Једно по реду: name = address, на пример wiki = 192.168.20.15. Адреса може бити IP адреса или име уређаја. Отворите га као http://wiki:8080/, са портом који сајт користи.

## Results of "Test" in Troubleshooting

check-empty = Унесите име уређаја или веб адресу.
check-bad-port = { $input }: то није важећи порт.
check-not-routed = { -app-name } не рутира { $host }: то није име, адреса ни подмрежа ниједне мреже tailnet која тренутно рутира, па иде директно (кроз вашу уобичајену мрежу и ваш Tailscale).
# $tailnets lists the tailnets, separated by commas.
check-ambiguous = { $host } се налази у више мрежа tailnet ({ $tailnets }), па се не рутира. Уместо тога користите име уређаја или искључите подмреже за једну од тих мрежа.
check-gone = Та мрежа tailnet је управо нестала.
check-not-running = Мрежа { $tailnet } није покренута.
ping-no-machine = { $host } иде кроз мрежу { $tailnet }, али није ниједан од њених уређаја, па Tailscale нема шта да пингује.
check-ok = { $address } ради: повезано преко { $tailnet } за { $ms } мс.
check-failed =
    { $host } се рутира преко { $tailnet }, али повезивање на порт { $port } није успело: { $error }
    Проверите да ли је уређај на мрежи и да ли нешто ослушкује тај порт.
check-timeout = { $host } се рутира преко { $tailnet }, али порт { $port } није одговорио у року од 10 секунди.
domain-conflict = Домен { $domain } рутира и мрежа { $tailnet }; предност има она.

## Mistakes in typed settings

forwards-line-format = Ред { $line }: упишите LOCALPORT = host:port.
forwards-line-port = Ред { $line }: „{ $value }“ није број порта (нити auto).
forwards-line-target = Ред { $line }: „{ $value }“ треба да буде у облику host:port.
forwards-line-duplicate = Ред { $line }: локални порт { $port } је наведен двапут.
domain-invalid = „{ $domain }“ није домен; користите нешто попут example.ts.net.
domain-characters = „{ $domain }“ садржи знакове који нису дозвољени у домену.
names-line-format = Ред { $line }: упишите name = address.
names-line-name = Ред { $line }: „{ $value }“ не може бити име. Користите слова, цифре, цртице и тачке.
names-line-target = Ред { $line }: „{ $value }“ није ни IP адреса ни име уређаја.
names-line-duplicate = Ред { $line }: име { $value } је наведено двапут.
autostart-unsupported = Покретање при пријављивању није подржано на овом систему.

## Dialogs

ok = У реду
cancel = Откажи
done = Готово
copy = Копирај
error-title = Дошло је до грешке
error-details = Детаљи су у { $path }
edit-title = Уређивање мреже { $tailnet }
tailnet-name = Назив
tailnet-name-hint = Приказује се у овој апликацији и у менију системске палете
extra-domains = Додатни домени (опционо)
extra-domains-help = Сопствени домен мреже tailnet рутира се аутоматски. Додајте по један у сваки ред.
route-subnets = Рутирај њене подмреже
route-subnets-help = Мреже до којих ова мрежа tailnet стиже преко својих рутера подмреже, на пример мрежа у облаку. Искључите ово ако се нека од њих преклапа са мрежом на којој је овај рачунар.
forward-dialog-title = Прослеђивање порта
forward-dialog-text = Добијте порт на овом рачунару који води до { $host }. Који порт на том уређају?
port-preset-remote-desktop = Удаљена радна површина
port-tooltip = Порт { $port }
port = Порт
port-hint = нпр. 8080
add-forward = Додај прослеђивање
not-a-port = „{ $value }“ није број порта (1–65535).
forward-ready-title = Прослеђивање порта је спремно
forward-ready-text = Усмерите апликацију на ову адресу да бисте стигли до { $target }:
forward-ready-note = Порт остаје исти. Наћи ћете га у Подешавањима.
open-remote-desktop = Отвори удаљену радну површину
remove-title = Уклонити ову мрежу tailnet?
remove-text = { -app-name } се одјављује са мреже { $tailnet } и заборавља је на овом рачунару. Касније је можете поново додати.
remove = Уклони
log-out-title = Одјавити се?
log-out-text = Одјавити се са мреже { $tailnet }? Њене адресе овде престају да раде док се поново не пријавите.
log-out = Одјави се

## Tray (Windows, Linux) or menu bar (macOS) menu

tray-sign-in = { $tailnet }: пријава…
tray-tailnet = { $tailnet }: { $state }
tray-add-tailnet = Додај мрежу tailnet…
tray-route = Рутирај кроз друге мреже tailnet
tray-open = Отвори { -app-name }…
tray-quit = Изађи
tray-tooltip = { -app-name }: { $summary }

## Notification the first time the window is closed

still-running-title = { -app-name } и даље ради
still-running-windows = Рутирање се наставља у позадини. Иконица је у системској палети; Windows је можда сакрије испод стрелице ^ поред сата.
still-running-macos = Рутирање се наставља у позадини. Иконица је на траци менија.
still-running-linux = Рутирање се наставља у позадини. Иконица је у системској палети.

## Language names in Settings, after each language's own name

english = Енглески
french = Француски
german = Немачки
spanish-latin-america = Латиноамерички шпански
spanish-spain = Шпански из Шпаније
chinese-simplified = Поједностављени кинески
chinese-traditional = Традиционални кинески
korean = Корејски
japanese = Јапански
polish = Пољски
russian = Руски
portuguese-brazil = Бразилски португалски
italian = Италијански
turkish = Турски
ukrainian = Украјински
czech = Чешки
portuguese-portugal = Европски португалски
dutch = Холандски
indonesian = Индонежански
vietnamese = Вијетнамски
thai = Тајландски
swedish = Шведски
romanian = Румунски
hungarian = Мађарски
afrikaans = Африканс
catalan = Каталонски
serbian-cyrillic = Српски, ћирилица
danish = Дански
finnish = Фински
greek = Грчки
norwegian-bokmal = Норвешки букмол
summary-proxy-problem = Повезано, али апликације не користе везу
hero-proxy-taken = Прегледач неће отварати адресе ових мрежа tailnet: системско подешавање проксија користи другу скрипту за подешавање ({ $script }).
hero-proxy-other-copy = Прегледач неће отварати адресе ових мрежа tailnet: системско подешавање проксија држи друга копија апликације { -app-name }. Изађите из те копије и ова ће преузети.
hero-proxy-changed = Прегледач неће отварати адресе ових мрежа tailnet: нешто друго је променило системско подешавање проксија.
hero-proxy-failed = Прегледач неће отварати адресе ових мрежа tailnet: системско подешавање проксија није могло да се промени ({ $error }).
hero-proxy-manual = Системско подешавање проксија је искључено, па до ових мрежа tailnet стижу само апликације које сами подесите. Усмерите их на { $pac }
proxy-replace = Замени је
proxy-replace-tooltip = Користи скрипту за подешавање апликације { -app-name } док ради, а после врати ону другу
proxy-retry = Покушај поново
proxy-retry-tooltip = Поново усмери системско подешавање проксија на { -app-name }
system-setting = Тренутно системско подешавање проксија: { $value }
system-setting-none = нема
check-updates = Потражи нове верзије
find-websites = Тражи веб-сајтове на уређајима у вашим мрежама tailnet
# $version is the version that's running, such as 0.6.0.
version-current = Верзија { $version }
update-check-now = Провери сада
update-checking = Провера…
update-up-to-date = Имате најновију верзију
update-check-failed = Провера ажурирања није успела
tray-update = Преузми { -app-name } { $version }…
update-available = Изашла је верзија { $version }
update-available-tooltip = Имате верзију { $current }. Отвара страницу за преузимање.
update-notify-title = Доступна је верзија { -app-name } { $version }
update-notify-text = Отворите { -app-name } да бисте је преузели.
migrate-failed = Ваше пријаве из tailnet-proxy, претходне верзије ове апликације, нису могле да се пренесу ({ $error }). Вероватно још увек ради. Изађите из tailnet-proxy, па поново покрените { -app-name } пре него што се пријавите овде: поновна пријава би додала овај рачунар у сваку мрежу tailnet други пут.
