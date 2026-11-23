### Tailnet Link: Nederlandse catalogus.
### Laat de namen Tailnet Link en Tailscale en het woord "tailnet" (een Tailscale-netwerk) staan.

-app-name = Tailnet Link

## Vensterkop

tab-tailnets = Tailnets
tab-settings = Instellingen

## Balk voor niet-opgeslagen wijzigingen onder in Instellingen

unsaved-changes = Je hebt niet-opgeslagen wijzigingen.
save = Opslaan
revert = Terugdraaien
revert-tooltip = De wijzigingen ongedaan maken
settings-saved = Instellingen opgeslagen

## Korte meldingen onder in het venster

copied-address = { $address } gekopieerd
copied-sign-in-link = Inloglink gekopieerd

## Fouten in het venster 'Er ging iets mis'

start-failed =
    { -app-name } kan niet starten:
    { $error }
add-tailnet-failed =
    Kan geen tailnet toevoegen:
    { $error }
add-forward-failed =
    Kan de poortdoorsturing niet toevoegen:
    { $error }
remote-desktop-failed = Kan Extern bureaublad niet starten: { $error }
remote-desktop-windows-only = Extern bureaublad is alleen in Windows ingebouwd.
no-free-port = Kan geen vrije lokale poort vinden.

## Venster na 'Tailnet toevoegen'

sign-in-dialog-title = Log in bij het nieuwe tailnet
sign-in-dialog-text =
    Je browser opent de inlogpagina van Tailscale. Die kan achter dit venster openen.
    
    Log in met je account voor dat tailnet en kom daarna hier terug. Het domein wordt automatisch gevonden.

## Status van een tailnet, als gekleurd label naast de naam

state-waiting-sign-in = Wacht op inloggen
state-signed-out = Uitgelogd
state-problem = Probleem
state-connecting = Verbinden
state-paused = Gepauzeerd
state-no-domain = Nog geen domein
state-not-routing = Routeert niet
state-routing = Routeert

## Status van de hele app, in de statuskaart en het systeemvakmenu

summary-no-tailnets = Nog geen tailnets
summary-paused = Gepauzeerd
summary-routing-one = Routeert via { $tailnet }
summary-routing-all =
    { $count ->
        [one] Routeert via { $count } tailnet
       *[other] Routeert via { $count } tailnets
    }
summary-routing-some =
    { $count ->
        [one] Routeert via { $routing } van { $count } tailnet
       *[other] Routeert via { $routing } van { $count } tailnets
    }
summary-signed-out = Niet ingelogd
summary-problem = Probleem: { $problem }
summary-connecting = Verbinden…
new-tailnet = Nieuw tailnet

## Statuskaart boven in het tabblad Tailnets

hero-starting = Starten…
hero-connecting = Verbinden met je tailnets.
hero-paused = Er gaat nu niets via andere tailnets. Je eigen netwerk en tailnet werken gewoon.
hero-finish-sign-in = Rond het inloggen bij { $tailnet } af in je browser.
hero-sign-in = Log in bij { $tailnet } om de machines ervan te bereiken.
hero-routing-example = Open { $address } of een ander adres in deze tailnets. Al het andere gaat rechtstreeks.
hero-routing = Adressen in deze tailnets openen in je browser. Al het andere gaat rechtstreeks.
add-tailnet = Tailnet toevoegen
pause-all = Alles pauzeren
pause-all-tooltip = Voorlopig niet meer via andere tailnets routeren
resume = Hervatten
resume-tooltip = Weer via andere tailnets routeren

## Eerste start, voordat er een tailnet is toegevoegd

welcome-title = Bereik machines in andere tailnets
welcome-text = Blijf op je eigen tailnet en open tegelijk machines in andere. Je Tailscale-app blijft gewoon werken.
welcome-sign-in = Log in bij een ander tailnet
welcome-sign-in-detail = De inlogpagina van Tailscale opent in je browser.
welcome-open = Open de machines ervan op naam
welcome-open-detail = Adressen zoals { $example } werken in je browser.
welcome-forward = Stuur een poort door als een app er een nodig heeft
welcome-forward-detail = Extern bureaublad, SSH en database-apps krijgen een lokale poort die naar een machine leidt.

## Kaart van een tailnet

machine-search-hint = Zoek een machine op naam, besturingssysteem of adres
clear-search = Zoekopdracht wissen
open-terminal-tooltip = Open een terminal waarin de namen uit je tailnets werken, voor curl, git, ssh, ping en meer. Of zet tl voor elke opdracht in elke terminal.
open-terminal-missing = { -app-name } kan tl, het bijbehorende terminalhulpprogramma, niet naast de app vinden. Installeer { -app-name } opnieuw om het te krijgen.
open-terminal-failed = Kan geen terminal openen: { $error }
more-actions = Meer acties
edit-tailnet-menu = Naam wijzigen of domeinen toevoegen…
log-out-menu = Uitloggen…
remove-menu = Verwijderen…
sign-in = Inloggen
pause-tailnet = Dit tailnet pauzeren
resume-tailnet = Dit tailnet hervatten
detail-tailnet = Tailnet
detail-routes = Routes
detail-this-computer = Deze computer
detail-problem = Probleem
routes-after-sign-in = Gevonden nadat je inlogt
hostname-after-sign-in = { $hostname } (nadat je inlogt)
sign-in-help = Opende de browser niet, of in het verkeerde profiel?
sign-in-open-again = Inlogpagina opnieuw openen
sign-in-copy-link = Link kopiëren
sign-in-copy-link-tooltip = Plak hem in de browser, of het browserprofiel, dat je voor dit tailnet gebruikt

## Machinelijst in de kaart van een tailnet

machines-online = Machines · { $online } van { $total } online
machines-matching = Machines · { $shown } van { $total } komen overeen
no-machines = Er zijn geen andere machines zichtbaar in dit tailnet.
no-machine-matches = Geen machine komt overeen met je zoekopdracht.
machine-offline = { $name } (offline)
forward-port-tooltip = Poort doorsturen: voor apps die de proxyinstelling negeren, zoals Extern bureaublad of een databaseclient
copy-address = { $address } kopiëren
open-in-browser = { $url } openen in je browser
not-routing-tooltip = Dit tailnet routeert nu niet. Is het gepauzeerd?

## Websites op de machines

sites-heading = Websites
sites-help = Machines in je tailnets die een website via HTTPS aanbieden. Elke machine wordt hooguit één keer per dag gecontroleerd.
# $done en $total tellen machines.
sites-checking = { $done } van { $total } controleren…
sites-recheck-tooltip = Alle machines nu opnieuw controleren
site-untrusted = Het certificaat wordt niet vertrouwd, dus je browser geeft een waarschuwing.
site-favorite-add = Toevoegen aan favorieten
site-favorite-remove = Verwijderen uit favorieten
sites-show-all = Alle websites tonen ({ $count })
sites-show-fewer = Minder tonen

## Instellingen: doorgestuurde poorten

forwards-heading = Doorgestuurde poorten
forwards-help = Voor apps die de proxyinstelling negeren, zoals Extern bureaublad, SSH en databaseclients. Elke doorsturing is een poort op deze computer die naar een machine in een tailnet leidt.
edit-forwards = Doorsturingen bewerken
# Laat LOCALPORT, auto en host:port staan: dat is wat je typt.
forwards-format-help = Eén per regel: LOCALPORT = host:port, of auto = host:port om een vrije poort te laten kiezen. De naam van de host bepaalt welk tailnet het verkeer draagt. Snel een toevoegen? Gebruik de stekkerknop bij een machine in het tabblad Tailnets.
forward-cant-listen = Kan niet luisteren: { $error }
forward-port-on-save = Er wordt een poort gekozen bij het opslaan
forward-no-tailnet = Geen routerend tailnet heeft deze naam
forward-via = via { $tailnet }
open-remote-desktop-to = Extern bureaublad naar { $address } openen

## Instellingen: systeemproxy

proxy-heading = Proxyinstelling van het systeem
proxy-on = Aan (aanbevolen)
proxy-force = Aan, en een proxyscript van je bedrijf vervangen zolang de app draait
proxy-off = Uit: ik stel mijn apps zelf in
proxy-help-windows = 'Aan' laat Windows alleen de regels van deze app gebruiken zolang die draait en routeert, en zet alles terug wanneer de app stopt, pauzeert, de verbinding verliest of crasht.
proxy-help-macos = 'Aan' stelt de proxy voor je netwerkservices in zolang de app draait en zet hem daarna terug. Als je Mac daarvoor een beheerderswachtwoord nodig heeft, wordt dat gevraagd wanneer het routeren begint en wanneer je afsluit.
proxy-help-linux = 'Aan' stelt de proxyinstelling van GNOME of KDE in zolang de app draait en routeert, en zet die daarna terug. Zet in Firefox Instellingen > Netwerkinstellingen > 'Systeemproxy-instellingen gebruiken' aan.

## Instellingen: algemeen

general-heading = Algemeen
start-at-login = { -app-name } starten wanneer ik inlog
language = Taal
system-default = Systeemtaal

## Instellingen: probleemoplossing

troubleshooting-heading = Probleemoplossing
troubleshooting-help = Test een webadres of naam:poort om te zien welk tailnet het verkeer draagt en of er verbinding is.
test = Testen
testing = Testen…
open-log = Logboek openen
open-settings-folder = Instellingenmap openen
about-line = { -app-name } { $version } · lokale proxy { $proxy } · PAC { $pac }
settings-location = Instellingen in { $path }

## Instellingen: namen

names-heading = Namen
names-help = Eigen namen voor adressen in je tailnets, zoals een server achter een subnetrouter. Ze werken alleen in browsers en doorgestuurde poorten op deze computer.
edit-names = Namen bewerken
# Laat ‘name = address’ en het voorbeeld staan: dat is wat je typt.
names-format-help = Eén per regel: name = address, bijvoorbeeld wiki = 192.168.20.15. Het adres kan een IP-adres of de naam van een machine zijn. Open het als http://wiki:8080/, met de poort die de website gebruikt.

## Resultaten van 'Testen' in Probleemoplossing

check-empty = Typ een machinenaam of een webadres.
check-bad-port = { $input }: dat is geen geldige poort.
check-not-routed = { $host } wordt niet gerouteerd door { -app-name }: het is geen naam, adres of subnet van een tailnet dat nu routeert, dus het gaat rechtstreeks (via je normale netwerk en je eigen Tailscale).
# $tailnets lists the tailnets, separated by commas.
check-ambiguous = { $host } zit in meer dan één tailnet ({ $tailnets }), dus het wordt niet gerouteerd. Gebruik in plaats daarvan de naam van de machine, of zet subnetten uit voor een van die tailnets.
check-gone = Dat tailnet is net verdwenen.
check-not-running = { $tailnet } draait niet.
ping-no-machine = { $host } gaat via { $tailnet }, maar is geen van de machines daarin, dus er is niets voor Tailscale om te pingen.
check-ok = { $address } werkt: verbonden via { $tailnet } in { $ms } ms.
check-failed =
    { $host } wordt gerouteerd via { $tailnet }, maar verbinden met poort { $port } is mislukt: { $error }
    Controleer of de machine online is en of er iets op die poort luistert.
check-timeout = { $host } wordt gerouteerd via { $tailnet }, maar poort { $port } antwoordde niet binnen 10 seconden.
domain-conflict = { $domain } wordt ook gerouteerd door { $tailnet }; dat tailnet krijgt voorrang.

## Fouten in getypte instellingen

forwards-line-format = Regel { $line }: schrijf LOCALPORT = host:port.
forwards-line-port = Regel { $line }: ‘{ $value }’ is geen poortnummer (of auto).
forwards-line-target = Regel { $line }: ‘{ $value }’ moet host:port zijn.
forwards-line-duplicate = Regel { $line }: lokale poort { $port } wordt twee keer gebruikt.
domain-invalid = ‘{ $domain }’ is geen domein; gebruik iets als example.ts.net.
domain-characters = ‘{ $domain }’ bevat tekens die een domein niet mag hebben.
names-line-format = Regel { $line }: schrijf name = address.
names-line-name = Regel { $line }: ‘{ $value }’ kan geen naam zijn. Gebruik letters, cijfers, koppeltekens en punten.
names-line-target = Regel { $line }: ‘{ $value }’ is geen IP-adres en geen naam van een machine.
names-line-duplicate = Regel { $line }: de naam { $value } komt twee keer voor.
autostart-unsupported = Starten bij inloggen wordt op dit systeem niet ondersteund.

## Dialoogvensters

ok = OK
cancel = Annuleren
done = Gereed
copy = Kopiëren
error-title = Er ging iets mis
error-details = Details staan in { $path }
edit-title = { $tailnet } bewerken
tailnet-name = Naam
tailnet-name-hint = Getoond in deze app en in het systeemvakmenu
extra-domains = Extra domeinen (optioneel)
extra-domains-help = Het eigen domein van het tailnet wordt automatisch gerouteerd. Voeg er één per regel toe.
route-subnets = Subnetten routeren
route-subnets-help = Netwerken die dit tailnet bereikt via zijn subnetrouters, zoals een cloudnetwerk. Zet dit uit als er een overlapt met een netwerk waarop deze computer zit.
forward-dialog-title = Poort doorsturen
forward-dialog-text = Krijg een poort op deze computer die naar { $host } leidt. Welke poort op die machine?
port-preset-remote-desktop = Extern bureaublad
port-tooltip = Poort { $port }
port = Poort
port-hint = bijv. 8080
add-forward = Doorsturing toevoegen
not-a-port = ‘{ $value }’ is geen poortnummer (1-65535).
forward-ready-title = Poortdoorsturing klaar
forward-ready-text = Laat je app dit adres gebruiken om { $target } te bereiken:
forward-ready-note = De poort blijft hetzelfde. Je vindt hem in Instellingen.
open-remote-desktop = Extern bureaublad openen
remove-title = Dit tailnet verwijderen?
remove-text = { -app-name } logt uit bij { $tailnet } en vergeet het op deze computer. Je kunt het later opnieuw toevoegen.
remove = Verwijderen
log-out-title = Uitloggen?
log-out-text = Uitloggen bij { $tailnet }? De adressen ervan werken hier niet meer totdat je opnieuw inlogt.
log-out = Uitloggen

## Menu in het systeemvak (Windows, Linux) of de menubalk (macOS)

tray-sign-in = { $tailnet }: inloggen…
tray-tailnet = { $tailnet }: { $state }
tray-add-tailnet = Tailnet toevoegen…
tray-route = Via andere tailnets routeren
tray-open = { -app-name } openen…
tray-quit = Afsluiten
tray-tooltip = { -app-name }: { $summary }

## Melding de eerste keer dat het venster wordt gesloten

still-running-title = { -app-name } draait nog
still-running-windows = Het blijft op de achtergrond routeren. Je vindt het in het systeemvak; Windows verstopt het misschien onder het pijltje ^ bij de klok.
still-running-macos = Het blijft op de achtergrond routeren. Je vindt het in de menubalk.
still-running-linux = Het blijft op de achtergrond routeren. Je vindt het in het systeemvak.

## Taalnamen in Instellingen, na de eigen naam van elke taal

english = Engels
french = Frans
german = Duits
spanish-latin-america = Latijns-Amerikaans Spaans
spanish-spain = Spaans uit Spanje
chinese-simplified = Vereenvoudigd Chinees
chinese-traditional = Traditioneel Chinees
korean = Koreaans
japanese = Japans
polish = Pools
russian = Russisch
portuguese-brazil = Braziliaans Portugees
italian = Italiaans
turkish = Turks
ukrainian = Oekraïens
czech = Tsjechisch
portuguese-portugal = Europees Portugees
dutch = Nederlands
indonesian = Indonesisch
vietnamese = Vietnamees
thai = Thai
swedish = Zweeds
romanian = Roemeens
hungarian = Hongaars
afrikaans = Afrikaans
catalan = Catalaans
serbian-cyrillic = Servisch, Cyrillisch
danish = Deens
finnish = Fins
greek = Grieks
norwegian-bokmal = Noors Bokmål
summary-proxy-problem = Verbonden, maar je apps gebruiken het niet
hero-proxy-taken = Je browser opent de adressen van deze tailnets niet: de proxyinstelling van het systeem gebruikt een ander setupscript ({ $script }).
hero-proxy-other-copy = Je browser opent de adressen van deze tailnets niet: een ander exemplaar van { -app-name } beheert de proxyinstelling van het systeem. Sluit dat exemplaar af, dan neemt dit het over.
hero-proxy-changed = Je browser opent de adressen van deze tailnets niet: iets anders heeft de proxyinstelling van het systeem gewijzigd.
hero-proxy-failed = Je browser opent de adressen van deze tailnets niet: de proxyinstelling van het systeem kon niet worden gewijzigd ({ $error }).
hero-proxy-manual = De proxyinstelling van het systeem staat uit, dus alleen apps die je zelf instelt bereiken deze tailnets. Laat ze verwijzen naar { $pac }
proxy-replace = Vervangen
proxy-replace-tooltip = Het setupscript van { -app-name } gebruiken zolang de app draait, en het andere daarna terugzetten
proxy-retry = Opnieuw proberen
proxy-retry-tooltip = De proxyinstelling van het systeem weer naar { -app-name } laten verwijzen
system-setting = Huidige proxyinstelling van het systeem: { $value }
system-setting-none = geen
check-updates = Controleren op nieuwe versies
find-websites = Zoeken naar websites op de machines in je tailnets
# $version is the version that's running, such as 0.6.0.
version-current = Versie { $version }
update-check-now = Nu controleren
update-checking = Controleren…
update-up-to-date = Je hebt de nieuwste versie
update-check-failed = Kan niet controleren op updates
tray-update = { -app-name } { $version } downloaden…
update-available = Versie { $version } is uit
update-available-tooltip = Je hebt { $current }. Opent de downloadpagina.
update-notify-title = { -app-name } { $version } is beschikbaar
update-notify-text = Open { -app-name } om het te downloaden.
migrate-failed = Je logins uit tailnet-proxy, de eerdere versie van deze app, konden niet worden overgezet ({ $error }). Het draait waarschijnlijk nog. Sluit tailnet-proxy af en start { -app-name } opnieuw voordat je hier inlogt: opnieuw inloggen zou deze computer een tweede keer aan elk tailnet toevoegen.
