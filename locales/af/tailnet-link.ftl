### Tailnet Link: Afrikaanse katalogus.
### Hou die produkname Tailnet Link en Tailscale, en die woord "tailnet"
### ('n Tailscale-netwerk): 'n tailnet, die tailnet, tailnets.
### Windows se Remote Desktop het geen Afrikaanse naam nie; dit bly "Remote Desktop".

-app-name = Tailnet Link

## Window header

tab-tailnets = Tailnets
tab-settings = Instellings

## Unsaved-changes bar at the bottom of Settings

unsaved-changes = Jy het ongestoorde veranderinge.
save = Stoor
revert = Herstel
revert-tooltip = Ontdoen die veranderinge
settings-saved = Instellings gestoor

## Short notes at the bottom of the window

copied-address = { $address } gekopieer
copied-sign-in-link = Aanmeldskakel gekopieer

## Errors shown in the "Something went wrong" dialog

start-failed =
    { -app-name } kan nie begin nie:
    { $error }
add-tailnet-failed =
    Kon nie 'n tailnet byvoeg nie:
    { $error }
add-forward-failed =
    Kon nie die poortaanstuuring byvoeg nie:
    { $error }
remote-desktop-failed = Kon nie Remote Desktop begin nie: { $error }
remote-desktop-windows-only = Remote Desktop is net op Windows ingebou.
no-free-port = Kon nie 'n vrye plaaslike poort vind nie.

## Dialog after "Add a tailnet"

sign-in-dialog-title = Meld aan by die nuwe tailnet
sign-in-dialog-text =
    Jou blaaier maak Tailscale se aanmeldbladsy oop. Dit kan agter hierdie venster oopmaak.
    
    Meld aan met jou rekening vir daardie tailnet en kom dan terug hierheen. Sy domein word outomaties opgespoor.

## One tailnet's state, shown as a coloured label beside its name

state-waiting-sign-in = Wag vir aanmelding
state-signed-out = Afgemeld
state-problem = Probleem
state-connecting = Koppel tans
state-paused = Gepouseer
state-no-domain = Nog geen domein nie
state-not-routing = Roeteer nie
state-routing = Roeteer

## The whole app's state, in the status card and the tray menu

summary-no-tailnets = Nog geen tailnets nie
summary-paused = Gepouseer
summary-routing-one = Roeteer via { $tailnet }
summary-routing-all =
    { $count ->
        [one] Roeteer via { $count } tailnet
       *[other] Roeteer via { $count } tailnets
    }
summary-routing-some =
    { $count ->
        [one] Roeteer via { $routing } van { $count } tailnet
       *[other] Roeteer via { $routing } van { $count } tailnets
    }
summary-signed-out = Nie aangemeld nie
summary-problem = Probleem: { $problem }
summary-connecting = Koppel tans…
new-tailnet = Nuwe tailnet

## Status card at the top of the Tailnets tab

hero-starting = Begin tans…
hero-connecting = Koppel tans aan jou tailnets.
hero-paused = Niks gaan op die oomblik deur ander tailnets nie. Jou eie netwerk en tailnet werk soos gewoonlik.
hero-finish-sign-in = Voltooi die aanmelding by { $tailnet } in jou blaaier.
hero-sign-in = Meld aan by { $tailnet } om sy masjiene te bereik.
hero-routing-example = Maak { $address } of enige ander adres in hierdie tailnets oop. Alles anders gaan direk.
hero-routing = Adresse in hierdie tailnets maak in jou blaaier oop. Alles anders gaan direk.
add-tailnet = Voeg 'n tailnet by
pause-all = Pouseer alles
pause-all-tooltip = Hou voorlopig op om deur ander tailnets te roeteer
resume = Hervat
resume-tooltip = Begin weer deur ander tailnets roeteer

## First run, before any tailnet is added

welcome-title = Bereik masjiene op ander tailnets
welcome-text = Bly op jou eie tailnet en maak terselfdertyd masjiene op ander oop. Jou Tailscale-app werk soos gewoonlik.
welcome-sign-in = Meld aan by 'n ander tailnet
welcome-sign-in-detail = Tailscale se aanmeldbladsy maak in jou blaaier oop.
welcome-open = Maak sy masjiene volgens naam oop
welcome-open-detail = Adresse soos { $example } werk in jou blaaier.
welcome-forward = Stuur 'n poort aan wanneer 'n app een nodig het
welcome-forward-detail = Remote Desktop, SSH en databasis-apps kry 'n plaaslike poort wat na 'n masjien lei.

## A tailnet's card

machine-search-hint = Soek 'n masjien volgens naam, bedryfstelsel of adres
clear-search = Maak die soektog skoon
open-terminal-tooltip = Maak 'n terminaal oop waar jou tailnets se name werk, vir curl, git, ssh, ping en meer. Of sit tl voor enige opdrag in enige terminaal.
open-terminal-missing = { -app-name } kan nie tl, sy terminaalhulpprogram, langs die app vind nie. Installeer { -app-name } weer om dit te kry.
open-terminal-failed = Kon nie 'n terminaal oopmaak nie: { $error }
more-actions = Meer aksies
edit-tailnet-menu = Hernoem of voeg domeine by…
log-out-menu = Meld af…
remove-menu = Verwyder…
sign-in = Meld aan
pause-tailnet = Pouseer hierdie tailnet
resume-tailnet = Hervat hierdie tailnet
detail-tailnet = Tailnet
detail-routes = Roetes
detail-this-computer = Hierdie rekenaar
detail-problem = Probleem
routes-after-sign-in = Word gevind nadat jy aangemeld het
hostname-after-sign-in = { $hostname } (nadat jy aangemeld het)
sign-in-help = Het die blaaier nie oopgemaak nie, of die verkeerde profiel oopgemaak?
sign-in-open-again = Maak die aanmeldbladsy weer oop
sign-in-copy-link = Kopieer die skakel
sign-in-copy-link-tooltip = Plak dit in die blaaier, of blaaierprofiel, wat jy vir hierdie tailnet gebruik

## Machine list inside a tailnet's card

machines-online = Masjiene · { $online } van { $total } aanlyn
machines-matching = Masjiene · { $shown } van { $total } pas
no-machines = Geen ander masjiene is in hierdie tailnet sigbaar nie.
no-machine-matches = Geen masjien pas by jou soektog nie.
machine-offline = { $name } (vanlyn)
forward-port-tooltip = Stuur 'n poort aan: vir apps wat die instaanbedienerinstelling ignoreer, soos Remote Desktop of 'n databasiskliënt
copy-address = Kopieer { $address }
open-in-browser = Maak { $url } in jou blaaier oop
not-routing-tooltip = Hierdie tailnet roeteer nie op die oomblik nie. Is dit gepouseer?

## Websites found on the machines

sites-heading = Webwerwe
sites-help = Masjiene in jou tailnets wat 'n webwerf oor HTTPS bedien. Elke masjien word hoogstens een keer per dag nagegaan.
# $done and $total count machines.
sites-checking = Gaan { $done } van { $total } na…
sites-recheck-tooltip = Gaan nou weer elke masjien na
site-untrusted = Sy sertifikaat word nie vertrou nie, dus sal jou blaaier jou waarsku.
site-favorite-add = Voeg by gunstelinge
site-favorite-remove = Verwyder uit gunstelinge
sites-show-all = Wys alle webwerwe ({ $count })
sites-show-fewer = Wys minder

## Settings: port forwards

forwards-heading = Poortaanstuurings
forwards-help = Vir apps wat die instaanbedienerinstelling ignoreer, soos Remote Desktop, SSH en databasiskliënte. Elke aanstuuring is 'n poort op hierdie rekenaar wat na 'n masjien in 'n tailnet lei.
edit-forwards = Wysig aanstuurings
# Hou LOCALPORT, auto en host:port soos dit is: dit is wat jy tik.
forwards-format-help = Een per reël: LOCALPORT = host:port, of auto = host:port om 'n vrye poort te laat kies. Die gasheer se naam bepaal watter tailnet dit dra. Om vinnig een by te voeg, gebruik die propknoppie by 'n masjien op die Tailnets-oortjie.
forward-cant-listen = Kan nie luister nie: { $error }
forward-port-on-save = 'n Poort word gekies wanneer jy stoor
forward-no-tailnet = Geen roeterende tailnet het hierdie naam nie
forward-via = via { $tailnet }
open-remote-desktop-to = Maak Remote Desktop na { $address } oop

## Settings: system proxy

proxy-heading = Stelsel se instaanbedienerinstelling
proxy-on = Aan (aanbeveel)
proxy-force = Aan, en vervang 'n instaanbedienerskrip wat jou maatskappy gestel het terwyl dit loop
proxy-off = Af: ek stel my apps self op
proxy-help-windows = "Aan" wys Windows net na hierdie app se reëls terwyl dit loop en roeteer, en sit alles terug wanneer dit stop, pouseer, ontkoppel of ineenstort.
proxy-help-macos = "Aan" stel die instaanbediener vir jou netwerkdienste terwyl die app loop en sit dit daarna terug. As jou Mac 'n administrateurwagwoord daarvoor nodig het, sal jy gevra word wanneer roetering begin en wanneer jy afsluit.
proxy-help-linux = "Aan" stel die GNOME- of KDE-instaanbedienerinstelling terwyl die app loop en roeteer, en sit dit daarna terug. Skakel in Firefox Instellings > Netwerkinstellings > "Gebruik stelsel se instaanbedienerinstellings" aan.

## Settings: general

general-heading = Algemeen
start-at-login = Begin { -app-name } wanneer ek aanmeld
language = Taal
system-default = Stelselverstek

## Settings: troubleshooting

troubleshooting-heading = Probleemoplossing
troubleshooting-help = Toets 'n webadres of naam:poort om te sien watter tailnet dit dra en of dit koppel.
test = Toets
testing = Toets tans…
open-log = Maak log oop
open-settings-folder = Maak instellingsvouer oop
about-line = { -app-name } { $version } · plaaslike instaanbediener { $proxy } · PAC { $pac }
settings-location = Instellings in { $path }

## Settings: names

names-heading = Name
names-help = Jou eie name vir adresse in jou tailnets, soos 'n bediener agter 'n subnetroeteerder. Hulle werk net in blaaiers en poortaanstuurings op hierdie rekenaar.
edit-names = Wysig name
# Hou "name = address" en die voorbeeld soos dit is: dit is wat jy tik.
names-format-help = Een per reël: name = address, byvoorbeeld wiki = 192.168.20.15. Die adres kan 'n IP-adres of 'n masjien se naam wees. Maak dit oop as http://wiki:8080/, met die poort wat die webwerf gebruik.

## Results of "Test" in Troubleshooting

check-empty = Tik 'n masjiennaam of 'n webadres.
check-bad-port = { $input }: dit is nie 'n geldige poort nie.
check-not-routed = { $host } word nie deur { -app-name } geroeteer nie: dit is nie 'n naam, adres of subnet van enige tailnet wat nou roeteer nie, so dit gaan direk (deur jou gewone netwerk en jou eie Tailscale).
# $tailnets lists the tailnets, separated by commas.
check-ambiguous = { $host } is in meer as een tailnet ({ $tailnets }), so dit word nie geroeteer nie. Gebruik eerder die masjien se naam, of skakel subnette af vir een van daardie tailnets.
check-gone = Daardie tailnet het pas verdwyn.
check-not-running = { $tailnet } loop nie.
ping-no-machine = { $host } gaan deur { $tailnet }, maar dit is nie een van sy masjiene nie, so daar is niks vir Tailscale om te ping nie.
check-ok = { $address } werk: gekoppel deur { $tailnet } in { $ms } ms.
check-failed =
    { $host } word deur { $tailnet } geroeteer, maar koppeling aan poort { $port } het misluk: { $error }
    Kontroleer dat die masjien aanlyn is en dat iets op daardie poort luister.
check-timeout = { $host } word deur { $tailnet } geroeteer, maar poort { $port } het nie binne 10 sekondes geantwoord nie.
domain-conflict = { $domain } word ook deur { $tailnet } geroeteer; daardie een kry voorrang.

## Mistakes in typed settings

forwards-line-format = Reël { $line }: skryf LOCALPORT = host:port.
forwards-line-port = Reël { $line }: “{ $value }” is nie 'n poortnommer (of auto) nie.
forwards-line-target = Reël { $line }: “{ $value }” moet host:port wees.
forwards-line-duplicate = Reël { $line }: plaaslike poort { $port } word twee keer gebruik.
domain-invalid = “{ $domain }” is nie 'n domein nie; gebruik iets soos example.ts.net.
domain-characters = “{ $domain }” bevat karakters wat 'n domein nie kan hê nie.
names-line-format = Reël { $line }: skryf name = address.
names-line-name = Reël { $line }: “{ $value }” kan nie 'n naam wees nie. Gebruik letters, syfers, koppeltekens en punte.
names-line-target = Reël { $line }: “{ $value }” is nie 'n IP-adres of 'n masjien se naam nie.
names-line-duplicate = Reël { $line }: die naam { $value } kom twee keer voor.
autostart-unsupported = Begin by aanmelding word nie op hierdie stelsel ondersteun nie.

## Dialogs

ok = OK
cancel = Kanselleer
done = Klaar
copy = Kopieer
error-title = Iets het skeefgeloop
error-details = Besonderhede is in { $path }
edit-title = Wysig { $tailnet }
tailnet-name = Naam
tailnet-name-hint = Word in hierdie app en in die stelselbalkkieslys gewys
extra-domains = Ekstra domeine (opsioneel)
extra-domains-help = Die tailnet se eie domein word outomaties geroeteer. Voeg een per reël by.
route-subnets = Roeteer sy subnette
route-subnets-help = Netwerke wat hierdie tailnet deur sy subnetroeteerders bereik, soos 'n wolknetwerk. Skakel dit af as een oorvleuel met 'n netwerk waarop hierdie rekenaar is.
forward-dialog-title = Stuur 'n poort aan
forward-dialog-text = Kry 'n poort op hierdie rekenaar wat na { $host } lei. Watter poort op daardie masjien?
port-preset-remote-desktop = Remote Desktop
port-tooltip = Poort { $port }
port = Poort
port-hint = bv. 8080
add-forward = Voeg aanstuuring by
not-a-port = “{ $value }” is nie 'n poortnommer (1-65535) nie.
forward-ready-title = Poortaanstuuring gereed
forward-ready-text = Wys jou app na hierdie adres om { $target } te bereik:
forward-ready-note = Die poort bly dieselfde. Jy kry dit in Instellings.
open-remote-desktop = Maak Remote Desktop oop
remove-title = Verwyder hierdie tailnet?
remove-text = { -app-name } meld af by { $tailnet } en vergeet dit op hierdie rekenaar. Jy kan dit later weer byvoeg.
remove = Verwyder
log-out-title = Meld af?
log-out-text = Meld af by { $tailnet }? Sy adresse werk nie meer hier nie totdat jy weer aanmeld.
log-out = Meld af

## Tray (Windows, Linux) or menu bar (macOS) menu

tray-sign-in = { $tailnet }: meld aan…
tray-tailnet = { $tailnet }: { $state }
tray-add-tailnet = Voeg 'n tailnet by…
tray-route = Roeteer deur ander tailnets
tray-open = Maak { -app-name } oop…
tray-quit = Sluit af
tray-tooltip = { -app-name }: { $summary }

## Notification the first time the window is closed

still-running-title = { -app-name } loop steeds
still-running-windows = Dit hou aan om in die agtergrond te roeteer. Jy kry dit in die kennisgewingarea; Windows steek dit dalk weg onder die ^-pyltjie langs die horlosie.
still-running-macos = Dit hou aan om in die agtergrond te roeteer. Jy kry dit in die kieslysbalk.
still-running-linux = Dit hou aan om in die agtergrond te roeteer. Jy kry dit in die stelselbalk.

## Language names in Settings, after each language's own name

english = Engels
french = Frans
german = Duits
spanish-latin-america = Latyns-Amerikaanse Spaans
spanish-spain = Spaans van Spanje
chinese-simplified = Vereenvoudigde Sjinees
chinese-traditional = Tradisionele Sjinees
korean = Koreaans
japanese = Japannees
polish = Pools
russian = Russies
portuguese-brazil = Brasiliaanse Portugees
italian = Italiaans
turkish = Turks
ukrainian = Oekraïens
czech = Tsjeggies
portuguese-portugal = Europese Portugees
dutch = Nederlands
indonesian = Indonesies
vietnamese = Viëtnamees
thai = Thai
swedish = Sweeds
romanian = Roemeens
hungarian = Hongaars
afrikaans = Afrikaans
catalan = Katalaans
serbian-cyrillic = Serwies, Cyrillies
danish = Deens
finnish = Fins
greek = Grieks
norwegian-bokmal = Noorse Bokmål
summary-proxy-problem = Gekoppel, maar jou apps gebruik dit nie
hero-proxy-taken = Jou blaaier sal nie hierdie tailnets se adresse oopmaak nie: die stelsel se instaanbedienerinstelling gebruik 'n ander opstelskrip ({ $script }).
hero-proxy-other-copy = Jou blaaier sal nie hierdie tailnets se adresse oopmaak nie: 'n ander kopie van { -app-name } het die stelsel se instaanbedienerinstelling. Sluit daardie kopie af, dan neem hierdie een oor.
hero-proxy-changed = Jou blaaier sal nie hierdie tailnets se adresse oopmaak nie: iets anders het die stelsel se instaanbedienerinstelling verander.
hero-proxy-failed = Jou blaaier sal nie hierdie tailnets se adresse oopmaak nie: die stelsel se instaanbedienerinstelling kon nie verander word nie ({ $error }).
hero-proxy-manual = Die stelsel se instaanbedienerinstelling is af, so net apps wat jy self opstel, bereik hierdie tailnets. Wys hulle na { $pac }
proxy-replace = Vervang dit
proxy-replace-tooltip = Gebruik { -app-name } se opstelskrip terwyl dit loop, en sit die ander een daarna terug
proxy-retry = Probeer weer
proxy-retry-tooltip = Wys die stelsel se instaanbedienerinstelling weer na { -app-name }
system-setting = Stelsel se instaanbedienerinstelling nou: { $value }
system-setting-none = geen
check-updates = Kyk vir nuwe weergawes
find-websites = Soek na webwerwe op die masjiene in jou tailnets
# $version is the version that's running, such as 0.6.0.
version-current = Weergawe { $version }
update-check-now = Kyk nou
update-checking = Kyk tans…
update-up-to-date = Jy het die nuutste weergawe
update-check-failed = Kon nie vir opdaterings kyk nie
tray-update = Laai { -app-name } { $version } af…
update-available = Weergawe { $version } is uit
update-available-tooltip = Jy het { $current }. Maak die aflaaibladsy oop.
update-notify-title = { -app-name } { $version } is beskikbaar
update-notify-text = Maak { -app-name } oop om dit af te laai.
migrate-failed = Jou aanmeldings van tailnet-proxy, hierdie app se vroeëre weergawe, kon nie oorgedra word nie ({ $error }). Dit loop waarskynlik nog. Sluit tailnet-proxy af en begin dan { -app-name } weer voordat jy hier aanmeld: as jy weer aanmeld, sal hierdie rekenaar 'n tweede keer by elke tailnet gevoeg word.
