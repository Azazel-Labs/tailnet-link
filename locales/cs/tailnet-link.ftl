### Tailnet Link: český katalog.
### Názvy Tailnet Link a Tailscale ponechte beze změny. „tailnet“ se neskloňuje:
### používejte spojení „síť tailnet“ a skloňujte slovo „síť“.

-app-name = Tailnet Link

## Window header

tab-tailnets = Sítě tailnet
tab-settings = Nastavení

## Unsaved-changes bar at the bottom of Settings

unsaved-changes = Máte neuložené změny.
save = Uložit
revert = Vrátit
revert-tooltip = Zrušit provedené změny
settings-saved = Nastavení uloženo

## Short notes at the bottom of the window

copied-address = Zkopírováno: { $address }
copied-sign-in-link = Odkaz pro přihlášení zkopírován

## Errors shown in the "Something went wrong" dialog

start-failed =
    Aplikaci { -app-name } nelze spustit:
    { $error }
add-tailnet-failed =
    Síť tailnet se nepodařilo přidat:
    { $error }
add-forward-failed =
    Přesměrování portu se nepodařilo přidat:
    { $error }
remote-desktop-failed = Připojení ke vzdálené ploše se nepodařilo spustit: { $error }
remote-desktop-windows-only = Vzdálená plocha je vestavěná jen ve Windows.
no-free-port = Nepodařilo se najít volný místní port.

## Dialog after "Add a tailnet"

sign-in-dialog-title = Přihlášení k nové síti tailnet
sign-in-dialog-text =
    Prohlížeč otevírá přihlašovací stránku Tailscale. Může se otevřít za tímto oknem.
    
    Přihlaste se účtem pro tuto síť tailnet a pak se vraťte sem. Její doména se zjistí automaticky.

## One tailnet's state, shown as a coloured label beside its name

state-waiting-sign-in = Čeká na přihlášení
state-signed-out = Odhlášeno
state-problem = Problém
state-connecting = Připojování
state-paused = Pozastaveno
state-no-domain = Zatím bez domény
state-not-routing = Bez směrování
state-routing = Směrování

## The whole app's state, in the status card and the tray menu

summary-no-tailnets = Zatím žádné sítě tailnet
summary-paused = Pozastaveno
summary-routing-one = Směrování přes { $tailnet }
summary-routing-all =
    { $count ->
        [one] Směrování přes { $count } síť tailnet
        [few] Směrování přes { $count } sítě tailnet
        [many] Směrování přes { $count } sítě tailnet
       *[other] Směrování přes { $count } sítí tailnet
    }
summary-routing-some =
    { $count ->
        [one] Směrování přes { $routing } z { $count } sítě tailnet
        [few] Směrování přes { $routing } z { $count } sítí tailnet
        [many] Směrování přes { $routing } z { $count } sítě tailnet
       *[other] Směrování přes { $routing } z { $count } sítí tailnet
    }
summary-signed-out = Nepřihlášeno
summary-problem = Problém: { $problem }
summary-connecting = Připojování…
new-tailnet = Nová síť tailnet

## Status card at the top of the Tailnets tab

hero-starting = Spouštění…
hero-connecting = Připojování k vašim sítím tailnet.
hero-paused = Přes ostatní sítě tailnet teď nic neprochází. Vaše vlastní síť i síť tailnet fungují jako obvykle.
hero-finish-sign-in = Dokončete v prohlížeči přihlášení k síti { $tailnet }.
hero-sign-in = Přihlaste se k síti { $tailnet } a získejte přístup k jejím zařízením.
hero-routing-example = Otevřete { $address } nebo jakoukoli jinou adresu v těchto sítích tailnet. Vše ostatní jde napřímo.
hero-routing = Adresy v těchto sítích tailnet se otevírají v prohlížeči. Vše ostatní jde napřímo.
add-tailnet = Přidat síť tailnet
pause-all = Pozastavit vše
pause-all-tooltip = Dočasně zastavit směrování přes ostatní sítě tailnet
resume = Pokračovat
resume-tooltip = Znovu směrovat provoz přes ostatní sítě tailnet

## First run, before any tailnet is added

welcome-title = Přístup k zařízením v jiných sítích tailnet
welcome-text = Zůstaňte ve své síti tailnet a zároveň otevírejte zařízení v jiných. Aplikace Tailscale funguje jako obvykle.
welcome-sign-in = Přihlaste se k jiné síti tailnet
welcome-sign-in-detail = Přihlašovací stránka Tailscale se otevře v prohlížeči.
welcome-open = Otevírejte její zařízení podle názvu
welcome-open-detail = Adresy jako { $example } fungují v prohlížeči.
welcome-forward = Přesměrujte port, když ho aplikace potřebuje
welcome-forward-detail = Vzdálená plocha, SSH a databázoví klienti dostanou místní port, který vede k zařízení.

## A tailnet's card

machine-search-hint = Najít zařízení podle názvu, OS nebo adresy
clear-search = Vymazat hledání
more-actions = Další akce
edit-tailnet-menu = Přejmenovat nebo přidat domény…
log-out-menu = Odhlásit…
remove-menu = Odebrat…
sign-in = Přihlásit
pause-tailnet = Pozastavit tuto síť tailnet
resume-tailnet = Obnovit tuto síť tailnet
detail-tailnet = Síť tailnet
detail-routes = Trasy
detail-this-computer = Tento počítač
detail-problem = Problém
routes-after-sign-in = Zjistí se po přihlášení
hostname-after-sign-in = { $hostname } (po přihlášení)
sign-in-help = Prohlížeč se neotevřel nebo otevřel nesprávný profil?
sign-in-open-again = Znovu otevřít přihlašovací stránku
sign-in-copy-link = Kopírovat odkaz
sign-in-copy-link-tooltip = Vložte ho do prohlížeče nebo profilu prohlížeče, který pro tuto síť tailnet používáte

## Machine list inside a tailnet's card

machines-online = Zařízení · online { $online } z { $total }
machines-matching = Zařízení · vyhovuje { $shown } z { $total }
no-machines = V této síti tailnet nejsou vidět žádná další zařízení.
no-machine-matches = Hledání neodpovídá žádné zařízení.
machine-offline = { $name } (offline)
forward-port-tooltip = Přesměrovat port: pro aplikace, které ignorují nastavení proxy, například Vzdálenou plochu nebo databázového klienta
copy-address = Kopírovat { $address }
open-in-browser = Otevřít { $url } v prohlížeči
not-routing-tooltip = Tato síť tailnet právě nesměruje provoz. Není pozastavená?

## Websites found on the machines

sites-heading = Weby
sites-help = Zařízení ve vašich sítích tailnet, která poskytují web přes HTTPS. Každé zařízení se kontroluje nejvýše jednou denně.
# $done and $total count machines.
sites-checking = Kontroluje se { $done } z { $total }…
sites-recheck-tooltip = Znovu zkontrolovat všechna zařízení
site-untrusted = Jeho certifikát není důvěryhodný, takže vás prohlížeč upozorní.

## Settings: port forwards

forwards-heading = Přesměrování portů
forwards-help = Pro aplikace, které ignorují nastavení proxy, například Vzdálenou plochu, SSH a databázové klienty. Každé přesměrování je port na tomto počítači, který vede k zařízení v síti tailnet.
edit-forwards = Upravit přesměrování
# LOCALPORT, auto a host:port ponechte beze změny: to uživatel píše.
forwards-format-help = Jedno na řádek: LOCALPORT = host:port, nebo auto = host:port pro automatický výběr volného portu. Název hostitele určuje, která síť tailnet provoz přenese. Pro rychlé přidání použijte tlačítko se zástrčkou u zařízení na kartě „Sítě tailnet“.
forward-cant-listen = Nelze naslouchat: { $error }
forward-port-on-save = Port se vybere při uložení
forward-no-tailnet = Žádná aktivní síť tailnet nemá tento název
forward-via = přes { $tailnet }
open-remote-desktop-to = Připojit se k { $address } přes Vzdálenou plochu

## Settings: system proxy

proxy-heading = Systémové nastavení proxy
proxy-on = Zapnuto (doporučeno)
proxy-force = Zapnuto a za běhu nahradit skript proxy nastavený vaší firmou
proxy-off = Vypnuto: aplikace nastavím ručně
proxy-help-windows = „Zapnuto“ nasměruje Windows na pravidla této aplikace jen tehdy, když běží a směruje provoz, a vše vrátí zpět, když se zastaví, pozastaví, odpojí nebo spadne.
proxy-help-macos = „Zapnuto“ nastaví proxy pro vaše síťové služby, dokud aplikace běží, a potom vrátí původní stav. Pokud k tomu váš Mac potřebuje heslo správce, budete o něj požádáni při spuštění směrování a při ukončení.
proxy-help-linux = „Zapnuto“ nastaví proxy v GNOME nebo KDE, dokud aplikace běží a směruje provoz, a potom vrátí původní stav. V prohlížeči Firefox zapněte Nastavení > Nastavení sítě > „Použít systémové nastavení proxy“.

## Settings: general

general-heading = Obecné
start-at-login = Spouštět { -app-name } po přihlášení
language = Jazyk
system-default = Jazyk systému

## Settings: troubleshooting

troubleshooting-heading = Řešení potíží
troubleshooting-help = Otestujte webovou adresu nebo název:port a zjistěte, která síť tailnet ji přenáší a zda se připojí.
test = Otestovat
testing = Testování…
open-log = Otevřít protokol
open-settings-folder = Otevřít složku nastavení
about-line = { -app-name } { $version } · místní proxy { $proxy } · PAC { $pac }
settings-location = Nastavení je uloženo v { $path }

## Results of "Test" in Troubleshooting

check-empty = Zadejte název zařízení nebo webovou adresu.
check-bad-port = { $input }: to není platný port.
check-not-routed = { -app-name } nesměruje { $host }: adresa nekončí doménou žádné sítě tailnet, která právě směruje, takže jde napřímo (přes vaši běžnou síť a váš vlastní Tailscale).
check-gone = Tato síť tailnet právě zmizela.
check-not-running = Síť { $tailnet } neběží.
check-ok = { $address } funguje: připojeno přes { $tailnet } za { $ms } ms.
check-failed =
    { $host } se směruje přes { $tailnet }, ale připojení k portu { $port } selhalo: { $error }
    Zkontrolujte, že je zařízení online a že na tomto portu něco naslouchá.
check-timeout = { $host } se směruje přes { $tailnet }, ale port { $port } neodpověděl do 10 sekund.
domain-conflict = Doménu { $domain } směruje i síť { $tailnet }; přednost má ona.

## Mistakes in typed settings

forwards-line-format = Řádek { $line }: zapište LOCALPORT = host:port.
forwards-line-port = Řádek { $line }: „{ $value }“ není číslo portu (ani auto).
forwards-line-target = Řádek { $line }: „{ $value }“ má mít tvar host:port.
forwards-line-duplicate = Řádek { $line }: místní port { $port } je použit dvakrát.
domain-invalid = „{ $domain }“ není doména; použijte něco jako example.ts.net.
domain-characters = „{ $domain }“ obsahuje znaky, které doména nesmí obsahovat.
autostart-unsupported = Spouštění po přihlášení není v tomto systému podporováno.

## Dialogs

ok = OK
cancel = Zrušit
done = Hotovo
copy = Kopírovat
error-title = Něco se pokazilo
error-details = Podrobnosti najdete v { $path }
edit-title = Upravit síť { $tailnet }
tailnet-name = Název
tailnet-name-hint = Zobrazuje se v této aplikaci a v nabídce v oznamovací oblasti
extra-domains = Další domény (volitelné)
extra-domains-help = Vlastní doména sítě tailnet se směruje automaticky. Přidejte jednu na řádek.
forward-dialog-title = Přesměrovat port
forward-dialog-text = Získejte port na tomto počítači, který vede k { $host }. Který port na tom zařízení?
port-preset-remote-desktop = Vzdálená plocha
port-tooltip = Port { $port }
port = Port
port-hint = např. 8080
add-forward = Přidat přesměrování
not-a-port = „{ $value }“ není číslo portu (1–65535).
forward-ready-title = Přesměrování portu je připraveno
forward-ready-text = Nastavte v aplikaci tuto adresu, abyste se dostali k { $target }:
forward-ready-note = Port zůstává stejný. Najdete ho v Nastavení.
open-remote-desktop = Otevřít Vzdálenou plochu
remove-title = Odebrat tuto síť tailnet?
remove-text = { -app-name } se odhlásí ze sítě { $tailnet } a zapomene ji na tomto počítači. Později ji můžete přidat znovu.
remove = Odebrat
log-out-title = Odhlásit se?
log-out-text = Odhlásit se ze sítě { $tailnet }? Její adresy tu přestanou fungovat, dokud se znovu nepřihlásíte.
log-out = Odhlásit

## Tray (Windows, Linux) or menu bar (macOS) menu

tray-sign-in = { $tailnet }: přihlásit…
tray-tailnet = { $tailnet }: { $state }
tray-add-tailnet = Přidat síť tailnet…
tray-route = Směrovat přes ostatní sítě tailnet
tray-open = Otevřít { -app-name }…
tray-quit = Ukončit
tray-tooltip = { -app-name }: { $summary }

## Notification the first time the window is closed

still-running-title = { -app-name } stále běží
still-running-windows = Směrování pokračuje na pozadí. Ikonu najdete v oznamovací oblasti; Windows ji může schovat pod šipku ^ u hodin.
still-running-macos = Směrování pokračuje na pozadí. Ikonu najdete na řádku nabídek.
still-running-linux = Směrování pokračuje na pozadí. Ikonu najdete v systémové liště.

## Language names in Settings, after each language's own name

english = Angličtina
french = Francouzština
german = Němčina
spanish-latin-america = Latinskoamerická španělština
spanish-spain = Evropská španělština
chinese-simplified = Zjednodušená čínština
chinese-traditional = Tradiční čínština
korean = Korejština
japanese = Japonština
polish = Polština
russian = Ruština
portuguese-brazil = Brazilská portugalština
italian = Italština
turkish = Turečtina
ukrainian = Ukrajinština
czech = Čeština
portuguese-portugal = Evropská portugalština
dutch = Nizozemština
indonesian = Indonéština
vietnamese = Vietnamština
thai = Thajština
swedish = Švédština
romanian = Rumunština
hungarian = Maďarština
afrikaans = Afrikánština
catalan = Katalánština
serbian-cyrillic = Srbština, cyrilice
danish = Dánština
finnish = Finština
greek = Řečtina
norwegian-bokmal = Norština bokmål
summary-proxy-problem = Připojeno, ale aplikace připojení nepoužívají
hero-proxy-taken = Prohlížeč neotevře adresy těchto sítí tailnet: systémové nastavení proxy používá jiný instalační skript ({ $script }).
hero-proxy-other-copy = Prohlížeč neotevře adresy těchto sítí tailnet: systémové nastavení proxy drží jiná kopie aplikace { -app-name }. Ukončete tamtu kopii a tato ho převezme.
hero-proxy-changed = Prohlížeč neotevře adresy těchto sítí tailnet: systémové nastavení proxy změnilo něco jiného.
hero-proxy-failed = Prohlížeč neotevře adresy těchto sítí tailnet: systémové nastavení proxy se nepodařilo změnit ({ $error }).
hero-proxy-manual = Systémové nastavení proxy je vypnuté, takže se k těmto sítím tailnet dostanou jen aplikace, které si nastavíte sami. Nasměrujte je na { $pac }
proxy-replace = Nahradit
proxy-replace-tooltip = Za běhu používat instalační skript aplikace { -app-name } a potom vrátit ten původní
proxy-retry = Zkusit znovu
proxy-retry-tooltip = Znovu nasměrovat systémové nastavení proxy na { -app-name }
system-setting = Aktuální systémové nastavení proxy: { $value }
system-setting-none = žádné
check-updates = Zkontrolovat nové verze
find-websites = Hledat weby na zařízeních ve vašich sítích tailnet
tray-update = Stáhnout { -app-name } { $version }…
update-available = Vyšla verze { $version }
update-available-tooltip = Máte verzi { $current }. Otevře stránku ke stažení.
update-notify-title = Je k dispozici { -app-name } { $version }
update-notify-text = Otevřete { -app-name } a stáhněte si novou verzi.
migrate-failed = Vaše přihlášení z tailnet-proxy, dřívější verze této aplikace, se nepodařilo přenést ({ $error }). Pravděpodobně stále běží. Ukončete tailnet-proxy a pak znovu spusťte { -app-name }, než se tady přihlásíte: nové přihlášení by tento počítač přidalo do každé sítě tailnet podruhé.
