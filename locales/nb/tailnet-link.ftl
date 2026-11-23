### Tailnet Link: norsk (bokmål) katalog.
### Behold produktnavnene Tailnet Link og Tailscale, og ordet «tailnet»
### (et Tailscale-nettverk): et tailnet, tailnettet, flere tailnets, tailnettene.

-app-name = Tailnet Link

## Window header

tab-tailnets = Tailnets
tab-settings = Innstillinger

## Unsaved-changes bar at the bottom of Settings

unsaved-changes = Du har endringer som ikke er lagret.
save = Lagre
revert = Tilbakestill
revert-tooltip = Angre endringene
settings-saved = Innstillingene er lagret

## Short notes at the bottom of the window

copied-address = Kopierte { $address }
copied-sign-in-link = Påloggingslenken er kopiert

## Errors shown in the "Something went wrong" dialog

start-failed =
    { -app-name } kan ikke starte:
    { $error }
add-tailnet-failed =
    Kunne ikke legge til et tailnet:
    { $error }
add-forward-failed =
    Kunne ikke legge til portvideresendingen:
    { $error }
remote-desktop-failed = Kunne ikke starte Eksternt skrivebord: { $error }
remote-desktop-windows-only = Eksternt skrivebord er bare innebygd i Windows.
no-free-port = Fant ingen ledig lokal port.

## Dialog after "Add a tailnet"

sign-in-dialog-title = Logg på det nye tailnettet
sign-in-dialog-text =
    Nettleseren åpner Tailscales påloggingsside. Den kan havne bak dette vinduet.
    
    Logg på med kontoen din for det tailnettet, og kom så tilbake hit. Domenet hentes automatisk.

## One tailnet's state, shown as a coloured label beside its name

state-waiting-sign-in = Venter på pålogging
state-signed-out = Logget av
state-problem = Problem
state-connecting = Kobler til
state-paused = Satt på pause
state-no-domain = Ikke noe domene ennå
state-not-routing = Ruter ikke
state-routing = Ruter

## The whole app's state, in the status card and the tray menu

summary-no-tailnets = Ingen tailnets ennå
summary-paused = Satt på pause
summary-routing-one = Ruter via { $tailnet }
summary-routing-all =
    { $count ->
        [one] Ruter via { $count } tailnet
       *[other] Ruter via { $count } tailnets
    }
summary-routing-some =
    { $count ->
        [one] Ruter via { $routing } av { $count } tailnet
       *[other] Ruter via { $routing } av { $count } tailnets
    }
summary-signed-out = Ikke pålogget
summary-problem = Problem: { $problem }
summary-connecting = Kobler til…
new-tailnet = Nytt tailnet

## Status card at the top of the Tailnets tab

hero-starting = Starter…
hero-connecting = Kobler til tailnettene dine.
hero-paused = Ingenting går gjennom andre tailnets akkurat nå. Ditt eget nettverk og tailnet fungerer som vanlig.
hero-finish-sign-in = Fullfør påloggingen på { $tailnet } i nettleseren.
hero-sign-in = Logg på { $tailnet } for å nå maskinene der.
hero-routing-example = Åpne { $address } eller en hvilken som helst annen adresse i disse tailnettene. Alt annet går direkte.
hero-routing = Adresser i disse tailnettene åpnes i nettleseren. Alt annet går direkte.
add-tailnet = Legg til et tailnet
pause-all = Sett alle på pause
pause-all-tooltip = Slutt å rute gjennom andre tailnets inntil videre
resume = Fortsett
resume-tooltip = Begynn å rute gjennom andre tailnets igjen

## First run, before any tailnet is added

welcome-title = Nå maskiner på andre tailnets
welcome-text = Bli på ditt eget tailnet og åpne maskiner på andre samtidig. Tailscale-appen fungerer som vanlig.
welcome-sign-in = Logg på et annet tailnet
welcome-sign-in-detail = Tailscales påloggingsside åpnes i nettleseren.
welcome-open = Åpne maskinene der ved navn
welcome-open-detail = Adresser som { $example } fungerer i nettleseren.
welcome-forward = Videresend en port når en app trenger det
welcome-forward-detail = Eksternt skrivebord, SSH og databaseapper får en lokal port som leder til en maskin.

## A tailnet's card

machine-search-hint = Finn en maskin etter navn, OS eller adresse
clear-search = Tøm søket
more-actions = Flere handlinger
edit-tailnet-menu = Gi nytt navn eller legg til domener…
log-out-menu = Logg av…
remove-menu = Fjern…
sign-in = Logg på
pause-tailnet = Sett dette tailnettet på pause
resume-tailnet = Fortsett dette tailnettet
detail-tailnet = Tailnet
detail-routes = Ruter
detail-this-computer = Denne datamaskinen
detail-problem = Problem
routes-after-sign-in = Finnes etter at du har logget på
hostname-after-sign-in = { $hostname } (etter at du har logget på)
sign-in-help = Åpnet ikke nettleseren seg, eller åpnet den feil profil?
sign-in-open-again = Åpne påloggingssiden igjen
sign-in-copy-link = Kopier lenken
sign-in-copy-link-tooltip = Lim den inn i nettleseren, eller nettleserprofilen, du bruker for dette tailnettet

## Machine list inside a tailnet's card

machines-online = Maskiner · { $online } av { $total } på nett
machines-matching = Maskiner · { $shown } av { $total } samsvarer
no-machines = Ingen andre maskiner er synlige i dette tailnettet.
no-machine-matches = Ingen maskiner samsvarer med søket.
machine-offline = { $name } (frakoblet)
forward-port-tooltip = Videresend en port: for apper som ignorerer proxy-innstillingen, som Eksternt skrivebord eller en databaseklient
copy-address = Kopier { $address }
open-in-browser = Åpne { $url } i nettleseren
not-routing-tooltip = Dette tailnettet ruter ikke akkurat nå. Er det satt på pause?

## Websites found on the machines

sites-heading = Nettsteder
sites-help = Maskiner i tailnettene dine som har et nettsted over HTTPS. Hver maskin sjekkes høyst én gang om dagen.
# $done and $total count machines.
sites-checking = Sjekker { $done } av { $total }…
sites-recheck-tooltip = Sjekk alle maskinene på nytt nå
site-untrusted = Sertifikatet er ikke klarert, så nettleseren vil advare deg.

## Settings: port forwards

forwards-heading = Portvideresendinger
forwards-help = For apper som ignorerer proxy-innstillingen, som Eksternt skrivebord, SSH og databaseklienter. Hver videresending er en port på denne datamaskinen som leder til en maskin i et tailnet.
edit-forwards = Rediger videresendinger
# Behold LOCALPORT, auto og host:port som de er: det er det du skriver.
forwards-format-help = Én per linje: LOCALPORT = host:port, eller auto = host:port for å få valgt en ledig port. Vertsnavnet avgjør hvilket tailnet som bærer den. Du legger raskt til en med støpselknappen ved en maskin i fanen Tailnets.
forward-cant-listen = Kan ikke lytte: { $error }
forward-port-on-save = En port velges når du lagrer
forward-no-tailnet = Ingen rutende tailnet har dette navnet
forward-via = via { $tailnet }
open-remote-desktop-to = Åpne Eksternt skrivebord til { $address }

## Settings: system proxy

proxy-heading = Systemets proxy-innstilling
proxy-on = På (anbefalt)
proxy-force = På, og erstatt et proxy-skript fra arbeidsplassen din mens appen kjører
proxy-off = Av: jeg setter opp appene mine selv
proxy-help-windows = «På» peker Windows mot denne appens regler bare mens den kjører og ruter, og setter alt tilbake når den stopper, settes på pause, kobles fra eller krasjer.
proxy-help-macos = «På» angir proxyen for nettverkstjenestene dine mens appen kjører, og setter den tilbake etterpå. Hvis Mac-en din krever et administratorpassord for det, blir du spurt når rutingen starter og når du avslutter.
proxy-help-linux = «På» angir proxy-innstillingen i GNOME eller KDE mens appen kjører og ruter, og setter den tilbake etterpå. I Firefox slår du på Innstillinger > Nettverksinnstillinger > «Bruk systemets proxy-innstillinger».

## Settings: general

general-heading = Generelt
start-at-login = Start { -app-name } når jeg logger på
language = Språk
system-default = Systemstandard

## Settings: troubleshooting

troubleshooting-heading = Feilsøking
troubleshooting-help = Test en nettadresse eller navn:port for å se hvilket tailnet som bærer den, og om tilkoblingen fungerer.
test = Test
testing = Tester…
open-log = Åpne logg
open-settings-folder = Åpne innstillingsmappen
about-line = { -app-name } { $version } · lokal proxy { $proxy } · PAC { $pac }
settings-location = Innstillinger i { $path }

## Results of "Test" in Troubleshooting

check-empty = Skriv inn et maskinnavn eller en nettadresse.
check-bad-port = { $input }: det er ikke en gyldig port.
check-not-routed = { $host } rutes ikke av { -app-name }: den slutter ikke på domenet til noe tailnet som ruter akkurat nå, så den går direkte (gjennom det vanlige nettverket ditt og ditt eget Tailscale).
check-gone = Det tailnettet forsvant akkurat.
check-not-running = { $tailnet } kjører ikke.
check-ok = { $address } fungerer: tilkoblet gjennom { $tailnet } på { $ms } ms.
check-failed =
    { $host } rutes gjennom { $tailnet }, men tilkoblingen til port { $port } mislyktes: { $error }
    Kontroller at maskinen er på nett og at noe lytter på den porten.
check-timeout = { $host } rutes gjennom { $tailnet }, men port { $port } svarte ikke innen 10 sekunder.
domain-conflict = { $domain } rutes også av { $tailnet }, som har forrang.

## Mistakes in typed settings

forwards-line-format = Linje { $line }: skriv LOCALPORT = host:port.
forwards-line-port = Linje { $line }: «{ $value }» er ikke et portnummer (eller auto).
forwards-line-target = Linje { $line }: «{ $value }» skal være host:port.
forwards-line-duplicate = Linje { $line }: den lokale porten { $port } brukes to ganger.
domain-invalid = «{ $domain }» er ikke et domene; bruk noe som example.ts.net.
domain-characters = «{ $domain }» inneholder tegn et domene ikke kan ha.
autostart-unsupported = Start ved pålogging støttes ikke på dette systemet.

## Dialogs

ok = OK
cancel = Avbryt
done = Ferdig
copy = Kopier
error-title = Noe gikk galt
error-details = Detaljene finnes i { $path }
edit-title = Rediger { $tailnet }
tailnet-name = Navn
tailnet-name-hint = Vises i denne appen og i menyen i systemstatusfeltet
extra-domains = Ekstra domener (valgfritt)
extra-domains-help = Tailnettets eget domene rutes automatisk. Legg til ett per linje.
forward-dialog-title = Videresend en port
forward-dialog-text = Få en port på denne datamaskinen som leder til { $host }. Hvilken port på den maskinen?
port-preset-remote-desktop = Eksternt skrivebord
port-tooltip = Port { $port }
port = Port
port-hint = f.eks. 8080
add-forward = Legg til videresending
not-a-port = «{ $value }» er ikke et portnummer (1–65535).
forward-ready-title = Portvideresendingen er klar
forward-ready-text = Pek appen mot denne adressen for å nå { $target }:
forward-ready-note = Porten forblir den samme. Du finner den i Innstillinger.
open-remote-desktop = Åpne Eksternt skrivebord
remove-title = Fjerne dette tailnettet?
remove-text = { -app-name } logger av { $tailnet } og glemmer det på denne datamaskinen. Du kan legge det til igjen senere.
remove = Fjern
log-out-title = Logge av?
log-out-text = Logge av { $tailnet }? Adressene der slutter å fungere her til du logger på igjen.
log-out = Logg av

## Tray (Windows, Linux) or menu bar (macOS) menu

tray-sign-in = { $tailnet }: logg på…
tray-tailnet = { $tailnet }: { $state }
tray-add-tailnet = Legg til et tailnet…
tray-route = Rut gjennom andre tailnets
tray-open = Åpne { -app-name }…
tray-quit = Avslutt
tray-tooltip = { -app-name }: { $summary }

## Notification the first time the window is closed

still-running-title = { -app-name } kjører fortsatt
still-running-windows = Den fortsetter å rute i bakgrunnen. Du finner den i systemstatusfeltet; Windows kan gjemme den under pilen ^ ved klokken.
still-running-macos = Den fortsetter å rute i bakgrunnen. Du finner den i menylinjen.
still-running-linux = Den fortsetter å rute i bakgrunnen. Du finner den i systemstatusfeltet.

## Language names in Settings, after each language's own name

english = Engelsk
french = Fransk
german = Tysk
spanish-latin-america = Latinamerikansk spansk
spanish-spain = Spansk fra Spania
chinese-simplified = Forenklet kinesisk
chinese-traditional = Tradisjonell kinesisk
korean = Koreansk
japanese = Japansk
polish = Polsk
russian = Russisk
portuguese-brazil = Brasiliansk portugisisk
italian = Italiensk
turkish = Tyrkisk
ukrainian = Ukrainsk
czech = Tsjekkisk
portuguese-portugal = Europeisk portugisisk
dutch = Nederlandsk
indonesian = Indonesisk
vietnamese = Vietnamesisk
thai = Thailandsk
swedish = Svensk
romanian = Rumensk
hungarian = Ungarsk
afrikaans = Afrikaans
catalan = Katalansk
serbian-cyrillic = Serbisk, kyrillisk
danish = Dansk
finnish = Finsk
greek = Gresk
norwegian-bokmal = Norsk bokmål
summary-proxy-problem = Tilkoblet, men appene dine bruker ikke tilkoblingen
hero-proxy-taken = Nettleseren åpner ikke adresser i disse tailnettene: systemets proxy-innstilling bruker et annet installasjonsskript ({ $script }).
hero-proxy-other-copy = Nettleseren åpner ikke adresser i disse tailnettene: en annen kopi av { -app-name } har systemets proxy-innstilling. Avslutt den kopien, så tar denne over.
hero-proxy-changed = Nettleseren åpner ikke adresser i disse tailnettene: noe annet har endret systemets proxy-innstilling.
hero-proxy-failed = Nettleseren åpner ikke adresser i disse tailnettene: systemets proxy-innstilling kunne ikke endres ({ $error }).
hero-proxy-manual = Systemets proxy-innstilling er av, så bare apper du setter opp selv, når disse tailnettene. Pek dem mot { $pac }
proxy-replace = Erstatt det
proxy-replace-tooltip = Bruk installasjonsskriptet til { -app-name } mens appen kjører, og sett det andre tilbake etterpå
proxy-retry = Prøv igjen
proxy-retry-tooltip = Pek systemets proxy-innstilling mot { -app-name } igjen
system-setting = Systemets proxy-innstilling nå: { $value }
system-setting-none = ingen
check-updates = Se etter nye versjoner
find-websites = Se etter nettsteder på maskinene i tailnettene dine
tray-update = Last ned { -app-name } { $version }…
update-available = Versjon { $version } er ute
update-available-tooltip = Du har { $current }. Åpner nedlastingssiden.
update-notify-title = { -app-name } { $version } er tilgjengelig
update-notify-text = Åpne { -app-name } for å laste den ned.
migrate-failed = Påloggingene dine fra tailnet-proxy, den tidligere versjonen av denne appen, kunne ikke flyttes over ({ $error }). Den kjører sannsynligvis fortsatt. Avslutt tailnet-proxy, og start deretter { -app-name } på nytt før du logger på her: Hvis du logger på igjen, blir denne datamaskinen lagt til i hvert tailnet en gang til.
