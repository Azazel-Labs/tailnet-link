### Tailnet Link: katalog polski.
### Nazwy Tailnet Link i Tailscale zostają bez zmian. „tailnet” nie jest odmieniany:
### używaj konstrukcji „sieć tailnet” i odmieniaj słowo „sieć”.

-app-name = Tailnet Link

## Window header

tab-tailnets = Sieci tailnet
tab-settings = Ustawienia

## Unsaved-changes bar at the bottom of Settings

unsaved-changes = Masz niezapisane zmiany.
save = Zapisz
revert = Przywróć
revert-tooltip = Cofnij zmiany
settings-saved = Zapisano ustawienia

## Short notes at the bottom of the window

copied-address = Skopiowano { $address }
copied-sign-in-link = Skopiowano link logowania

## Errors shown in the "Something went wrong" dialog

start-failed =
    Nie można uruchomić aplikacji { -app-name }:
    { $error }
add-tailnet-failed =
    Nie udało się dodać sieci tailnet:
    { $error }
add-forward-failed =
    Nie udało się dodać przekierowania portu:
    { $error }
remote-desktop-failed = Nie udało się uruchomić Pulpitu zdalnego: { $error }
remote-desktop-windows-only = Pulpit zdalny jest wbudowany tylko w system Windows.
no-free-port = Nie znaleziono wolnego portu lokalnego.

## Dialog after "Add a tailnet"

sign-in-dialog-title = Zaloguj się do nowej sieci tailnet
sign-in-dialog-text =
    Przeglądarka otwiera stronę logowania Tailscale. Może się ona otworzyć za tym oknem.
    
    Zaloguj się na konto tej sieci tailnet, a potem wróć tutaj. Jej domena zostanie wykryta automatycznie.

## One tailnet's state, shown as a coloured label beside its name

state-waiting-sign-in = Czeka na zalogowanie
state-signed-out = Wylogowano
state-problem = Problem
state-connecting = Łączenie
state-paused = Wstrzymano
state-no-domain = Brak domeny
state-not-routing = Routing nieaktywny
state-routing = Routing aktywny

## The whole app's state, in the status card and the tray menu

summary-no-tailnets = Brak sieci tailnet
summary-paused = Wstrzymano
summary-routing-one = Routing przez { $tailnet }
summary-routing-all =
    { $count ->
        [one] Routing przez { $count } sieć tailnet
        [few] Routing przez { $count } sieci tailnet
        [many] Routing przez { $count } sieci tailnet
       *[other] Routing przez { $count } sieci tailnet
    }
summary-routing-some =
    { $count ->
        [one] Routing przez { $routing } z { $count } sieci tailnet
        [few] Routing przez { $routing } z { $count } sieci tailnet
        [many] Routing przez { $routing } z { $count } sieci tailnet
       *[other] Routing przez { $routing } z { $count } sieci tailnet
    }
summary-signed-out = Nie zalogowano
summary-problem = Problem: { $problem }
summary-connecting = Łączenie…
new-tailnet = Nowa sieć tailnet

## Status card at the top of the Tailnets tab

hero-starting = Uruchamianie…
hero-connecting = Łączenie z sieciami tailnet.
hero-paused = Teraz nic nie przechodzi przez inne sieci tailnet. Twoja sieć lokalna i własna sieć tailnet działają jak zwykle.
hero-finish-sign-in = Dokończ logowanie do { $tailnet } w przeglądarce.
hero-sign-in = Zaloguj się do { $tailnet }, aby otwierać urządzenia tej sieci.
hero-routing-example = Otwórz { $address } lub dowolny inny adres w tych sieciach tailnet. Cała reszta idzie bezpośrednio.
hero-routing = Adresy w tych sieciach tailnet otwierają się w przeglądarce. Cała reszta idzie bezpośrednio.
add-tailnet = Dodaj sieć tailnet
pause-all = Wstrzymaj wszystko
pause-all-tooltip = Tymczasowo zatrzymaj routing przez inne sieci tailnet
resume = Wznów
resume-tooltip = Wznów routing przez inne sieci tailnet

## First run, before any tailnet is added

welcome-title = Dostęp do urządzeń w innych sieciach tailnet
welcome-text = Zostań we własnej sieci tailnet i jednocześnie otwieraj urządzenia w innych. Aplikacja Tailscale działa jak zwykle.
welcome-sign-in = Zaloguj się do innej sieci tailnet
welcome-sign-in-detail = Strona logowania Tailscale otworzy się w przeglądarce.
welcome-open = Otwieraj jej urządzenia po nazwie
welcome-open-detail = Adresy takie jak { $example } działają w przeglądarce.
welcome-forward = Przekieruj port, gdy aplikacja go potrzebuje
welcome-forward-detail = Pulpit zdalny, SSH i klienty baz danych dostają lokalny port prowadzący do urządzenia.

## A tailnet's card

machine-search-hint = Znajdź urządzenie po nazwie, systemie lub adresie
clear-search = Wyczyść wyszukiwanie
more-actions = Więcej działań
edit-tailnet-menu = Zmień nazwę lub dodaj domeny…
log-out-menu = Wyloguj…
remove-menu = Usuń…
sign-in = Zaloguj się
pause-tailnet = Wstrzymaj tę sieć tailnet
resume-tailnet = Wznów tę sieć tailnet
detail-tailnet = Sieć tailnet
detail-routes = Trasy
detail-this-computer = Ten komputer
detail-problem = Problem
routes-after-sign-in = Pojawią się po zalogowaniu
hostname-after-sign-in = { $hostname } (po zalogowaniu)
sign-in-help = Przeglądarka się nie otworzyła lub otworzyła zły profil?
sign-in-open-again = Otwórz ponownie stronę logowania
sign-in-copy-link = Skopiuj link
sign-in-copy-link-tooltip = Wklej go do przeglądarki lub profilu przeglądarki, którego używasz dla tej sieci tailnet

## Machine list inside a tailnet's card

machines-online = Urządzenia · online: { $online } z { $total }
machines-matching = Urządzenia · pasuje: { $shown } z { $total }
no-machines = W tej sieci tailnet nie widać innych urządzeń.
no-machine-matches = Żadne urządzenie nie pasuje do wyszukiwania.
machine-offline = { $name } (offline)
forward-port-tooltip = Przekieruj port: dla aplikacji, które ignorują ustawienie proxy, takich jak Pulpit zdalny czy klient bazy danych
copy-address = Skopiuj { $address }
open-in-browser = Otwórz { $url } w przeglądarce
not-routing-tooltip = Ta sieć tailnet nie przekazuje teraz ruchu. Czy jest wstrzymana?

## Settings: port forwards

forwards-heading = Przekierowania portów
forwards-help = Dla aplikacji, które ignorują ustawienie proxy, takich jak Pulpit zdalny, SSH i klienty baz danych. Każde przekierowanie to port na tym komputerze prowadzący do urządzenia w sieci tailnet.
edit-forwards = Edytuj przekierowania
# LOCALPORT, auto i host:port zostają bez zmian: to wpisuje użytkownik.
forwards-format-help = Jedno w wierszu: LOCALPORT = host:port lub auto = host:port, aby wolny port został wybrany automatycznie. Nazwa hosta decyduje, która sieć tailnet przeniesie ruch. Aby szybko dodać przekierowanie, użyj przycisku z wtyczką przy urządzeniu na karcie „Sieci tailnet”.
forward-cant-listen = Nie można nasłuchiwać: { $error }
forward-port-on-save = Port zostanie wybrany przy zapisie
forward-no-tailnet = Żadna aktywna sieć tailnet nie ma tej nazwy
forward-via = przez { $tailnet }
open-remote-desktop-to = Połącz z { $address } przez Pulpit zdalny

## Settings: system proxy

proxy-heading = Systemowe ustawienie proxy
proxy-on = Włączone (zalecane)
proxy-force = Włączone, z zastąpieniem firmowego skryptu proxy na czas działania
proxy-off = Wyłączone: skonfiguruję aplikacje ręcznie
proxy-help-windows = „Włączone” kieruje Windows na reguły tej aplikacji tylko wtedy, gdy działa i przekazuje ruch, a przywraca poprzedni stan, gdy się zatrzyma, wstrzyma, rozłączy lub ulegnie awarii.
proxy-help-macos = „Włączone” ustawia proxy dla usług sieciowych, gdy aplikacja działa, a potem przywraca poprzedni stan. Jeśli Mac wymaga do tego hasła administratora, poprosi o nie przy starcie routingu i przy zamykaniu aplikacji.
proxy-help-linux = „Włączone” ustawia proxy w GNOME lub KDE, gdy aplikacja działa i przekazuje ruch, a potem przywraca poprzedni stan. W przeglądarce Firefox włącz Ustawienia > Ustawienia sieci > „Używaj systemowych ustawień serwerów proxy”.

## Settings: general

general-heading = Ogólne
start-at-login = Uruchamiaj aplikację { -app-name } po zalogowaniu
language = Język
system-default = Domyślny język systemu

## Settings: troubleshooting

troubleshooting-heading = Rozwiązywanie problemów
troubleshooting-help = Przetestuj adres internetowy lub nazwa:port, aby sprawdzić, która sieć tailnet go obsługuje i czy połączenie działa.
test = Testuj
testing = Testowanie…
open-log = Otwórz dziennik
open-settings-folder = Otwórz folder ustawień
about-line = { -app-name } { $version } · lokalne proxy { $proxy } · PAC { $pac }
settings-location = Ustawienia są w { $path }

## Results of "Test" in Troubleshooting

check-empty = Wpisz nazwę urządzenia lub adres internetowy.
check-bad-port = { $input }: to nie jest prawidłowy port.
check-not-routed = { -app-name } nie obsługuje { $host }: adres nie kończy się domeną żadnej aktywnej teraz sieci tailnet, więc idzie bezpośrednio (przez zwykłą sieć i własny Tailscale).
check-gone = Ta sieć tailnet właśnie zniknęła.
check-not-running = Sieć { $tailnet } nie działa.
check-ok = { $address } działa: połączono przez { $tailnet } w { $ms } ms.
check-failed =
    Ruch do { $host } idzie przez { $tailnet }, ale połączenie z portem { $port } nie powiodło się: { $error }
    Sprawdź, czy urządzenie jest online i czy coś nasłuchuje na tym porcie.
check-timeout = Ruch do { $host } idzie przez { $tailnet }, ale port { $port } nie odpowiedział w ciągu 10 sekund.
domain-conflict = Domenę { $domain } obsługuje też sieć { $tailnet } i to ona ma pierwszeństwo.

## Mistakes in typed settings

forwards-line-format = Wiersz { $line }: wpisz LOCALPORT = host:port.
forwards-line-port = Wiersz { $line }: „{ $value }” nie jest numerem portu (ani auto).
forwards-line-target = Wiersz { $line }: „{ $value }” powinno mieć postać host:port.
forwards-line-duplicate = Wiersz { $line }: port lokalny { $port } występuje dwa razy.
domain-invalid = „{ $domain }” nie jest domeną; użyj czegoś w rodzaju example.ts.net.
domain-characters = „{ $domain }” zawiera znaki niedozwolone w domenie.
autostart-unsupported = Uruchamianie po zalogowaniu nie jest obsługiwane w tym systemie.

## Dialogs

ok = OK
cancel = Anuluj
done = Gotowe
copy = Kopiuj
error-title = Coś poszło nie tak
error-details = Szczegóły w { $path }
edit-title = Edytuj sieć { $tailnet }
tailnet-name = Nazwa
tailnet-name-hint = Wyświetlana w tej aplikacji i w menu w zasobniku
extra-domains = Dodatkowe domeny (opcjonalnie)
extra-domains-help = Własna domena sieci tailnet jest obsługiwana automatycznie. Dodaj po jednej w wierszu.
forward-dialog-title = Przekieruj port
forward-dialog-text = Uzyskaj port na tym komputerze prowadzący do { $host }. Który port na tamtym urządzeniu?
port-preset-remote-desktop = Pulpit zdalny
port-tooltip = Port { $port }
port = Port
port-hint = np. 8080
add-forward = Dodaj przekierowanie
not-a-port = „{ $value }” nie jest numerem portu (1–65535).
forward-ready-title = Przekierowanie portu gotowe
forward-ready-text = Skieruj aplikację na ten adres, aby połączyć się z { $target }:
forward-ready-note = Port się nie zmienia. Znajdziesz go w Ustawieniach.
open-remote-desktop = Otwórz Pulpit zdalny
remove-title = Usunąć tę sieć tailnet?
remove-text = { -app-name } wyloguje się z sieci { $tailnet } i zapomni o niej na tym komputerze. Możesz ją później dodać ponownie.
remove = Usuń
log-out-title = Wylogować się?
log-out-text = Wylogować się z sieci { $tailnet }? Jej adresy przestaną tu działać, dopóki nie zalogujesz się ponownie.
log-out = Wyloguj

## Tray (Windows, Linux) or menu bar (macOS) menu

tray-sign-in = { $tailnet }: zaloguj się…
tray-tailnet = { $tailnet }: { $state }
tray-add-tailnet = Dodaj sieć tailnet…
tray-route = Kieruj ruch przez inne sieci tailnet
tray-open = Otwórz { -app-name }…
tray-quit = Zakończ
tray-tooltip = { -app-name }: { $summary }

## Notification the first time the window is closed

still-running-title = { -app-name } nadal działa
still-running-windows = Routing działa dalej w tle. Ikona jest w zasobniku systemowym; Windows może ukryć ją pod strzałką ^ obok zegara.
still-running-macos = Routing działa dalej w tle. Ikona jest na pasku menu.
still-running-linux = Routing działa dalej w tle. Ikona jest w zasobniku systemowym.

## Language names in Settings, after each language's own name

english = Angielski
french = Francuski
german = Niemiecki
spanish-latin-america = Hiszpański latynoamerykański
spanish-spain = Hiszpański z Hiszpanii
chinese-simplified = Chiński uproszczony
chinese-traditional = Chiński tradycyjny
korean = Koreański
japanese = Japoński
polish = Polski
russian = Rosyjski
portuguese-brazil = Portugalski brazylijski
italian = Włoski
turkish = Turecki
ukrainian = Ukraiński
czech = Czeski
portuguese-portugal = Portugalski europejski
dutch = Niderlandzki
indonesian = Indonezyjski
vietnamese = Wietnamski
thai = Tajski
swedish = Szwedzki
romanian = Rumuński
hungarian = Węgierski
afrikaans = Afrikaans
catalan = Kataloński
serbian-cyrillic = Serbski, cyrylica
danish = Duński
finnish = Fiński
greek = Grecki
norwegian-bokmal = Norweski bokmål
