### Tailnet Link: русский каталог.
### Оставляйте Tailnet Link и Tailscale без изменений. «tailnet» не склоняется:
### используйте конструкцию «сеть tailnet» и склоняйте слово «сеть».

-app-name = Tailnet Link

## Window header

tab-tailnets = Сети tailnet
tab-settings = Настройки

## Unsaved-changes bar at the bottom of Settings

unsaved-changes = Есть несохранённые изменения.
save = Сохранить
revert = Отменить
revert-tooltip = Отменить изменения
settings-saved = Настройки сохранены

## Short notes at the bottom of the window

copied-address = Скопировано: { $address }
copied-sign-in-link = Ссылка для входа скопирована

## Errors shown in the "Something went wrong" dialog

start-failed =
    Не удаётся запустить { -app-name }:
    { $error }
add-tailnet-failed =
    Не удалось добавить сеть tailnet:
    { $error }
add-forward-failed =
    Не удалось добавить переадресацию порта:
    { $error }
remote-desktop-failed = Не удалось запустить «Подключение к удалённому рабочему столу»: { $error }
remote-desktop-windows-only = Удалённый рабочий стол встроен только в Windows.
no-free-port = Не удалось найти свободный локальный порт.

## Dialog after "Add a tailnet"

sign-in-dialog-title = Вход в новую сеть tailnet
sign-in-dialog-text =
    Браузер открывает страницу входа Tailscale. Она может оказаться за этим окном.
    
    Войдите в учётную запись этой сети tailnet и вернитесь сюда. Её домен определится автоматически.

## One tailnet's state, shown as a coloured label beside its name

state-waiting-sign-in = Ожидает входа
state-signed-out = Выполнен выход
state-problem = Проблема
state-connecting = Подключение
state-paused = Приостановлено
state-no-domain = Домена пока нет
state-not-routing = Без маршрутизации
state-routing = Маршрутизация

## The whole app's state, in the status card and the tray menu

summary-no-tailnets = Сетей tailnet пока нет
summary-paused = Приостановлено
summary-routing-one = Маршрутизация через { $tailnet }
summary-routing-all =
    { $count ->
        [one] Маршрутизация через { $count } сеть tailnet
        [few] Маршрутизация через { $count } сети tailnet
        [many] Маршрутизация через { $count } сетей tailnet
       *[other] Маршрутизация через { $count } сети tailnet
    }
summary-routing-some =
    { $count ->
        [one] Маршрутизация через { $routing } из { $count } сети tailnet
        [few] Маршрутизация через { $routing } из { $count } сетей tailnet
        [many] Маршрутизация через { $routing } из { $count } сетей tailnet
       *[other] Маршрутизация через { $routing } из { $count } сети tailnet
    }
summary-signed-out = Вход не выполнен
summary-problem = Проблема: { $problem }
summary-connecting = Подключение…
new-tailnet = Новая сеть tailnet

## Status card at the top of the Tailnets tab

hero-starting = Запуск…
hero-connecting = Подключение к вашим сетям tailnet.
hero-paused = Сейчас через другие сети tailnet ничего не идёт. Ваша локальная сеть и собственная сеть tailnet работают как обычно.
hero-finish-sign-in = Завершите вход в { $tailnet } в браузере.
hero-sign-in = Войдите в { $tailnet }, чтобы открывать устройства этой сети.
hero-routing-example = Откройте { $address } или любой другой адрес в этих сетях tailnet. Всё остальное идёт напрямую.
hero-routing = Адреса в этих сетях tailnet открываются в браузере. Всё остальное идёт напрямую.
add-tailnet = Добавить сеть tailnet
pause-all = Приостановить всё
pause-all-tooltip = Временно прекратить маршрутизацию через другие сети tailnet
resume = Возобновить
resume-tooltip = Снова направлять трафик через другие сети tailnet

## First run, before any tailnet is added

welcome-title = Доступ к устройствам в других сетях tailnet
welcome-text = Оставайтесь в своей сети tailnet и одновременно открывайте устройства в других. Приложение Tailscale продолжает работать как обычно.
welcome-sign-in = Войдите в другую сеть tailnet
welcome-sign-in-detail = Страница входа Tailscale откроется в браузере.
welcome-open = Открывайте её устройства по имени
welcome-open-detail = Адреса вида { $example } работают в браузере.
welcome-forward = Переадресуйте порт, если он нужен приложению
welcome-forward-detail = Удалённый рабочий стол, SSH и клиенты баз данных получают локальный порт, ведущий к устройству.

## A tailnet's card

machine-search-hint = Поиск устройства по имени, ОС или адресу
clear-search = Очистить поиск
more-actions = Другие действия
edit-tailnet-menu = Переименовать или добавить домены…
log-out-menu = Выйти…
remove-menu = Удалить…
sign-in = Войти
pause-tailnet = Приостановить эту сеть tailnet
resume-tailnet = Возобновить эту сеть tailnet
detail-tailnet = Сеть tailnet
detail-routes = Маршруты
detail-this-computer = Этот компьютер
detail-problem = Проблема
routes-after-sign-in = Определятся после входа
hostname-after-sign-in = { $hostname } (после входа)
sign-in-help = Браузер не открылся или открылся не тот профиль?
sign-in-open-again = Снова открыть страницу входа
sign-in-copy-link = Скопировать ссылку
sign-in-copy-link-tooltip = Вставьте её в браузер или профиль браузера, который вы используете для этой сети tailnet

## Machine list inside a tailnet's card

machines-online = Устройства · онлайн { $online } из { $total }
machines-matching = Устройства · найдено { $shown } из { $total }
no-machines = В этой сети tailnet не видно других устройств.
no-machine-matches = По запросу устройств не найдено.
machine-offline = { $name } (офлайн)
forward-port-tooltip = Переадресовать порт: для приложений, игнорирующих настройку прокси, например удалённого рабочего стола или клиента базы данных
copy-address = Скопировать { $address }
open-in-browser = Открыть { $url } в браузере
not-routing-tooltip = Эта сеть tailnet сейчас не маршрутизирует трафик. Может быть, она приостановлена?

## Settings: port forwards

forwards-heading = Переадресация портов
forwards-help = Для приложений, игнорирующих настройку прокси, например удалённого рабочего стола, SSH и клиентов баз данных. Каждая переадресация — это порт на этом компьютере, ведущий к устройству в сети tailnet.
edit-forwards = Изменить переадресации
# LOCALPORT, auto и host:port оставьте как есть: это то, что вводит пользователь.
forwards-format-help = По одной на строку: LOCALPORT = host:port или auto = host:port, чтобы свободный порт выбрался автоматически. Имя хоста определяет, через какую сеть tailnet пойдёт трафик. Чтобы быстро добавить переадресацию, нажмите кнопку с вилкой у устройства на вкладке «Сети tailnet».
forward-cant-listen = Не удаётся прослушивать порт: { $error }
forward-port-on-save = Порт будет выбран при сохранении
forward-no-tailnet = Нет активной сети tailnet с таким именем
forward-via = через { $tailnet }
open-remote-desktop-to = Подключиться к { $address } через удалённый рабочий стол

## Settings: system proxy

proxy-heading = Системная настройка прокси
proxy-on = Вкл. (рекомендуется)
proxy-force = Вкл., с заменой корпоративного скрипта прокси на время работы
proxy-off = Выкл.: настрою приложения вручную
proxy-help-windows = «Вкл.» направляет Windows на правила этого приложения, только пока оно работает и маршрутизирует трафик, и возвращает всё как было, когда оно останавливается, приостанавливается, отключается или аварийно завершается.
proxy-help-macos = «Вкл.» задаёт прокси для ваших сетевых служб, пока приложение работает, а затем возвращает прежние настройки. Если для этого Mac требует пароль администратора, он будет запрошен при запуске маршрутизации и при выходе.
proxy-help-linux = «Вкл.» задаёт настройку прокси GNOME или KDE, пока приложение работает и маршрутизирует трафик, а затем возвращает прежнюю. В браузере Firefox включите Настройки > Параметры сети > «Использовать системные настройки прокси».

## Settings: general

general-heading = Общие
start-at-login = Запускать { -app-name } при входе в систему
language = Язык
system-default = Язык системы

## Settings: troubleshooting

troubleshooting-heading = Устранение неполадок
troubleshooting-help = Проверьте веб-адрес или имя:порт, чтобы узнать, через какую сеть tailnet он идёт и удаётся ли подключиться.
test = Проверить
testing = Проверка…
open-log = Открыть журнал
open-settings-folder = Открыть папку настроек
about-line = { -app-name } { $version } · локальный прокси { $proxy } · PAC { $pac }
settings-location = Настройки хранятся в { $path }

## Results of "Test" in Troubleshooting

check-empty = Введите имя устройства или веб-адрес.
check-bad-port = { $input }: недопустимый порт.
check-not-routed = { -app-name } не маршрутизирует { $host }: адрес не оканчивается доменом ни одной из активных сейчас сетей tailnet, поэтому идёт напрямую (через вашу обычную сеть и ваш собственный Tailscale).
check-gone = Эта сеть tailnet только что исчезла.
check-not-running = Сеть { $tailnet } не запущена.
check-ok = { $address } работает: подключение через { $tailnet } за { $ms } мс.
check-failed =
    { $host } маршрутизируется через { $tailnet }, но подключиться к порту { $port } не удалось: { $error }
    Убедитесь, что устройство онлайн и этот порт кто-то прослушивает.
check-timeout = { $host } маршрутизируется через { $tailnet }, но порт { $port } не ответил за 10 секунд.
domain-conflict = Домен { $domain } также маршрутизирует сеть { $tailnet }; приоритет у неё.

## Mistakes in typed settings

forwards-line-format = Строка { $line }: используйте формат LOCALPORT = host:port.
forwards-line-port = Строка { $line }: «{ $value }» — не номер порта (и не auto).
forwards-line-target = Строка { $line }: «{ $value }» должно иметь вид host:port.
forwards-line-duplicate = Строка { $line }: локальный порт { $port } указан дважды.
domain-invalid = «{ $domain }» — не домен; укажите, например, example.ts.net.
domain-characters = «{ $domain }» содержит символы, недопустимые в домене.
autostart-unsupported = Автозапуск при входе в систему не поддерживается в этой системе.

## Dialogs

ok = ОК
cancel = Отмена
done = Готово
copy = Копировать
error-title = Что-то пошло не так
error-details = Подробности в { $path }
edit-title = Изменение сети { $tailnet }
tailnet-name = Название
tailnet-name-hint = Отображается в приложении и в меню в трее
extra-domains = Дополнительные домены (необязательно)
extra-domains-help = Собственный домен сети tailnet маршрутизируется автоматически. Добавляйте по одному на строку.
forward-dialog-title = Переадресация порта
forward-dialog-text = Получите порт на этом компьютере, ведущий к { $host }. Какой порт на том устройстве?
port-preset-remote-desktop = Удалённый рабочий стол
port-tooltip = Порт { $port }
port = Порт
port-hint = напр. 8080
add-forward = Добавить переадресацию
not-a-port = «{ $value }» — не номер порта (1–65535).
forward-ready-title = Переадресация порта готова
forward-ready-text = Укажите в приложении этот адрес, чтобы подключиться к { $target }:
forward-ready-note = Порт не меняется. Его можно найти в настройках.
open-remote-desktop = Открыть удалённый рабочий стол
remove-title = Удалить эту сеть tailnet?
remove-text = { -app-name } выйдет из сети { $tailnet } и забудет её на этом компьютере. Позже её можно добавить снова.
remove = Удалить
log-out-title = Выйти?
log-out-text = Выйти из сети { $tailnet }? Её адреса перестанут работать здесь, пока вы снова не войдёте.
log-out = Выйти

## Tray (Windows, Linux) or menu bar (macOS) menu

tray-sign-in = { $tailnet }: войти…
tray-tailnet = { $tailnet }: { $state }
tray-add-tailnet = Добавить сеть tailnet…
tray-route = Маршрутизировать через другие сети tailnet
tray-open = Открыть { -app-name }…
tray-quit = Выход
tray-tooltip = { -app-name }: { $summary }

## Notification the first time the window is closed

still-running-title = { -app-name } продолжает работать
still-running-windows = Маршрутизация продолжается в фоне. Значок находится в области уведомлений; Windows может спрятать его под стрелкой ^ рядом с часами.
still-running-macos = Маршрутизация продолжается в фоне. Значок находится в строке меню.
still-running-linux = Маршрутизация продолжается в фоне. Значок находится в системном трее.

## Language names in Settings, after each language's own name

english = Английский
french = Французский
german = Немецкий
spanish-latin-america = Испанский (Латинская Америка)
spanish-spain = Испанский (Испания)
chinese-simplified = Китайский (упрощённый)
chinese-traditional = Китайский (традиционный)
korean = Корейский
japanese = Японский
polish = Польский
russian = Русский
portuguese-brazil = Португальский (Бразилия)
italian = Итальянский
turkish = Турецкий
ukrainian = Украинский
czech = Чешский
portuguese-portugal = Португальский (Португалия)
dutch = Нидерландский
indonesian = Индонезийский
vietnamese = Вьетнамский
thai = Тайский
swedish = Шведский
romanian = Румынский
hungarian = Венгерский
afrikaans = Африкаанс
catalan = Каталанский
serbian-cyrillic = Сербский, кириллица
danish = Датский
finnish = Финский
greek = Греческий
norwegian-bokmal = Норвежский букмол
