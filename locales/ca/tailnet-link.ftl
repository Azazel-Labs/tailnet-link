### Tailnet Link: catàleg en català.
### Mantén els noms Tailnet Link i Tailscale i la paraula «tailnet» (una xarxa de Tailscale).

-app-name = Tailnet Link

## Capçalera de la finestra

tab-tailnets = Tailnets
tab-settings = Configuració

## Barra de canvis sense desar a la part inferior de Configuració

unsaved-changes = Tens canvis sense desar.
save = Desa
revert = Reverteix
revert-tooltip = Desfés els canvis
settings-saved = S’ha desat la configuració

## Avisos breus a la part inferior de la finestra

copied-address = S’ha copiat { $address }
copied-sign-in-link = S’ha copiat l’enllaç d’inici de sessió

## Errors del diàleg «Alguna cosa ha anat malament»

start-failed =
    { -app-name } no es pot iniciar:
    { $error }
add-tailnet-failed =
    No s’ha pogut afegir una tailnet:
    { $error }
add-forward-failed =
    No s’ha pogut afegir la redirecció de port:
    { $error }
remote-desktop-failed = No s’ha pogut iniciar l’Escriptori remot: { $error }
remote-desktop-windows-only = L’Escriptori remot només està integrat a Windows.
no-free-port = No s’ha trobat cap port local lliure.

## Diàleg després d’«Afegeix una tailnet»

sign-in-dialog-title = Inicia la sessió a la tailnet nova
sign-in-dialog-text =
    El navegador està obrint la pàgina d’inici de sessió de Tailscale. Pot ser que s’obri darrere d’aquesta finestra.
    
    Inicia la sessió amb el teu compte d’aquella tailnet i torna aquí. El domini es detecta automàticament.

## Estat d’una tailnet, en una etiqueta de color al costat del nom

state-waiting-sign-in = Esperant l’inici de sessió
state-signed-out = Sessió tancada
state-problem = Problema
state-connecting = Connectant
state-paused = En pausa
state-no-domain = Encara sense domini
state-not-routing = Sense encaminament
state-routing = Encaminant

## Estat de tota l’aplicació, a la targeta d’estat i al menú de la safata

summary-no-tailnets = Encara no hi ha cap tailnet
summary-paused = En pausa
summary-routing-one = Encaminant per { $tailnet }
summary-routing-all =
    { $count ->
        [one] Encaminant per { $count } tailnet
       *[other] Encaminant per { $count } tailnets
    }
summary-routing-some =
    { $count ->
        [one] Encaminant per { $routing } de { $count } tailnet
       *[other] Encaminant per { $routing } de { $count } tailnets
    }
summary-signed-out = Sessió no iniciada
summary-problem = Problema: { $problem }
summary-connecting = Connectant…
new-tailnet = Tailnet nova

## Targeta d’estat a la part superior de la pestanya Tailnets

hero-starting = Iniciant…
hero-connecting = Connectant amb les teves tailnets.
hero-paused = Ara mateix no passa res per les altres tailnets. La teva xarxa i la teva tailnet funcionen com sempre.
hero-finish-sign-in = Acaba d’iniciar la sessió a { $tailnet } al navegador.
hero-sign-in = Inicia la sessió a { $tailnet } per accedir a les seves màquines.
hero-routing-example = Obre { $address } o qualsevol altra adreça d’aquestes tailnets. Tota la resta va directa.
hero-routing = Les adreces d’aquestes tailnets s’obren al navegador. Tota la resta va directa.
add-tailnet = Afegeix una tailnet
pause-all = Posa-ho tot en pausa
pause-all-tooltip = Deixa d’encaminar per les altres tailnets de moment
resume = Reprèn
resume-tooltip = Torna a encaminar per les altres tailnets

## Primera execució, abans d’afegir cap tailnet

welcome-title = Accedeix a màquines d’altres tailnets
welcome-text = Queda’t a la teva tailnet i obre màquines d’altres alhora. L’aplicació de Tailscale continua funcionant com sempre.
welcome-sign-in = Inicia la sessió a una altra tailnet
welcome-sign-in-detail = La pàgina d’inici de sessió de Tailscale s’obre al navegador.
welcome-open = Obre les seves màquines pel nom
welcome-open-detail = Les adreces com { $example } funcionen al navegador.
welcome-forward = Redirigeix un port quan una aplicació el necessiti
welcome-forward-detail = L’Escriptori remot, SSH i les aplicacions de bases de dades obtenen un port local que porta a una màquina.

## Targeta d’una tailnet

machine-search-hint = Cerca una màquina per nom, sistema o adreça
clear-search = Esborra la cerca
open-terminal-tooltip = Obre un terminal on funcionen els noms de les teves tailnets, per a curl, git, ssh, ping i més. O posa tl davant de qualsevol ordre en qualsevol terminal.
open-terminal-missing = { -app-name } no troba tl, el seu ajudant de terminal, al costat de l’aplicació. Reinstal·la { -app-name } per obtenir-lo.
open-terminal-failed = No s’ha pogut obrir un terminal: { $error }
more-actions = Més accions
edit-tailnet-menu = Canvia el nom o afegeix dominis…
log-out-menu = Tanca la sessió…
remove-menu = Elimina…
sign-in = Inicia la sessió
pause-tailnet = Posa en pausa aquesta tailnet
resume-tailnet = Reprèn aquesta tailnet
detail-tailnet = Tailnet
detail-routes = Rutes
detail-this-computer = Aquest ordinador
detail-problem = Problema
routes-after-sign-in = Es detecten quan inicies la sessió
hostname-after-sign-in = { $hostname } (quan inicies la sessió)
sign-in-help = El navegador no s’ha obert, o s’ha obert amb el perfil equivocat?
sign-in-open-again = Torna a obrir la pàgina d’inici de sessió
sign-in-copy-link = Copia l’enllaç
sign-in-copy-link-tooltip = Enganxa’l al navegador, o perfil del navegador, que fas servir per a aquesta tailnet

## Llista de màquines a la targeta d’una tailnet

machines-online = Màquines · { $online } de { $total } en línia
machines-matching = Màquines · { $shown } de { $total } coincideixen
no-machines = No hi ha cap altra màquina visible en aquesta tailnet.
no-machine-matches = Cap màquina coincideix amb la cerca.
machine-offline = { $name } (fora de línia)
forward-port-tooltip = Redirigeix un port: per a aplicacions que ignoren la configuració del proxy, com l’Escriptori remot o un client de bases de dades
copy-address = Copia { $address }
open-in-browser = Obre { $url } al navegador
not-routing-tooltip = Aquesta tailnet no està encaminant ara mateix. Potser està en pausa?

## Llocs web trobats a les màquines

sites-heading = Llocs web
sites-help = Màquines de les teves tailnets que serveixen un lloc web per HTTPS. Cada màquina es comprova com a màxim un cop al dia.
# $done i $total compten màquines.
sites-checking = S’està comprovant { $done } de { $total }…
sites-recheck-tooltip = Torna a comprovar totes les màquines ara
site-untrusted = El seu certificat no és de confiança, així que el navegador t’avisarà.
site-favorite-add = Afegeix als preferits
site-favorite-remove = Treu dels preferits
sites-show-all = Mostra tots els llocs web ({ $count })
sites-show-fewer = Mostra’n menys

## Configuració: redireccions de ports

forwards-heading = Redireccions de ports
forwards-help = Per a aplicacions que ignoren la configuració del proxy, com l’Escriptori remot, SSH i els clients de bases de dades. Cada redirecció és un port d’aquest ordinador que porta a una màquina d’una tailnet.
edit-forwards = Edita les redireccions
# Mantén LOCALPORT, auto i host:port tal com són: és el que s’escriu.
forwards-format-help = Una per línia: LOCALPORT = host:port, o auto = host:port perquè es triï un port lliure. El nom de l’amfitrió decideix quina tailnet la transporta. Per afegir-ne una ràpidament, fes servir el botó de l’endoll d’una màquina a la pestanya Tailnets.
forward-cant-listen = No es pot escoltar: { $error }
forward-port-on-save = El port es tria en desar
forward-no-tailnet = Cap tailnet que encamini té aquest nom
forward-via = per { $tailnet }
open-remote-desktop-to = Obre l’Escriptori remot a { $address }

## Configuració: proxy del sistema

proxy-heading = Configuració del proxy del sistema
proxy-on = Activat (recomanat)
proxy-force = Activat, i substitueix l’script de proxy de la teva empresa mentre s’executa
proxy-off = Desactivat: configuraré les aplicacions jo mateix
proxy-help-windows = «Activat» fa que Windows utilitzi les regles d’aquesta aplicació només mentre s’executa i encamina, i ho restaura tot quan s’atura, es posa en pausa, es desconnecta o falla.
proxy-help-macos = «Activat» configura el proxy dels serveis de xarxa mentre l’aplicació s’executa i el restaura després. Si el Mac demana una contrasenya d’administrador per fer-ho, se’t demanarà quan comenci l’encaminament i quan surtis.
proxy-help-linux = «Activat» configura el proxy de GNOME o KDE mentre l’aplicació s’executa i encamina, i el restaura després. Al Firefox, activa Paràmetres > Paràmetres de xarxa > «Utilitza la configuració del servidor intermediari del sistema».

## Configuració: general

general-heading = General
start-at-login = Inicia { -app-name } quan iniciï la sessió
language = Idioma
system-default = Valor predeterminat del sistema

## Configuració: resolució de problemes

troubleshooting-heading = Resolució de problemes
troubleshooting-help = Prova una adreça web o nom:port per veure quina tailnet la transporta i si connecta.
test = Prova
testing = S’està provant…
open-log = Obre el registre
open-settings-folder = Obre la carpeta de configuració
about-line = { -app-name } { $version } · proxy local { $proxy } · PAC { $pac }
settings-location = Configuració a { $path }

## Configuració: noms

names-heading = Noms
names-help = Noms propis per a adreces de les teves tailnets, com ara un servidor darrere d’un encaminador de subxarxa. Només funcionen als navegadors i a les redireccions de ports d’aquest ordinador.
edit-names = Edita els noms
# Mantén «name = address» i l’exemple tal com són: és el que s’escriu.
names-format-help = Un per línia: name = address, per exemple wiki = 192.168.20.15. L’adreça pot ser una adreça IP o el nom d’una màquina. Obre’l com a http://wiki:8080/, amb el port que fa servir el lloc web.

## Resultats de «Prova» a Resolució de problemes

check-empty = Escriu el nom d’una màquina o una adreça web.
check-bad-port = { $input }: aquest port no és vàlid.
check-not-routed = { -app-name } no encamina { $host }: no és un nom, una adreça ni una subxarxa de cap tailnet que encamini ara mateix, de manera que va directe (per la teva xarxa normal i el teu propi Tailscale).
# $tailnets lists the tailnets, separated by commas.
check-ambiguous = { $host } és a més d’una tailnet ({ $tailnets }), de manera que no s’encamina. Fes servir el nom de la màquina, o desactiva les subxarxes d’una d’aquestes tailnets.
check-gone = Aquesta tailnet acaba de desaparèixer.
check-not-running = { $tailnet } no s’està executant.
ping-no-machine = { $host } passa per { $tailnet }, però no és cap de les seves màquines, de manera que Tailscale no té res a què fer ping.
check-ok = { $address } funciona: connectat per { $tailnet } en { $ms } ms.
check-failed =
    { $host } s’encamina per { $tailnet }, però la connexió al port { $port } ha fallat: { $error }
    Comprova que la màquina estigui en línia i que hi hagi alguna cosa escoltant en aquest port.
check-timeout = { $host } s’encamina per { $tailnet }, però el port { $port } no ha respost en 10 segons.
domain-conflict = { $tailnet } també encamina { $domain }; aquesta té prioritat.

## Errors en la configuració escrita

forwards-line-format = Línia { $line }: escriu LOCALPORT = host:port.
forwards-line-port = Línia { $line }: «{ $value }» no és un número de port (ni auto).
forwards-line-target = Línia { $line }: «{ $value }» hauria de ser host:port.
forwards-line-duplicate = Línia { $line }: el port local { $port } s’utilitza dues vegades.
domain-invalid = «{ $domain }» no és un domini; fes servir alguna cosa com example.ts.net.
domain-characters = «{ $domain }» conté caràcters que un domini no pot tenir.
names-line-format = Línia { $line }: escriu name = address.
names-line-name = Línia { $line }: «{ $value }» no pot ser un nom. Fes servir lletres, xifres, guions i punts.
names-line-target = Línia { $line }: «{ $value }» no és una adreça IP ni el nom d’una màquina.
names-line-duplicate = Línia { $line }: el nom { $value } apareix dues vegades.
autostart-unsupported = Aquest sistema no admet l’inici en iniciar la sessió.

## Diàlegs

ok = D’acord
cancel = Cancel·la
done = Fet
copy = Copia
error-title = Alguna cosa ha anat malament
error-details = Els detalls són a { $path }
edit-title = Edita { $tailnet }
tailnet-name = Nom
tailnet-name-hint = Es mostra en aquesta aplicació i al menú de la safata
extra-domains = Dominis addicionals (opcional)
extra-domains-help = El domini propi de la tailnet s’encamina automàticament. Afegeix-ne un per línia.
route-subnets = Encamina les seves subxarxes
route-subnets-help = Xarxes a què arriba aquesta tailnet a través dels seus encaminadors de subxarxa, com ara una xarxa al núvol. Desactiva-ho si alguna se solapa amb una xarxa a què està connectat aquest ordinador.
forward-dialog-title = Redirigeix un port
forward-dialog-text = Obtén un port en aquest ordinador que porta a { $host }. Quin port d’aquella màquina?
port-preset-remote-desktop = Escriptori remot
port-tooltip = Port { $port }
port = Port
port-hint = p. ex. 8080
add-forward = Afegeix la redirecció
not-a-port = «{ $value }» no és un número de port (1-65535).
forward-ready-title = Redirecció de port preparada
forward-ready-text = Configura l’aplicació perquè utilitzi aquesta adreça per arribar a { $target }:
forward-ready-note = El port no canvia. El trobaràs a Configuració.
open-remote-desktop = Obre l’Escriptori remot
remove-title = Vols eliminar aquesta tailnet?
remove-text = { -app-name } tanca la sessió a { $tailnet } i l’oblida en aquest ordinador. La pots tornar a afegir més endavant.
remove = Elimina
log-out-title = Vols tancar la sessió?
log-out-text = Vols tancar la sessió a { $tailnet }? Les seves adreces deixaran de funcionar aquí fins que tornis a iniciar la sessió.
log-out = Tanca la sessió

## Menú de la safata (Windows, Linux) o de la barra de menús (macOS)

tray-sign-in = { $tailnet }: inicia la sessió…
tray-tailnet = { $tailnet }: { $state }
tray-add-tailnet = Afegeix una tailnet…
tray-route = Encamina per les altres tailnets
tray-open = Obre { -app-name }…
tray-quit = Surt
tray-tooltip = { -app-name }: { $summary }

## Notificació la primera vegada que es tanca la finestra

still-running-title = { -app-name } continua en execució
still-running-windows = Continua encaminant en segon pla. El trobaràs a la safata del sistema; pot ser que Windows l’amagui sota la fletxa ^ al costat del rellotge.
still-running-macos = Continua encaminant en segon pla. El trobaràs a la barra de menús.
still-running-linux = Continua encaminant en segon pla. El trobaràs a la safata del sistema.

## Noms dels idiomes a Configuració, després del nom propi de cada idioma

english = Anglès
french = Francès
german = Alemany
spanish-latin-america = Espanyol d’Amèrica Llatina
spanish-spain = Espanyol d’Espanya
chinese-simplified = Xinès simplificat
chinese-traditional = Xinès tradicional
korean = Coreà
japanese = Japonès
polish = Polonès
russian = Rus
portuguese-brazil = Portuguès del Brasil
italian = Italià
turkish = Turc
ukrainian = Ucraïnès
czech = Txec
portuguese-portugal = Portuguès europeu
dutch = Neerlandès
indonesian = Indonesi
vietnamese = Vietnamita
thai = Tai
swedish = Suec
romanian = Romanès
hungarian = Hongarès
afrikaans = Afrikaans
catalan = Català
serbian-cyrillic = Serbi, ciríl·lic
danish = Danès
finnish = Finès
greek = Grec
norwegian-bokmal = Noruec bokmål
summary-proxy-problem = Connectat, però les aplicacions no l’utilitzen
hero-proxy-taken = El navegador no obrirà les adreces d’aquestes tailnets: la configuració del proxy del sistema utilitza un altre script de configuració ({ $script }).
hero-proxy-other-copy = El navegador no obrirà les adreces d’aquestes tailnets: una altra còpia de { -app-name } té la configuració del proxy del sistema. Surt d’aquella còpia i aquesta en prendrà el control.
hero-proxy-changed = El navegador no obrirà les adreces d’aquestes tailnets: alguna altra cosa ha canviat la configuració del proxy del sistema.
hero-proxy-failed = El navegador no obrirà les adreces d’aquestes tailnets: no s’ha pogut canviar la configuració del proxy del sistema ({ $error }).
hero-proxy-manual = La configuració del proxy del sistema està desactivada, de manera que només les aplicacions que configuris tu mateix arriben a aquestes tailnets. Fes que apuntin a { $pac }
proxy-replace = Substitueix-lo
proxy-replace-tooltip = Utilitza l’script de configuració de { -app-name } mentre s’executa i restaura l’altre després
proxy-retry = Torna-ho a provar
proxy-retry-tooltip = Torna a fer que la configuració del proxy del sistema apunti a { -app-name }
system-setting = Configuració actual del proxy del sistema: { $value }
system-setting-none = cap
check-updates = Cerca versions noves
find-websites = Cerca llocs web a les màquines de les teves tailnets
# $version is the version that's running, such as 0.6.0.
version-current = Versió { $version }
update-check-now = Comprova-ho ara
update-checking = S’està comprovant…
update-up-to-date = Teniu la versió més recent
update-check-failed = No s’han pogut cercar actualitzacions
tray-update = Baixa { -app-name } { $version }…
update-available = Versió { $version } disponible
update-available-tooltip = Tens la versió { $current }. Obre la pàgina de baixada.
update-notify-title = { -app-name } { $version } ja està disponible
update-notify-text = Obre { -app-name } per baixar-lo.
migrate-failed = No s’han pogut traslladar les sessions iniciades a tailnet-proxy, la versió anterior d’aquesta aplicació ({ $error }). Probablement encara s’està executant. Surt de tailnet-proxy i torna a iniciar { -app-name } abans d’iniciar la sessió aquí: tornar a iniciar la sessió afegiria aquest ordinador a cada tailnet per segona vegada.
