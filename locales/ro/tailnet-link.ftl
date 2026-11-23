### Tailnet Link: catalogul în limba română.
### Păstrează numele Tailnet Link și Tailscale și cuvântul „tailnet” (o rețea Tailscale).

-app-name = Tailnet Link

## Antetul ferestrei

tab-tailnets = Tailneturi
tab-settings = Setări

## Bara de modificări nesalvate din partea de jos a Setărilor

unsaved-changes = Ai modificări nesalvate.
save = Salvează
revert = Renunță
revert-tooltip = Anulează modificările
settings-saved = Setările au fost salvate

## Mesaje scurte în partea de jos a ferestrei

copied-address = S-a copiat { $address }
copied-sign-in-link = S-a copiat linkul de autentificare

## Erori afișate în dialogul „Ceva nu a mers bine”

start-failed =
    { -app-name } nu poate porni:
    { $error }
add-tailnet-failed =
    Nu s-a putut adăuga un tailnet:
    { $error }
add-forward-failed =
    Nu s-a putut adăuga redirecționarea de port:
    { $error }
remote-desktop-failed = Nu s-a putut porni Desktop la distanță: { $error }
remote-desktop-windows-only = Desktop la distanță este integrat doar în Windows.
no-free-port = Nu s-a găsit niciun port local liber.

## Dialogul de după „Adaugă un tailnet”

sign-in-dialog-title = Autentifică-te în noul tailnet
sign-in-dialog-text =
    Browserul deschide pagina de autentificare Tailscale. Se poate deschide în spatele acestei ferestre.
    
    Autentifică-te cu contul pentru acel tailnet, apoi revino aici. Domeniul lui este detectat automat.

## Starea unui tailnet, ca etichetă colorată lângă nume

state-waiting-sign-in = Așteaptă autentificarea
state-signed-out = Deconectat
state-problem = Problemă
state-connecting = Se conectează
state-paused = Întrerupt
state-no-domain = Încă fără domeniu
state-not-routing = Fără rutare
state-routing = Rutare activă

## Starea întregii aplicații, în cardul de stare și în meniul din zona de notificare

summary-no-tailnets = Încă nu există tailneturi
summary-paused = Întrerupt
summary-routing-one = Rutare prin { $tailnet }
summary-routing-all =
    { $count ->
        [one] Rutare prin { $count } tailnet
        [few] Rutare prin { $count } tailneturi
       *[other] Rutare prin { $count } de tailneturi
    }
summary-routing-some =
    { $count ->
        [one] Rutare prin { $routing } din { $count } tailnet
        [few] Rutare prin { $routing } din { $count } tailneturi
       *[other] Rutare prin { $routing } din { $count } de tailneturi
    }
summary-signed-out = Neautentificat
summary-problem = Problemă: { $problem }
summary-connecting = Se conectează…
new-tailnet = Tailnet nou

## Cardul de stare din partea de sus a filei Tailneturi

hero-starting = Se pornește…
hero-connecting = Se conectează la tailneturile tale.
hero-paused = Acum nu trece nimic prin alte tailneturi. Rețeaua și tailnetul tău funcționează ca de obicei.
hero-finish-sign-in = Finalizează autentificarea în { $tailnet } din browser.
hero-sign-in = Autentifică-te în { $tailnet } ca să ajungi la mașinile lui.
hero-routing-example = Deschide { $address } sau orice altă adresă din aceste tailneturi. Restul traficului merge direct.
hero-routing = Adresele din aceste tailneturi se deschid în browser. Restul traficului merge direct.
add-tailnet = Adaugă un tailnet
pause-all = Întrerupe tot
pause-all-tooltip = Oprește deocamdată rutarea prin alte tailneturi
resume = Reia
resume-tooltip = Pornește din nou rutarea prin alte tailneturi

## Prima pornire, înainte de a adăuga vreun tailnet

welcome-title = Accesează mașini din alte tailneturi
welcome-text = Rămâi în propriul tailnet și deschide în același timp mașini din altele. Aplicația Tailscale funcționează în continuare ca de obicei.
welcome-sign-in = Autentifică-te în alt tailnet
welcome-sign-in-detail = Pagina de autentificare Tailscale se deschide în browser.
welcome-open = Deschide-i mașinile după nume
welcome-open-detail = Adrese ca { $example } funcționează în browser.
welcome-forward = Redirecționează un port când o aplicație are nevoie
welcome-forward-detail = Desktop la distanță, SSH și aplicațiile de baze de date primesc un port local care duce la o mașină.

## Cardul unui tailnet

machine-search-hint = Caută o mașină după nume, sistem sau adresă
clear-search = Șterge căutarea
more-actions = Mai multe acțiuni
edit-tailnet-menu = Redenumește sau adaugă domenii…
log-out-menu = Deconectează-te…
remove-menu = Elimină…
sign-in = Autentifică-te
pause-tailnet = Întrerupe acest tailnet
resume-tailnet = Reia acest tailnet
detail-tailnet = Tailnet
detail-routes = Rute
detail-this-computer = Acest computer
detail-problem = Problemă
routes-after-sign-in = Detectate după autentificare
hostname-after-sign-in = { $hostname } (după autentificare)
sign-in-help = Browserul nu s-a deschis sau s-a deschis în profilul greșit?
sign-in-open-again = Deschide din nou pagina de autentificare
sign-in-copy-link = Copiază linkul
sign-in-copy-link-tooltip = Lipește-l în browserul sau profilul de browser pe care îl folosești pentru acest tailnet

## Lista de mașini din cardul unui tailnet

machines-online = Mașini · { $online } din { $total } online
machines-matching = Mașini · { $shown } din { $total } corespund
no-machines = Nu se vede nicio altă mașină în acest tailnet.
no-machine-matches = Nicio mașină nu corespunde căutării.
machine-offline = { $name } (offline)
forward-port-tooltip = Redirecționează un port: pentru aplicații care ignoră setarea proxy, cum ar fi Desktop la distanță sau un client de baze de date
copy-address = Copiază { $address }
open-in-browser = Deschide { $url } în browser
not-routing-tooltip = Acest tailnet nu rutează acum. Este întrerupt?

## Site-uri găsite pe mașini

sites-heading = Site-uri
sites-help = Mașinile din tailnet-urile tale care servesc un site prin HTTPS. Fiecare mașină este verificată cel mult o dată pe zi.
# $done și $total numără mașini.
sites-checking = Se verifică { $done } din { $total }…
sites-recheck-tooltip = Verifică acum din nou toate mașinile
site-untrusted = Certificatul său nu este de încredere, așa că browserul va afișa un avertisment.
site-favorite-add = Adaugă la favorite
site-favorite-remove = Elimină din favorite
sites-show-all = Afișează toate site-urile ({ $count })
sites-show-fewer = Afișează mai puține

## Setări: redirecționări de porturi

forwards-heading = Redirecționări de porturi
forwards-help = Pentru aplicații care ignoră setarea proxy, cum ar fi Desktop la distanță, SSH și clienții de baze de date. Fiecare redirecționare este un port pe acest computer care duce la o mașină dintr-un tailnet.
edit-forwards = Editează redirecționările
# Păstrează LOCALPORT, auto și host:port așa cum sunt: asta se tastează.
forwards-format-help = Câte una pe linie: LOCALPORT = host:port sau auto = host:port pentru a alege un port liber. Numele gazdei decide ce tailnet o transportă. Pentru a adăuga rapid una, folosește butonul cu ștecher de lângă o mașină din fila Tailneturi.
forward-cant-listen = Nu se poate asculta: { $error }
forward-port-on-save = Portul se alege la salvare
forward-no-tailnet = Niciun tailnet cu rutare activă nu are acest nume
forward-via = prin { $tailnet }
open-remote-desktop-to = Deschide Desktop la distanță către { $address }

## Setări: proxy de sistem

proxy-heading = Setarea proxy a sistemului
proxy-on = Activat (recomandat)
proxy-force = Activat și înlocuiește scriptul proxy setat de compania ta cât timp rulează
proxy-off = Dezactivat: îmi configurez singur aplicațiile
proxy-help-windows = „Activat” îndreaptă Windows spre regulile acestei aplicații doar cât timp rulează și rutează, apoi restabilește totul când se oprește, este întreruptă, se deconectează sau se blochează.
proxy-help-macos = „Activat” setează proxyul pentru serviciile de rețea cât timp aplicația rulează și îl restabilește după aceea. Dacă Mac-ul cere o parolă de administrator pentru asta, ți se va cere când pornește rutarea și când închizi aplicația.
proxy-help-linux = „Activat” modifică setarea proxy din GNOME sau KDE cât timp aplicația rulează și rutează, apoi o restabilește. În Firefox, activează Setări > Setări de rețea > „Folosește setările proxy ale sistemului”.

## Setări: general

general-heading = General
start-at-login = Pornește { -app-name } când mă conectez
language = Limbă
system-default = Implicită a sistemului

## Setări: depanare

troubleshooting-heading = Depanare
troubleshooting-help = Testează o adresă web sau nume:port ca să vezi ce tailnet o transportă și dacă se conectează.
test = Testează
testing = Se testează…
open-log = Deschide jurnalul
open-settings-folder = Deschide dosarul de setări
about-line = { -app-name } { $version } · proxy local { $proxy } · PAC { $pac }
settings-location = Setări în { $path }

## Setări: nume

names-heading = Nume
names-help = Nume proprii pentru adrese din tailnet-urile tale, cum ar fi un server din spatele unui router de subrețea. Funcționează doar în browsere și în redirecționările de porturi de pe acest computer.
edit-names = Editează numele
# Păstrează „name = address” și exemplul așa cum sunt: asta se tastează.
names-format-help = Câte unul pe linie: name = address, de exemplu wiki = 192.168.20.15. Adresa poate fi o adresă IP sau numele unei mașini. Deschide-l ca http://wiki:8080/, cu portul folosit de site.

## Rezultatele „Testează” din Depanare

check-empty = Tastează numele unei mașini sau o adresă web.
check-bad-port = { $input }: acesta nu este un port valid.
check-not-routed = { $host } nu este rutat de { -app-name }: nu este un nume, o adresă sau o subrețea a niciunui tailnet care rutează acum, așa că merge direct (prin rețeaua obișnuită și prin propriul Tailscale).
# $tailnets lists the tailnets, separated by commas.
check-ambiguous = { $host } se află în mai multe tailnet-uri ({ $tailnets }), așa că nu este rutat. Folosește în schimb numele mașinii sau dezactivează subrețelele pentru unul dintre aceste tailnet-uri.
check-gone = Acel tailnet tocmai a dispărut.
check-not-running = { $tailnet } nu rulează.
check-ok = { $address } funcționează: conectat prin { $tailnet } în { $ms } ms.
check-failed =
    { $host } este rutat prin { $tailnet }, dar conectarea la portul { $port } a eșuat: { $error }
    Verifică dacă mașina este online și dacă ceva ascultă pe acel port.
check-timeout = { $host } este rutat prin { $tailnet }, dar portul { $port } nu a răspuns în 10 secunde.
domain-conflict = { $domain } este rutat și de { $tailnet }; acela are prioritate.

## Greșeli în setările tastate

forwards-line-format = Linia { $line }: scrie LOCALPORT = host:port.
forwards-line-port = Linia { $line }: „{ $value }” nu este un număr de port (sau auto).
forwards-line-target = Linia { $line }: „{ $value }” trebuie să fie host:port.
forwards-line-duplicate = Linia { $line }: portul local { $port } este folosit de două ori.
domain-invalid = „{ $domain }” nu este un domeniu; folosește ceva de genul example.ts.net.
domain-characters = „{ $domain }” conține caractere pe care un domeniu nu le poate avea.
names-line-format = Linia { $line }: scrie name = address.
names-line-name = Linia { $line }: „{ $value }” nu poate fi un nume. Folosește litere, cifre, cratime și puncte.
names-line-target = Linia { $line }: „{ $value }” nu este o adresă IP sau numele unei mașini.
names-line-duplicate = Linia { $line }: numele { $value } apare de două ori.
autostart-unsupported = Pornirea la conectare nu este acceptată pe acest sistem.

## Dialoguri

ok = OK
cancel = Anulează
done = Gata
copy = Copiază
error-title = Ceva nu a mers bine
error-details = Detaliile sunt în { $path }
edit-title = Editează { $tailnet }
tailnet-name = Nume
tailnet-name-hint = Afișat în această aplicație și în meniul din zona de notificare
extra-domains = Domenii suplimentare (opțional)
extra-domains-help = Domeniul propriu al tailnetului este rutat automat. Adaugă câte unul pe linie.
route-subnets = Rutează subrețelele sale
route-subnets-help = Rețele la care acest tailnet ajunge prin routerele sale de subrețea, cum ar fi o rețea în cloud. Dezactivează opțiunea dacă una dintre ele se suprapune cu o rețea în care se află acest computer.
forward-dialog-title = Redirecționează un port
forward-dialog-text = Primește un port pe acest computer care duce la { $host }. Ce port de pe acea mașină?
port-preset-remote-desktop = Desktop la distanță
port-tooltip = Portul { $port }
port = Port
port-hint = de ex. 8080
add-forward = Adaugă redirecționarea
not-a-port = „{ $value }” nu este un număr de port (1-65535).
forward-ready-title = Redirecționarea de port este gata
forward-ready-text = Configurează aplicația să folosească această adresă ca să ajungi la { $target }:
forward-ready-note = Portul rămâne același. Îl găsești în Setări.
open-remote-desktop = Deschide Desktop la distanță
remove-title = Elimini acest tailnet?
remove-text = { -app-name } se deconectează de la { $tailnet } și îl uită pe acest computer. Îl poți adăuga din nou mai târziu.
remove = Elimină
log-out-title = Te deconectezi?
log-out-text = Te deconectezi de la { $tailnet }? Adresele lui nu vor mai funcționa aici până te autentifici din nou.
log-out = Deconectează-te

## Meniul din zona de notificare (Windows, Linux) sau din bara de meniu (macOS)

tray-sign-in = { $tailnet }: autentifică-te…
tray-tailnet = { $tailnet }: { $state }
tray-add-tailnet = Adaugă un tailnet…
tray-route = Rutează prin alte tailneturi
tray-open = Deschide { -app-name }…
tray-quit = Ieșire
tray-tooltip = { -app-name }: { $summary }

## Notificarea de la prima închidere a ferestrei

still-running-title = { -app-name } rulează în continuare
still-running-windows = Continuă să ruteze în fundal. Îl găsești în zona de notificare; Windows îl poate ascunde sub săgeata ^ de lângă ceas.
still-running-macos = Continuă să ruteze în fundal. Îl găsești în bara de meniu.
still-running-linux = Continuă să ruteze în fundal. Îl găsești în zona de notificare.

## Numele limbilor în Setări, după numele propriu al fiecărei limbi

english = Engleză
french = Franceză
german = Germană
spanish-latin-america = Spaniolă latino-americană
spanish-spain = Spaniolă din Spania
chinese-simplified = Chineză simplificată
chinese-traditional = Chineză tradițională
korean = Coreeană
japanese = Japoneză
polish = Poloneză
russian = Rusă
portuguese-brazil = Portugheză braziliană
italian = Italiană
turkish = Turcă
ukrainian = Ucraineană
czech = Cehă
portuguese-portugal = Portugheză europeană
dutch = Neerlandeză
indonesian = Indoneziană
vietnamese = Vietnameză
thai = Thailandeză
swedish = Suedeză
romanian = Română
hungarian = Maghiară
afrikaans = Afrikaans
catalan = Catalană
serbian-cyrillic = Sârbă, chirilică
danish = Daneză
finnish = Finlandeză
greek = Greacă
norwegian-bokmal = Norvegiană bokmål
summary-proxy-problem = Conectat, dar aplicațiile tale nu îl folosesc
hero-proxy-taken = Browserul nu va deschide adresele din aceste tailneturi: setarea proxy a sistemului folosește alt script de configurare ({ $script }).
hero-proxy-other-copy = Browserul nu va deschide adresele din aceste tailneturi: altă copie de { -app-name } deține setarea proxy a sistemului. Închide copia aceea și aceasta va prelua controlul.
hero-proxy-changed = Browserul nu va deschide adresele din aceste tailneturi: altceva a modificat setarea proxy a sistemului.
hero-proxy-failed = Browserul nu va deschide adresele din aceste tailneturi: setarea proxy a sistemului nu a putut fi modificată ({ $error }).
hero-proxy-manual = Setarea proxy a sistemului este dezactivată, așa că doar aplicațiile pe care le configurezi singur ajung la aceste tailneturi. Îndreaptă-le spre { $pac }
proxy-replace = Înlocuiește-l
proxy-replace-tooltip = Folosește scriptul de configurare din { -app-name } cât timp rulează și pune-l înapoi pe celălalt după aceea
proxy-retry = Încearcă din nou
proxy-retry-tooltip = Îndreaptă din nou setarea proxy a sistemului spre { -app-name }
system-setting = Setarea proxy actuală a sistemului: { $value }
system-setting-none = niciunul
check-updates = Caută versiuni noi
find-websites = Caută site-uri pe mașinile din tailnet-urile tale
# $version is the version that's running, such as 0.6.0.
version-current = Versiunea { $version }
update-check-now = Verifică acum
update-checking = Se verifică…
update-up-to-date = Aveți cea mai nouă versiune
update-check-failed = Nu s-au putut căuta actualizări
tray-update = Descarcă { -app-name } { $version }…
update-available = A apărut versiunea { $version }
update-available-tooltip = Ai versiunea { $current }. Deschide pagina de descărcare.
update-notify-title = { -app-name } { $version } este disponibil
update-notify-text = Deschide { -app-name } ca să îl descarci.
migrate-failed = Autentificările tale din tailnet-proxy, versiunea anterioară a acestei aplicații, nu au putut fi mutate ({ $error }). Probabil încă rulează. Închide tailnet-proxy, apoi pornește din nou { -app-name } înainte să te autentifici aici: o nouă autentificare ar adăuga acest computer a doua oară în fiecare tailnet.
