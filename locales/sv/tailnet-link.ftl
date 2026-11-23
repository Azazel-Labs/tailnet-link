### Tailnet Link: svensk katalog.
### Behåll produktnamnen Tailnet Link och Tailscale, och ordet "tailnet"
### (ett Tailscale-nätverk): ett tailnet, tailnetet, flera tailnet, tailneten.

-app-name = Tailnet Link

## Window header

tab-tailnets = Tailnet
tab-settings = Inställningar

## Unsaved-changes bar at the bottom of Settings

unsaved-changes = Du har osparade ändringar.
save = Spara
revert = Återställ
revert-tooltip = Ångra ändringarna
settings-saved = Inställningarna har sparats

## Short notes at the bottom of the window

copied-address = Kopierade { $address }
copied-sign-in-link = Inloggningslänken har kopierats

## Errors shown in the "Something went wrong" dialog

start-failed =
    { -app-name } kan inte starta:
    { $error }
add-tailnet-failed =
    Det gick inte att lägga till ett tailnet:
    { $error }
add-forward-failed =
    Det gick inte att lägga till portvidarebefordringen:
    { $error }
remote-desktop-failed = Det gick inte att starta Fjärrskrivbord: { $error }
remote-desktop-windows-only = Fjärrskrivbord finns bara inbyggt i Windows.
no-free-port = Det gick inte att hitta en ledig lokal port.

## Dialog after "Add a tailnet"

sign-in-dialog-title = Logga in på det nya tailnetet
sign-in-dialog-text =
    Webbläsaren öppnar Tailscales inloggningssida. Den kan hamna bakom det här fönstret.
    
    Logga in med ditt konto för det tailnetet och kom sedan tillbaka hit. Domänen hämtas automatiskt.

## One tailnet's state, shown as a coloured label beside its name

state-waiting-sign-in = Väntar på inloggning
state-signed-out = Utloggad
state-problem = Problem
state-connecting = Ansluter
state-paused = Pausad
state-no-domain = Ingen domän än
state-not-routing = Dirigerar inte
state-routing = Dirigerar

## The whole app's state, in the status card and the tray menu

summary-no-tailnets = Inga tailnet än
summary-paused = Pausad
summary-routing-one = Dirigerar via { $tailnet }
summary-routing-all =
    { $count ->
        [one] Dirigerar via { $count } tailnet
       *[other] Dirigerar via { $count } tailnet
    }
summary-routing-some =
    { $count ->
        [one] Dirigerar via { $routing } av { $count } tailnet
       *[other] Dirigerar via { $routing } av { $count } tailnet
    }
summary-signed-out = Inte inloggad
summary-problem = Problem: { $problem }
summary-connecting = Ansluter…
new-tailnet = Nytt tailnet

## Status card at the top of the Tailnets tab

hero-starting = Startar…
hero-connecting = Ansluter till dina tailnet.
hero-paused = Inget går via andra tailnet just nu. Ditt eget nätverk och tailnet fungerar som vanligt.
hero-finish-sign-in = Slutför inloggningen på { $tailnet } i webbläsaren.
hero-sign-in = Logga in på { $tailnet } för att nå dess datorer.
hero-routing-example = Öppna { $address } eller någon annan adress i de här tailneten. Allt annat går direkt.
hero-routing = Adresser i de här tailneten öppnas i webbläsaren. Allt annat går direkt.
add-tailnet = Lägg till ett tailnet
pause-all = Pausa alla
pause-all-tooltip = Sluta dirigera via andra tailnet tills vidare
resume = Återuppta
resume-tooltip = Börja dirigera via andra tailnet igen

## First run, before any tailnet is added

welcome-title = Nå datorer i andra tailnet
welcome-text = Stanna i ditt eget tailnet och öppna datorer i andra samtidigt. Tailscale-appen fungerar som vanligt.
welcome-sign-in = Logga in på ett annat tailnet
welcome-sign-in-detail = Tailscales inloggningssida öppnas i webbläsaren.
welcome-open = Öppna dess datorer med namn
welcome-open-detail = Adresser som { $example } fungerar i webbläsaren.
welcome-forward = Vidarebefordra en port när en app behöver det
welcome-forward-detail = Fjärrskrivbord, SSH och databasappar får en lokal port som leder till en dator.

## A tailnet's card

machine-search-hint = Sök efter dator via namn, OS eller adress
clear-search = Rensa sökningen
more-actions = Fler åtgärder
edit-tailnet-menu = Byt namn eller lägg till domäner…
log-out-menu = Logga ut…
remove-menu = Ta bort…
sign-in = Logga in
pause-tailnet = Pausa det här tailnetet
resume-tailnet = Återuppta det här tailnetet
detail-tailnet = Tailnet
detail-routes = Rutter
detail-this-computer = Den här datorn
detail-problem = Problem
routes-after-sign-in = Hittas när du har loggat in
hostname-after-sign-in = { $hostname } (när du har loggat in)
sign-in-help = Öppnades inte webbläsaren, eller öppnades fel profil?
sign-in-open-again = Öppna inloggningssidan igen
sign-in-copy-link = Kopiera länken
sign-in-copy-link-tooltip = Klistra in den i den webbläsare, eller webbläsarprofil, som du använder för det här tailnetet

## Machine list inside a tailnet's card

machines-online = Datorer · { $online } av { $total } online
machines-matching = Datorer · { $shown } av { $total } matchar
no-machines = Inga andra datorer syns i det här tailnetet.
no-machine-matches = Ingen dator matchar sökningen.
machine-offline = { $name } (offline)
forward-port-tooltip = Vidarebefordra en port: för appar som ignorerar proxyinställningen, som Fjärrskrivbord eller en databasklient
copy-address = Kopiera { $address }
open-in-browser = Öppna { $url } i webbläsaren
not-routing-tooltip = Det här tailnetet dirigerar inte just nu. Är det pausat?

## Websites found on the machines

sites-heading = Webbplatser
sites-help = Datorer i dina tailnet som har en webbplats över HTTPS. Varje dator kontrolleras högst en gång om dagen.
# $done and $total count machines.
sites-checking = Kontrollerar { $done } av { $total }…
sites-recheck-tooltip = Kontrollera alla datorer igen nu
site-untrusted = Certifikatet är inte betrott, så webbläsaren kommer att varna dig.

## Settings: port forwards

forwards-heading = Portvidarebefordringar
forwards-help = För appar som ignorerar proxyinställningen, som Fjärrskrivbord, SSH och databasklienter. Varje vidarebefordring är en port på den här datorn som leder till en dator i ett tailnet.
edit-forwards = Redigera vidarebefordringar
# Behåll LOCALPORT, auto och host:port som de är: det är det man skriver.
forwards-format-help = En per rad: LOCALPORT = host:port, eller auto = host:port för att få en ledig port vald. Värdnamnet avgör vilket tailnet som bär trafiken. Snabbast lägger du till en med kontaktknappen vid en dator på fliken Tailnet.
forward-cant-listen = Kan inte lyssna: { $error }
forward-port-on-save = En port väljs när du sparar
forward-no-tailnet = Inget dirigerande tailnet har det här namnet
forward-via = via { $tailnet }
open-remote-desktop-to = Öppna Fjärrskrivbord till { $address }

## Settings: system proxy

proxy-heading = Systemets proxyinställning
proxy-on = På (rekommenderas)
proxy-force = På, och ersätt ett proxyskript från ditt företag medan appen körs
proxy-off = Av: jag ställer in mina appar själv
proxy-help-windows = ”På” pekar Windows mot appens regler bara medan den körs och dirigerar, och återställer allt när den stoppas, pausas, kopplas från eller kraschar.
proxy-help-macos = ”På” ställer in proxyn för dina nätverkstjänster medan appen körs och återställer den efteråt. Om din Mac kräver ett administratörslösenord för det får du frågan när dirigeringen startar och när du avslutar.
proxy-help-linux = ”På” ställer in proxyinställningen i GNOME eller KDE medan appen körs och dirigerar, och återställer den efteråt. I Firefox slår du på Inställningar > Nätverksinställningar > ”Använd systemets proxyinställningar”.

## Settings: general

general-heading = Allmänt
start-at-login = Starta { -app-name } när jag loggar in
language = Språk
system-default = Systemspråk

## Settings: troubleshooting

troubleshooting-heading = Felsökning
troubleshooting-help = Testa en webbadress eller namn:port för att se vilket tailnet som bär den och om anslutningen fungerar.
test = Testa
testing = Testar…
open-log = Öppna logg
open-settings-folder = Öppna inställningsmappen
about-line = { -app-name } { $version } · lokal proxy { $proxy } · PAC { $pac }
settings-location = Inställningar i { $path }

## Results of "Test" in Troubleshooting

check-empty = Skriv ett datornamn eller en webbadress.
check-bad-port = { $input }: det är ingen giltig port.
check-not-routed = { $host } dirigeras inte av { -app-name }: adressen slutar inte på domänen för något tailnet som dirigerar just nu, så den går direkt (via ditt vanliga nätverk och ditt eget Tailscale).
check-gone = Det tailnetet försvann precis.
check-not-running = { $tailnet } körs inte.
check-ok = { $address } fungerar: ansluten via { $tailnet } på { $ms } ms.
check-failed =
    { $host } dirigeras via { $tailnet }, men anslutningen till port { $port } misslyckades: { $error }
    Kontrollera att datorn är online och att något lyssnar på den porten.
check-timeout = { $host } dirigeras via { $tailnet }, men port { $port } svarade inte inom 10 sekunder.
domain-conflict = { $domain } dirigeras också av { $tailnet }, som har företräde.

## Mistakes in typed settings

forwards-line-format = Rad { $line }: skriv LOCALPORT = host:port.
forwards-line-port = Rad { $line }: ”{ $value }” är inte ett portnummer (eller auto).
forwards-line-target = Rad { $line }: ”{ $value }” ska vara host:port.
forwards-line-duplicate = Rad { $line }: den lokala porten { $port } används två gånger.
domain-invalid = ”{ $domain }” är ingen domän; använd något i stil med example.ts.net.
domain-characters = ”{ $domain }” innehåller tecken som en domän inte kan ha.
autostart-unsupported = Start vid inloggning stöds inte på det här systemet.

## Dialogs

ok = OK
cancel = Avbryt
done = Klar
copy = Kopiera
error-title = Något gick fel
error-details = Detaljer finns i { $path }
edit-title = Redigera { $tailnet }
tailnet-name = Namn
tailnet-name-hint = Visas i appen och i menyn i systemfältet
extra-domains = Extra domäner (valfritt)
extra-domains-help = Tailnetets egen domän dirigeras automatiskt. Lägg till en per rad.
forward-dialog-title = Vidarebefordra en port
forward-dialog-text = Få en port på den här datorn som leder till { $host }. Vilken port på den datorn?
port-preset-remote-desktop = Fjärrskrivbord
port-tooltip = Port { $port }
port = Port
port-hint = t.ex. 8080
add-forward = Lägg till vidarebefordring
not-a-port = ”{ $value }” är inte ett portnummer (1–65535).
forward-ready-title = Portvidarebefordringen är klar
forward-ready-text = Peka appen mot den här adressen för att nå { $target }:
forward-ready-note = Porten förblir densamma. Du hittar den i Inställningar.
open-remote-desktop = Öppna Fjärrskrivbord
remove-title = Ta bort det här tailnetet?
remove-text = { -app-name } loggar ut från { $tailnet } och glömmer det på den här datorn. Du kan lägga till det igen senare.
remove = Ta bort
log-out-title = Logga ut?
log-out-text = Logga ut från { $tailnet }? Dess adresser slutar fungera här tills du loggar in igen.
log-out = Logga ut

## Tray (Windows, Linux) or menu bar (macOS) menu

tray-sign-in = { $tailnet }: logga in…
tray-tailnet = { $tailnet }: { $state }
tray-add-tailnet = Lägg till ett tailnet…
tray-route = Dirigera via andra tailnet
tray-open = Öppna { -app-name }…
tray-quit = Avsluta
tray-tooltip = { -app-name }: { $summary }

## Notification the first time the window is closed

still-running-title = { -app-name } körs fortfarande
still-running-windows = Appen fortsätter att dirigera i bakgrunden. Du hittar den i meddelandefältet; Windows kan gömma den under pilen ^ vid klockan.
still-running-macos = Appen fortsätter att dirigera i bakgrunden. Du hittar den i menyraden.
still-running-linux = Appen fortsätter att dirigera i bakgrunden. Du hittar den i systemfältet.

## Language names in Settings, after each language's own name

english = Engelska
french = Franska
german = Tyska
spanish-latin-america = Latinamerikansk spanska
spanish-spain = Spanska från Spanien
chinese-simplified = Förenklad kinesiska
chinese-traditional = Traditionell kinesiska
korean = Koreanska
japanese = Japanska
polish = Polska
russian = Ryska
portuguese-brazil = Brasiliansk portugisiska
italian = Italienska
turkish = Turkiska
ukrainian = Ukrainska
czech = Tjeckiska
portuguese-portugal = Europeisk portugisiska
dutch = Nederländska
indonesian = Indonesiska
vietnamese = Vietnamesiska
thai = Thailändska
swedish = Svenska
romanian = Rumänska
hungarian = Ungerska
afrikaans = Afrikaans
catalan = Katalanska
serbian-cyrillic = Serbiska, kyrilliska
danish = Danska
finnish = Finska
greek = Grekiska
norwegian-bokmal = Norskt bokmål
summary-proxy-problem = Ansluten, men dina appar använder inte anslutningen
hero-proxy-taken = Webbläsaren öppnar inte adresser i de här tailneten: systemets proxyinställning använder ett annat konfigurationsskript ({ $script }).
hero-proxy-other-copy = Webbläsaren öppnar inte adresser i de här tailneten: en annan kopia av { -app-name } har systemets proxyinställning. Avsluta den kopian, så tar den här över.
hero-proxy-changed = Webbläsaren öppnar inte adresser i de här tailneten: något annat har ändrat systemets proxyinställning.
hero-proxy-failed = Webbläsaren öppnar inte adresser i de här tailneten: systemets proxyinställning kunde inte ändras ({ $error }).
hero-proxy-manual = Systemets proxyinställning är av, så bara appar som du ställer in själv når de här tailneten. Peka dem mot { $pac }
proxy-replace = Ersätt det
proxy-replace-tooltip = Använd konfigurationsskriptet från { -app-name } medan appen körs och återställ det andra efteråt
proxy-retry = Försök igen
proxy-retry-tooltip = Peka systemets proxyinställning mot { -app-name } igen
system-setting = Systemets proxyinställning nu: { $value }
system-setting-none = ingen
check-updates = Sök efter nya versioner
find-websites = Leta efter webbplatser på datorerna i dina tailnet
# $version is the version that's running, such as 0.6.0.
version-current = Version { $version }
update-check-now = Sök nu
update-checking = Söker…
update-up-to-date = Du har den senaste versionen
update-check-failed = Det gick inte att söka efter uppdateringar
tray-update = Ladda ned { -app-name } { $version }…
update-available = Version { $version } är ute
update-available-tooltip = Du har { $current }. Öppnar nedladdningssidan.
update-notify-title = { -app-name } { $version } finns tillgänglig
update-notify-text = Öppna { -app-name } för att ladda ned den.
migrate-failed = Dina inloggningar från tailnet-proxy, den tidigare versionen av den här appen, kunde inte flyttas över ({ $error }). Den körs troligen fortfarande. Avsluta tailnet-proxy och starta sedan { -app-name } igen innan du loggar in här: om du loggar in igen läggs den här datorn till i varje tailnet en andra gång.
