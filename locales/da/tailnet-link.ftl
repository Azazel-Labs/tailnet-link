### Tailnet Link: dansk katalog.
### Behold produktnavnene Tailnet Link og Tailscale, og ordet "tailnet"
### (et Tailscale-netværk): et tailnet, tailnettet, flere tailnets, tailnettene.

-app-name = Tailnet Link

## Window header

tab-tailnets = Tailnets
tab-settings = Indstillinger

## Unsaved-changes bar at the bottom of Settings

unsaved-changes = Du har ændringer, der ikke er gemt.
save = Gem
revert = Fortryd
revert-tooltip = Fortryd ændringerne
settings-saved = Indstillingerne er gemt

## Short notes at the bottom of the window

copied-address = Kopierede { $address }
copied-sign-in-link = Login-linket er kopieret

## Errors shown in the "Something went wrong" dialog

start-failed =
    { -app-name } kan ikke starte:
    { $error }
add-tailnet-failed =
    Kunne ikke tilføje et tailnet:
    { $error }
add-forward-failed =
    Kunne ikke tilføje portvideresendelsen:
    { $error }
remote-desktop-failed = Kunne ikke starte Fjernskrivebord: { $error }
remote-desktop-windows-only = Fjernskrivebord er kun indbygget i Windows.
no-free-port = Kunne ikke finde en ledig lokal port.

## Dialog after "Add a tailnet"

sign-in-dialog-title = Log ind på det nye tailnet
sign-in-dialog-text =
    Din browser åbner Tailscales login-side. Den kan åbne bag dette vindue.
    
    Log ind med din konto til det tailnet, og vend så tilbage hertil. Domænet findes automatisk.

## One tailnet's state, shown as a coloured label beside its name

state-waiting-sign-in = Venter på login
state-signed-out = Logget ud
state-problem = Problem
state-connecting = Forbinder
state-paused = På pause
state-no-domain = Intet domæne endnu
state-not-routing = Dirigerer ikke
state-routing = Dirigerer

## The whole app's state, in the status card and the tray menu

summary-no-tailnets = Ingen tailnets endnu
summary-paused = På pause
summary-routing-one = Dirigerer via { $tailnet }
summary-routing-all =
    { $count ->
        [one] Dirigerer via { $count } tailnet
       *[other] Dirigerer via { $count } tailnets
    }
summary-routing-some =
    { $count ->
        [one] Dirigerer via { $routing } af { $count } tailnet
       *[other] Dirigerer via { $routing } af { $count } tailnets
    }
summary-signed-out = Ikke logget ind
summary-problem = Problem: { $problem }
summary-connecting = Forbinder…
new-tailnet = Nyt tailnet

## Status card at the top of the Tailnets tab

hero-starting = Starter…
hero-connecting = Forbinder til dine tailnets.
hero-paused = Intet går gennem andre tailnets lige nu. Dit eget netværk og tailnet fungerer som normalt.
hero-finish-sign-in = Gør login på { $tailnet } færdigt i din browser.
hero-sign-in = Log ind på { $tailnet } for at nå dets maskiner.
hero-routing-example = Åbn { $address } eller en hvilken som helst anden adresse i disse tailnets. Alt andet går direkte.
hero-routing = Adresser i disse tailnets åbner i din browser. Alt andet går direkte.
add-tailnet = Tilføj et tailnet
pause-all = Sæt alle på pause
pause-all-tooltip = Stop dirigering gennem andre tailnets indtil videre
resume = Genoptag
resume-tooltip = Begynd at dirigere gennem andre tailnets igen

## First run, before any tailnet is added

welcome-title = Nå maskiner på andre tailnets
welcome-text = Bliv på dit eget tailnet, og åbn samtidig maskiner på andre. Din Tailscale-app fungerer som normalt.
welcome-sign-in = Log ind på et andet tailnet
welcome-sign-in-detail = Tailscales login-side åbner i din browser.
welcome-open = Åbn dets maskiner ved navn
welcome-open-detail = Adresser som { $example } virker i din browser.
welcome-forward = Videresend en port, når en app har brug for det
welcome-forward-detail = Fjernskrivebord, SSH og databaseapps får en lokal port, der fører til en maskine.

## A tailnet's card

machine-search-hint = Find en maskine efter navn, styresystem eller adresse
clear-search = Ryd søgningen
more-actions = Flere handlinger
edit-tailnet-menu = Omdøb eller tilføj domæner…
log-out-menu = Log ud…
remove-menu = Fjern…
sign-in = Log ind
pause-tailnet = Sæt dette tailnet på pause
resume-tailnet = Genoptag dette tailnet
detail-tailnet = Tailnet
detail-routes = Ruter
detail-this-computer = Denne computer
detail-problem = Problem
routes-after-sign-in = Findes, når du har logget ind
hostname-after-sign-in = { $hostname } (når du har logget ind)
sign-in-help = Åbnede browseren ikke, eller åbnede den den forkerte profil?
sign-in-open-again = Åbn login-siden igen
sign-in-copy-link = Kopiér linket
sign-in-copy-link-tooltip = Indsæt det i den browser eller browserprofil, du bruger til dette tailnet

## Machine list inside a tailnet's card

machines-online = Maskiner · { $online } af { $total } online
machines-matching = Maskiner · { $shown } af { $total } matcher
no-machines = Ingen andre maskiner er synlige på dette tailnet.
no-machine-matches = Ingen maskine matcher din søgning.
machine-offline = { $name } (offline)
forward-port-tooltip = Videresend en port: til apps, der ignorerer proxyindstillingen, f.eks. Fjernskrivebord eller en databaseklient
copy-address = Kopiér { $address }
open-in-browser = Åbn { $url } i din browser
not-routing-tooltip = Dette tailnet dirigerer ikke lige nu. Er det sat på pause?

## Websites found on the machines

sites-heading = Websites
sites-help = Maskiner på dine tailnets, der leverer et website over HTTPS. Hver maskine tjekkes højst én gang om dagen.
# $done and $total count machines.
sites-checking = Tjekker { $done } af { $total }…
sites-recheck-tooltip = Tjek alle maskiner igen nu
site-untrusted = Certifikatet er ikke godkendt som pålideligt, så din browser vil advare dig.

## Settings: port forwards

forwards-heading = Portvideresendelser
forwards-help = Til apps, der ignorerer proxyindstillingen, f.eks. Fjernskrivebord, SSH og databaseklienter. Hver videresendelse er en port på denne computer, der fører til en maskine på et tailnet.
edit-forwards = Rediger videresendelser
# Behold LOCALPORT, auto og host:port, som de er: det er dem, man skriver.
forwards-format-help = Én pr. linje: LOCALPORT = host:port, eller auto = host:port for at få valgt en ledig port. Værtens navn afgør, hvilket tailnet der bærer den. Du tilføjer hurtigt en med stikknappen ved en maskine på fanen Tailnets.
forward-cant-listen = Kan ikke lytte: { $error }
forward-port-on-save = Der vælges en port, når du gemmer
forward-no-tailnet = Intet dirigerende tailnet har dette navn
forward-via = via { $tailnet }
open-remote-desktop-to = Åbn Fjernskrivebord til { $address }

## Settings: system proxy

proxy-heading = Systemets proxyindstilling
proxy-on = Til (anbefales)
proxy-force = Til, og erstat et proxyscript fra din arbejdsplads, mens appen kører
proxy-off = Fra: jeg sætter selv mine apps op
proxy-help-windows = "Til" peger kun Windows mod denne apps regler, mens den kører og dirigerer, og sætter alt tilbage, når den stopper, sættes på pause, mister forbindelsen eller går ned.
proxy-help-macos = "Til" indstiller proxyen for dine netværkstjenester, mens appen kører, og sætter den tilbage bagefter. Hvis din Mac kræver en administratoradgangskode til det, bliver du spurgt, når dirigeringen starter, og når du afslutter.
proxy-help-linux = "Til" indstiller GNOME- eller KDE-proxyindstillingen, mens appen kører og dirigerer, og sætter den tilbage bagefter. I Firefox skal du slå Indstillinger > Netværksindstillinger > "Brug systemets proxyindstillinger" til.

## Settings: general

general-heading = Generelt
start-at-login = Start { -app-name }, når jeg logger ind
language = Sprog
system-default = Systemstandard

## Settings: troubleshooting

troubleshooting-heading = Fejlfinding
troubleshooting-help = Test en webadresse eller navn:port for at se, hvilket tailnet der bærer den, og om der er forbindelse.
test = Test
testing = Tester…
open-log = Åbn log
open-settings-folder = Åbn mappen med indstillinger
about-line = { -app-name } { $version } · lokal proxy { $proxy } · PAC { $pac }
settings-location = Indstillinger i { $path }

## Results of "Test" in Troubleshooting

check-empty = Skriv et maskinnavn eller en webadresse.
check-bad-port = { $input }: det er ikke en gyldig port.
check-not-routed = { $host } dirigeres ikke af { -app-name }: den ender ikke på domænet for noget tailnet, der dirigerer lige nu, så den går direkte (gennem dit normale netværk og dit eget Tailscale).
check-gone = Det tailnet forsvandt lige.
check-not-running = { $tailnet } kører ikke.
check-ok = { $address } virker: forbundet gennem { $tailnet } på { $ms } ms.
check-failed =
    { $host } dirigeres gennem { $tailnet }, men forbindelsen til port { $port } mislykkedes: { $error }
    Tjek, at maskinen er online, og at noget lytter på den port.
check-timeout = { $host } dirigeres gennem { $tailnet }, men port { $port } svarede ikke inden for 10 sekunder.
domain-conflict = { $domain } dirigeres også af { $tailnet }, som har forrang.

## Mistakes in typed settings

forwards-line-format = Linje { $line }: skriv LOCALPORT = host:port.
forwards-line-port = Linje { $line }: "{ $value }" er ikke et portnummer (eller auto).
forwards-line-target = Linje { $line }: "{ $value }" skal være host:port.
forwards-line-duplicate = Linje { $line }: den lokale port { $port } bruges to gange.
domain-invalid = "{ $domain }" er ikke et domæne; brug noget i stil med example.ts.net.
domain-characters = "{ $domain }" indeholder tegn, som et domæne ikke kan have.
autostart-unsupported = Start ved login understøttes ikke på dette system.

## Dialogs

ok = OK
cancel = Annuller
done = Færdig
copy = Kopiér
error-title = Noget gik galt
error-details = Detaljerne findes i { $path }
edit-title = Rediger { $tailnet }
tailnet-name = Navn
tailnet-name-hint = Vises i denne app og i menuen i meddelelsesområdet
extra-domains = Ekstra domæner (valgfrit)
extra-domains-help = Tailnettets eget domæne dirigeres automatisk. Tilføj ét pr. linje.
forward-dialog-title = Videresend en port
forward-dialog-text = Få en port på denne computer, der fører til { $host }. Hvilken port på den maskine?
port-preset-remote-desktop = Fjernskrivebord
port-tooltip = Port { $port }
port = Port
port-hint = f.eks. 8080
add-forward = Tilføj videresendelse
not-a-port = "{ $value }" er ikke et portnummer (1-65535).
forward-ready-title = Portvideresendelsen er klar
forward-ready-text = Peg din app mod denne adresse for at nå { $target }:
forward-ready-note = Porten forbliver den samme. Du finder den under Indstillinger.
open-remote-desktop = Åbn Fjernskrivebord
remove-title = Fjern dette tailnet?
remove-text = { -app-name } logger ud af { $tailnet } og glemmer det på denne computer. Du kan tilføje det igen senere.
remove = Fjern
log-out-title = Log ud?
log-out-text = Log ud af { $tailnet }? Dets adresser holder op med at virke her, indtil du logger ind igen.
log-out = Log ud

## Tray (Windows, Linux) or menu bar (macOS) menu

tray-sign-in = { $tailnet }: log ind…
tray-tailnet = { $tailnet }: { $state }
tray-add-tailnet = Tilføj et tailnet…
tray-route = Dirigér gennem andre tailnets
tray-open = Åbn { -app-name }…
tray-quit = Afslut
tray-tooltip = { -app-name }: { $summary }

## Notification the first time the window is closed

still-running-title = { -app-name } kører stadig
still-running-windows = Den bliver ved med at dirigere i baggrunden. Du finder den i meddelelsesområdet; Windows gemmer den måske under pilen ^ ved uret.
still-running-macos = Den bliver ved med at dirigere i baggrunden. Du finder den på menulinjen.
still-running-linux = Den bliver ved med at dirigere i baggrunden. Du finder den i statusområdet.

## Language names in Settings, after each language's own name

english = Engelsk
french = Fransk
german = Tysk
spanish-latin-america = Latinamerikansk spansk
spanish-spain = Spansk fra Spanien
chinese-simplified = Forenklet kinesisk
chinese-traditional = Traditionel kinesisk
korean = Koreansk
japanese = Japansk
polish = Polsk
russian = Russisk
portuguese-brazil = Brasiliansk portugisisk
italian = Italiensk
turkish = Tyrkisk
ukrainian = Ukrainsk
czech = Tjekkisk
portuguese-portugal = Europæisk portugisisk
dutch = Hollandsk
indonesian = Indonesisk
vietnamese = Vietnamesisk
thai = Thailandsk
swedish = Svensk
romanian = Rumænsk
hungarian = Ungarsk
afrikaans = Afrikaans
catalan = Catalansk
serbian-cyrillic = Serbisk, kyrillisk
danish = Dansk
finnish = Finsk
greek = Græsk
norwegian-bokmal = Norsk bokmål
summary-proxy-problem = Forbundet, men dine apps bruger ikke forbindelsen
hero-proxy-taken = Din browser åbner ikke adresser i disse tailnets: systemets proxyindstilling bruger et andet installationsscript ({ $script }).
hero-proxy-other-copy = Din browser åbner ikke adresser i disse tailnets: en anden kopi af { -app-name } har systemets proxyindstilling. Afslut den kopi, så overtager denne.
hero-proxy-changed = Din browser åbner ikke adresser i disse tailnets: noget andet har ændret systemets proxyindstilling.
hero-proxy-failed = Din browser åbner ikke adresser i disse tailnets: systemets proxyindstilling kunne ikke ændres ({ $error }).
hero-proxy-manual = Systemets proxyindstilling er slået fra, så kun apps, du selv sætter op, når disse tailnets. Peg dem mod { $pac }
proxy-replace = Erstat det
proxy-replace-tooltip = Brug installationsscriptet fra { -app-name }, mens appen kører, og sæt det andet tilbage bagefter
proxy-retry = Prøv igen
proxy-retry-tooltip = Peg systemets proxyindstilling mod { -app-name } igen
system-setting = Systemets proxyindstilling lige nu: { $value }
system-setting-none = ingen
check-updates = Søg efter nye versioner
find-websites = Søg efter websites på maskinerne på dine tailnets
# $version is the version that's running, such as 0.6.0.
version-current = Version { $version }
update-check-now = Søg nu
update-checking = Søger…
update-up-to-date = Du har den nyeste version
update-check-failed = Kunne ikke søge efter opdateringer
tray-update = Hent { -app-name } { $version }…
update-available = Version { $version } er ude
update-available-tooltip = Du har { $current }. Åbner downloadsiden.
update-notify-title = { -app-name } { $version } er tilgængelig
update-notify-text = Åbn { -app-name } for at hente den.
migrate-failed = Dine logins fra tailnet-proxy, den tidligere version af denne app, kunne ikke flyttes over ({ $error }). Den kører sandsynligvis stadig. Afslut tailnet-proxy, og start derefter { -app-name } igen, før du logger ind her: Hvis du logger ind igen, bliver denne computer tilføjet til hvert tailnet en gang til.
