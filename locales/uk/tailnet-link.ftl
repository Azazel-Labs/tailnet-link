### Tailnet Link: український каталог.
### Залишайте Tailnet Link і Tailscale без змін. «tailnet» не відмінюється:
### використовуйте конструкцію «мережа tailnet» і відмінюйте слово «мережа».

-app-name = Tailnet Link

## Window header

tab-tailnets = Мережі tailnet
tab-settings = Налаштування

## Unsaved-changes bar at the bottom of Settings

unsaved-changes = Є незбережені зміни.
save = Зберегти
revert = Відкинути
revert-tooltip = Скасувати зміни
settings-saved = Налаштування збережено

## Short notes at the bottom of the window

copied-address = Скопійовано: { $address }
copied-sign-in-link = Посилання для входу скопійовано

## Errors shown in the "Something went wrong" dialog

start-failed =
    Не вдається запустити { -app-name }:
    { $error }
add-tailnet-failed =
    Не вдалося додати мережу tailnet:
    { $error }
add-forward-failed =
    Не вдалося додати переадресацію порту:
    { $error }
remote-desktop-failed = Не вдалося запустити «Підключення до віддаленого робочого стола»: { $error }
remote-desktop-windows-only = Віддалений робочий стіл вбудовано лише у Windows.
no-free-port = Не вдалося знайти вільний локальний порт.

## Dialog after "Add a tailnet"

sign-in-dialog-title = Вхід у нову мережу tailnet
sign-in-dialog-text =
    Браузер відкриває сторінку входу Tailscale. Вона може з’явитися за цим вікном.
    
    Увійдіть в обліковий запис цієї мережі tailnet і поверніться сюди. Її домен визначиться автоматично.

## One tailnet's state, shown as a coloured label beside its name

state-waiting-sign-in = Очікує входу
state-signed-out = Вихід виконано
state-problem = Проблема
state-connecting = Підключення
state-paused = Призупинено
state-no-domain = Домену ще немає
state-not-routing = Без маршрутизації
state-routing = Маршрутизація

## The whole app's state, in the status card and the tray menu

summary-no-tailnets = Мереж tailnet ще немає
summary-paused = Призупинено
summary-routing-one = Маршрутизація через { $tailnet }
summary-routing-all =
    { $count ->
        [one] Маршрутизація через { $count } мережу tailnet
        [few] Маршрутизація через { $count } мережі tailnet
        [many] Маршрутизація через { $count } мереж tailnet
       *[other] Маршрутизація через { $count } мережі tailnet
    }
summary-routing-some =
    { $count ->
        [one] Маршрутизація через { $routing } з { $count } мережі tailnet
        [few] Маршрутизація через { $routing } з { $count } мереж tailnet
        [many] Маршрутизація через { $routing } з { $count } мереж tailnet
       *[other] Маршрутизація через { $routing } з { $count } мережі tailnet
    }
summary-signed-out = Вхід не виконано
summary-problem = Проблема: { $problem }
summary-connecting = Підключення…
new-tailnet = Нова мережа tailnet

## Status card at the top of the Tailnets tab

hero-starting = Запуск…
hero-connecting = Підключення до ваших мереж tailnet.
hero-paused = Зараз через інші мережі tailnet нічого не проходить. Ваша локальна мережа та власна мережа tailnet працюють як звичайно.
hero-finish-sign-in = Завершіть вхід у { $tailnet } у браузері.
hero-sign-in = Увійдіть у { $tailnet }, щоб відкривати пристрої цієї мережі.
hero-routing-example = Відкрийте { $address } або будь-яку іншу адресу в цих мережах tailnet. Усе інше йде напряму.
hero-routing = Адреси в цих мережах tailnet відкриваються у браузері. Усе інше йде напряму.
add-tailnet = Додати мережу tailnet
pause-all = Призупинити все
pause-all-tooltip = Тимчасово зупинити маршрутизацію через інші мережі tailnet
resume = Відновити
resume-tooltip = Знову спрямовувати трафік через інші мережі tailnet

## First run, before any tailnet is added

welcome-title = Доступ до пристроїв в інших мережах tailnet
welcome-text = Залишайтеся у своїй мережі tailnet і водночас відкривайте пристрої в інших. Застосунок Tailscale працює як звичайно.
welcome-sign-in = Увійдіть в іншу мережу tailnet
welcome-sign-in-detail = Сторінка входу Tailscale відкриється у браузері.
welcome-open = Відкривайте її пристрої за назвою
welcome-open-detail = Адреси на кшталт { $example } працюють у браузері.
welcome-forward = Переадресуйте порт, коли він потрібен застосунку
welcome-forward-detail = Віддалений робочий стіл, SSH і клієнти баз даних отримують локальний порт, що веде до пристрою.

## A tailnet's card

machine-search-hint = Шукати пристрій за назвою, ОС або адресою
clear-search = Очистити пошук
more-actions = Інші дії
edit-tailnet-menu = Перейменувати або додати домени…
log-out-menu = Вийти…
remove-menu = Видалити…
sign-in = Увійти
pause-tailnet = Призупинити цю мережу tailnet
resume-tailnet = Відновити цю мережу tailnet
detail-tailnet = Мережа tailnet
detail-routes = Маршрути
detail-this-computer = Цей комп’ютер
detail-problem = Проблема
routes-after-sign-in = Визначаться після входу
hostname-after-sign-in = { $hostname } (після входу)
sign-in-help = Браузер не відкрився або відкрився не той профіль?
sign-in-open-again = Знову відкрити сторінку входу
sign-in-copy-link = Копіювати посилання
sign-in-copy-link-tooltip = Вставте його в браузер або профіль браузера, який ви використовуєте для цієї мережі tailnet

## Machine list inside a tailnet's card

machines-online = Пристрої · онлайн { $online } з { $total }
machines-matching = Пристрої · знайдено { $shown } з { $total }
no-machines = У цій мережі tailnet не видно інших пристроїв.
no-machine-matches = За запитом пристроїв не знайдено.
machine-offline = { $name } (офлайн)
forward-port-tooltip = Переадресувати порт: для застосунків, що ігнорують налаштування проксі, як-от віддалений робочий стіл або клієнт бази даних
copy-address = Копіювати { $address }
open-in-browser = Відкрити { $url } у браузері
not-routing-tooltip = Ця мережа tailnet зараз не маршрутизує трафік. Можливо, її призупинено?

## Websites found on the machines

sites-heading = Сайти
sites-help = Пристрої у ваших мережах tailnet, на яких працює сайт через HTTPS. Кожен пристрій перевіряється не частіше ніж раз на день.
# $done and $total count machines.
sites-checking = Перевірка: { $done } з { $total }…
sites-recheck-tooltip = Перевірити всі пристрої знову
site-untrusted = Його сертифікат не є довіреним, тому браузер покаже попередження.

## Settings: port forwards

forwards-heading = Переадресація портів
forwards-help = Для застосунків, що ігнорують налаштування проксі, як-от віддалений робочий стіл, SSH і клієнти баз даних. Кожна переадресація — це порт на цьому комп’ютері, що веде до пристрою в мережі tailnet.
edit-forwards = Редагувати переадресації
# LOCALPORT, auto і host:port залишайте без змін: це те, що вводить користувач.
forwards-format-help = По одній на рядок: LOCALPORT = host:port або auto = host:port, щоб вільний порт було вибрано автоматично. Ім’я хоста визначає, через яку мережу tailnet піде трафік. Щоб швидко додати переадресацію, натисніть кнопку з вилкою біля пристрою на вкладці «Мережі tailnet».
forward-cant-listen = Не вдається прослуховувати порт: { $error }
forward-port-on-save = Порт буде вибрано під час збереження
forward-no-tailnet = Немає активної мережі tailnet із такою назвою
forward-via = через { $tailnet }
open-remote-desktop-to = Підключитися до { $address } через віддалений робочий стіл

## Settings: system proxy

proxy-heading = Системне налаштування проксі
proxy-on = Увімкнено (рекомендовано)
proxy-force = Увімкнено, із заміною корпоративного скрипту проксі на час роботи
proxy-off = Вимкнено: налаштую застосунки вручну
proxy-help-windows = «Увімкнено» спрямовує Windows на правила цього застосунку лише тоді, коли він працює й маршрутизує трафік, і повертає все як було, коли він зупиняється, призупиняється, від’єднується або аварійно завершується.
proxy-help-macos = «Увімкнено» задає проксі для ваших мережевих служб, поки застосунок працює, а потім повертає попередні налаштування. Якщо ваш Mac вимагає для цього пароль адміністратора, його буде запитано під час запуску маршрутизації та під час виходу.
proxy-help-linux = «Увімкнено» задає налаштування проксі GNOME або KDE, поки застосунок працює й маршрутизує трафік, а потім повертає попереднє. У браузері Firefox увімкніть Налаштування > Параметри мережі > «Використовувати системні налаштування проксі».

## Settings: general

general-heading = Загальні
start-at-login = Запускати { -app-name } під час входу в систему
language = Мова
system-default = Мова системи

## Settings: troubleshooting

troubleshooting-heading = Усунення несправностей
troubleshooting-help = Перевірте вебадресу або ім’я:порт, щоб дізнатися, через яку мережу tailnet вона йде і чи вдається підключитися.
test = Перевірити
testing = Перевірка…
open-log = Відкрити журнал
open-settings-folder = Відкрити теку налаштувань
about-line = { -app-name } { $version } · локальний проксі { $proxy } · PAC { $pac }
settings-location = Налаштування зберігаються в { $path }

## Results of "Test" in Troubleshooting

check-empty = Введіть назву пристрою або вебадресу.
check-bad-port = { $input }: недійсний порт.
check-not-routed = { -app-name } не маршрутизує { $host }: адреса не закінчується доменом жодної з активних зараз мереж tailnet, тому йде напряму (через вашу звичайну мережу та ваш власний Tailscale).
check-gone = Ця мережа tailnet щойно зникла.
check-not-running = Мережа { $tailnet } не запущена.
check-ok = { $address } працює: підключено через { $tailnet } за { $ms } мс.
check-failed =
    { $host } маршрутизується через { $tailnet }, але підключитися до порту { $port } не вдалося: { $error }
    Переконайтеся, що пристрій онлайн і цей порт хтось прослуховує.
check-timeout = { $host } маршрутизується через { $tailnet }, але порт { $port } не відповів протягом 10 секунд.
domain-conflict = Домен { $domain } також маршрутизує мережа { $tailnet }; пріоритет у неї.

## Mistakes in typed settings

forwards-line-format = Рядок { $line }: використовуйте формат LOCALPORT = host:port.
forwards-line-port = Рядок { $line }: «{ $value }» — не номер порту (і не auto).
forwards-line-target = Рядок { $line }: «{ $value }» має бути у форматі host:port.
forwards-line-duplicate = Рядок { $line }: локальний порт { $port } вказано двічі.
domain-invalid = «{ $domain }» — не домен; вкажіть, наприклад, example.ts.net.
domain-characters = «{ $domain }» містить символи, неприпустимі в домені.
autostart-unsupported = Автозапуск під час входу в систему не підтримується в цій системі.

## Dialogs

ok = Гаразд
cancel = Скасувати
done = Готово
copy = Копіювати
error-title = Щось пішло не так
error-details = Подробиці в { $path }
edit-title = Редагування мережі { $tailnet }
tailnet-name = Назва
tailnet-name-hint = Показується в цьому застосунку та в меню в треї
extra-domains = Додаткові домени (необов’язково)
extra-domains-help = Власний домен мережі tailnet маршрутизується автоматично. Додавайте по одному на рядок.
forward-dialog-title = Переадресація порту
forward-dialog-text = Отримайте порт на цьому комп’ютері, що веде до { $host }. Який порт на тому пристрої?
port-preset-remote-desktop = Віддалений робочий стіл
port-tooltip = Порт { $port }
port = Порт
port-hint = напр. 8080
add-forward = Додати переадресацію
not-a-port = «{ $value }» — не номер порту (1–65535).
forward-ready-title = Переадресація порту готова
forward-ready-text = Вкажіть у застосунку цю адресу, щоб підключитися до { $target }:
forward-ready-note = Порт не змінюється. Його можна знайти в налаштуваннях.
open-remote-desktop = Відкрити віддалений робочий стіл
remove-title = Видалити цю мережу tailnet?
remove-text = { -app-name } вийде з мережі { $tailnet } і забуде її на цьому комп’ютері. Пізніше її можна додати знову.
remove = Видалити
log-out-title = Вийти?
log-out-text = Вийти з мережі { $tailnet }? Її адреси перестануть працювати тут, доки ви знову не ввійдете.
log-out = Вийти

## Tray (Windows, Linux) or menu bar (macOS) menu

tray-sign-in = { $tailnet }: увійти…
tray-tailnet = { $tailnet }: { $state }
tray-add-tailnet = Додати мережу tailnet…
tray-route = Маршрутизувати через інші мережі tailnet
tray-open = Відкрити { -app-name }…
tray-quit = Вийти
tray-tooltip = { -app-name }: { $summary }

## Notification the first time the window is closed

still-running-title = { -app-name } продовжує працювати
still-running-windows = Маршрутизація триває у фоні. Значок розташований в області сповіщень; Windows може сховати його під стрілкою ^ біля годинника.
still-running-macos = Маршрутизація триває у фоні. Значок розташований у рядку меню.
still-running-linux = Маршрутизація триває у фоні. Значок розташований у системному треї.

## Language names in Settings, after each language's own name

english = Англійська
french = Французька
german = Німецька
spanish-latin-america = Іспанська (Латинська Америка)
spanish-spain = Іспанська (Іспанія)
chinese-simplified = Китайська (спрощена)
chinese-traditional = Китайська (традиційна)
korean = Корейська
japanese = Японська
polish = Польська
russian = Російська
portuguese-brazil = Португальська (Бразилія)
italian = Італійська
turkish = Турецька
ukrainian = Українська
czech = Чеська
portuguese-portugal = Португальська (Португалія)
dutch = Нідерландська
indonesian = Індонезійська
vietnamese = В’єтнамська
thai = Тайська
swedish = Шведська
romanian = Румунська
hungarian = Угорська
afrikaans = Африкаанс
catalan = Каталонська
serbian-cyrillic = Сербська, кирилиця
danish = Данська
finnish = Фінська
greek = Грецька
norwegian-bokmal = Норвезька букмол
summary-proxy-problem = Підключено, але застосунки не використовують підключення
hero-proxy-taken = Браузер не відкриє адреси цих мереж tailnet: системне налаштування проксі використовує інший скрипт налаштування ({ $script }).
hero-proxy-other-copy = Браузер не відкриє адреси цих мереж tailnet: системне налаштування проксі зайняла інша копія { -app-name }. Закрийте ту копію, і ця перейме налаштування.
hero-proxy-changed = Браузер не відкриє адреси цих мереж tailnet: щось інше змінило системне налаштування проксі.
hero-proxy-failed = Браузер не відкриє адреси цих мереж tailnet: не вдалося змінити системне налаштування проксі ({ $error }).
hero-proxy-manual = Системне налаштування проксі вимкнено, тож до цих мереж tailnet потрапляють лише застосунки, які ви налаштували самі. Вкажіть у них { $pac }
proxy-replace = Замінити
proxy-replace-tooltip = Використовувати скрипт налаштування { -app-name }, поки застосунок працює, а потім повернути попередній
proxy-retry = Повторити
proxy-retry-tooltip = Знову спрямувати системне налаштування проксі на { -app-name }
system-setting = Поточне системне налаштування проксі: { $value }
system-setting-none = немає
check-updates = Перевірити наявність нових версій
find-websites = Шукати сайти на пристроях у ваших мережах tailnet
# $version is the version that's running, such as 0.6.0.
version-current = Версія { $version }
update-check-now = Перевірити
update-checking = Перевірка…
update-up-to-date = У вас найновіша версія
update-check-failed = Не вдалося перевірити оновлення
tray-update = Завантажити { -app-name } { $version }…
update-available = Вийшла версія { $version }
update-available-tooltip = У вас версія { $current }. Відкриває сторінку завантаження.
update-notify-title = Доступна версія { -app-name } { $version }
update-notify-text = Відкрийте { -app-name }, щоб завантажити її.
migrate-failed = Не вдалося перенести ваші входи з tailnet-proxy, попередньої версії цього застосунку ({ $error }). Імовірно, він досі працює. Закрийте tailnet-proxy, а потім знову запустіть { -app-name }, перш ніж входити тут: повторний вхід додасть цей комп’ютер до кожної мережі tailnet удруге.
