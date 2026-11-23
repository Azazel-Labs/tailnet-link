### Tailnet Link: catalogo italiano.
### Mantieni i nomi Tailnet Link e Tailscale, e la parola “tailnet” (una rete Tailscale, invariabile al plurale).

-app-name = Tailnet Link

## Intestazione della finestra

tab-tailnets = Tailnet
tab-settings = Impostazioni

## Barra delle modifiche non salvate, in fondo alle Impostazioni

unsaved-changes = Hai modifiche non salvate.
save = Salva
revert = Ripristina
revert-tooltip = Annulla le modifiche
settings-saved = Impostazioni salvate

## Brevi note in fondo alla finestra

# $address è un nome di dispositivo o 127.0.0.1:porta.
copied-address = { $address } copiato
copied-sign-in-link = Link di accesso copiato

## Errori mostrati nella finestra “Si è verificato un problema”

start-failed =
    { -app-name } non riesce ad avviarsi:
    { $error }
add-tailnet-failed =
    Impossibile aggiungere un tailnet:
    { $error }
add-forward-failed =
    Impossibile aggiungere il port forwarding:
    { $error }
remote-desktop-failed = Impossibile avviare Desktop remoto: { $error }
remote-desktop-windows-only = Desktop remoto è integrato solo in Windows.
no-free-port = Nessuna porta locale libera trovata.

## Finestra dopo “Aggiungi un tailnet”

sign-in-dialog-title = Accedi al nuovo tailnet
sign-in-dialog-text =
    Il browser sta aprendo la pagina di accesso di Tailscale. Potrebbe aprirsi dietro questa finestra.
    
    Accedi con il tuo account per quel tailnet, poi torna qui. Il suo dominio viene rilevato automaticamente.

## Stato di un tailnet, mostrato come etichetta colorata accanto al nome

state-waiting-sign-in = In attesa di accesso
state-signed-out = Disconnesso
state-problem = Problema
state-connecting = Connessione in corso
state-paused = In pausa
state-no-domain = Ancora nessun dominio
state-not-routing = Instradamento inattivo
state-routing = Instradamento attivo

## Stato generale dell'app, nella scheda di stato e nel menu dell'area di notifica

summary-no-tailnets = Ancora nessun tailnet
summary-paused = In pausa
# $tailnet è il nome dell'unico tailnet.
summary-routing-one = Instradamento tramite { $tailnet }
# Tutti i tailnet instradano; $count è almeno 2.
summary-routing-all =
    { $count ->
        [one] Instradamento tramite { $count } tailnet
       *[other] Instradamento tramite { $count } tailnet
    }
summary-routing-some =
    { $count ->
        [one] Instradamento tramite { $routing } tailnet su { $count }
       *[other] Instradamento tramite { $routing } tailnet su { $count }
    }
summary-signed-out = Accesso non effettuato
summary-problem = Problema: { $problem }
summary-connecting = Connessione in corso…
# Un tailnet prima del primo accesso, quando non ha ancora un nome.
new-tailnet = Nuovo tailnet

## Scheda di stato in cima alla scheda Tailnet

hero-starting = Avvio in corso…
hero-connecting = Connessione ai tuoi tailnet.
hero-paused = Al momento non passa nulla attraverso gli altri tailnet. La tua rete e il tuo tailnet funzionano come sempre.
hero-finish-sign-in = Completa l'accesso a { $tailnet } nel browser.
hero-sign-in = Accedi a { $tailnet } per raggiungere i suoi dispositivi.
# $address è il nome di un dispositivo, ad esempio build-pc.example.ts.net.
hero-routing-example = Apri { $address } o qualsiasi altro indirizzo di questi tailnet. Tutto il resto va diretto.
hero-routing = Gli indirizzi di questi tailnet si aprono nel browser. Tutto il resto va diretto.
add-tailnet = Aggiungi un tailnet
pause-all = Metti tutto in pausa
pause-all-tooltip = Interrompi per ora l'instradamento attraverso gli altri tailnet
resume = Riprendi
resume-tooltip = Riprendi l'instradamento attraverso gli altri tailnet

## Primo avvio, prima di aggiungere un tailnet

welcome-title = Raggiungi i dispositivi di altri tailnet
welcome-text = Resta sul tuo tailnet e apri allo stesso tempo i dispositivi degli altri. L'app Tailscale continua a funzionare come sempre.
welcome-sign-in = Accedi a un altro tailnet
welcome-sign-in-detail = La pagina di accesso di Tailscale si apre nel browser.
welcome-open = Apri i suoi dispositivi per nome
# $example è un indirizzo di esempio, build-pc.example.ts.net.
welcome-open-detail = Indirizzi come { $example } funzionano nel browser.
welcome-forward = Inoltra una porta quando un'app ne ha bisogno
welcome-forward-detail = Desktop remoto, SSH e le app per database ricevono una porta locale che conduce a un dispositivo.

## Scheda di un tailnet

machine-search-hint = Cerca un dispositivo per nome, sistema operativo o indirizzo
clear-search = Cancella la ricerca
more-actions = Altre azioni
edit-tailnet-menu = Rinomina o aggiungi domini…
log-out-menu = Esci dall'account…
remove-menu = Rimuovi…
sign-in = Accedi
pause-tailnet = Metti in pausa questo tailnet
resume-tailnet = Riprendi questo tailnet
detail-tailnet = Tailnet
detail-routes = Route
detail-this-computer = Questo computer
detail-problem = Problema
routes-after-sign-in = Rilevate dopo l'accesso
# $hostname è il nome di questo computer nel tailnet.
hostname-after-sign-in = { $hostname } (dopo l'accesso)
sign-in-help = Il browser non si è aperto, o ha aperto il profilo sbagliato?
sign-in-open-again = Riapri la pagina di accesso
sign-in-copy-link = Copia il link
sign-in-copy-link-tooltip = Incollalo nel browser, o nel profilo del browser, che usi per questo tailnet

## Elenco dei dispositivi nella scheda di un tailnet

machines-online = Dispositivi · { $online } di { $total } online
machines-matching = Dispositivi · { $shown } di { $total } corrispondenti
no-machines = Nessun altro dispositivo è visibile in questo tailnet.
no-machine-matches = Nessun dispositivo corrisponde alla ricerca.
machine-offline = { $name } (offline)
forward-port-tooltip = Inoltra una porta: per le app che ignorano l'impostazione del proxy, come Desktop remoto o un client di database
copy-address = Copia { $address }
open-in-browser = Apri { $url } nel browser
not-routing-tooltip = Questo tailnet non sta instradando al momento. È in pausa?

## Siti web trovati sui dispositivi

sites-heading = Siti web
sites-help = Dispositivi dei tuoi tailnet che offrono un sito web via HTTPS. Ogni dispositivo viene controllato al massimo una volta al giorno.
# $done e $total contano dispositivi.
sites-checking = Controllo { $done } di { $total }…
sites-recheck-tooltip = Ricontrolla ora tutti i dispositivi
site-untrusted = Il suo certificato non è attendibile, quindi il browser mostrerà un avviso.

## Impostazioni: port forwarding

forwards-heading = Port forwarding
forwards-help = Per le app che ignorano l'impostazione del proxy, come Desktop remoto, SSH e i client di database. Ogni inoltro è una porta di questo computer che conduce a un dispositivo in un tailnet.
edit-forwards = Modifica inoltri
# Lascia LOCALPORT, auto e host:port così come sono: è ciò che si digita.
forwards-format-help = Uno per riga: LOCALPORT = host:port, oppure auto = host:port per scegliere una porta libera. Il nome dell'host decide quale tailnet lo trasporta. Per aggiungerne uno al volo, usa il pulsante a forma di spina accanto a un dispositivo nella scheda Tailnet.
forward-cant-listen = Impossibile restare in ascolto: { $error }
forward-port-on-save = La porta viene scelta al salvataggio
forward-no-tailnet = Nessun tailnet attivo ha questo nome
# $tailnet è il tailnet che trasporta l'inoltro.
forward-via = tramite { $tailnet }
open-remote-desktop-to = Apri Desktop remoto verso { $address }

## Impostazioni: proxy di sistema

proxy-heading = Impostazione del proxy di sistema
proxy-on = Attivo (consigliato)
proxy-force = Attivo, e sostituisci lo script proxy impostato dalla tua azienda durante l'esecuzione
proxy-off = Disattivo: configuro io le mie app
proxy-help-windows = “Attivo” indirizza Windows alle regole di questa app solo mentre è in esecuzione e instrada, e ripristina tutto quando si chiude, va in pausa, si disconnette o si arresta in modo anomalo.
proxy-help-macos = “Attivo” imposta il proxy per i tuoi servizi di rete mentre l'app è in esecuzione e poi lo ripristina. Se il Mac richiede una password di amministratore per farlo, ti verrà chiesta all'avvio dell'instradamento e all'uscita.
proxy-help-linux = “Attivo” imposta il proxy di GNOME o KDE mentre l'app è in esecuzione e instrada, e poi lo ripristina. In Firefox, attiva Impostazioni > Impostazioni di rete > “Utilizza le impostazioni proxy del sistema”.

## Impostazioni: generali

general-heading = Generali
start-at-login = Avvia { -app-name } all'accesso
language = Lingua
system-default = Lingua del sistema

## Impostazioni: risoluzione dei problemi

troubleshooting-heading = Risoluzione dei problemi
troubleshooting-help = Prova un indirizzo web o nome:porta per vedere quale tailnet lo trasporta e se si connette.
test = Prova
testing = Prova in corso…
open-log = Apri il log
open-settings-folder = Apri la cartella delle impostazioni
about-line = { -app-name } { $version } · proxy locale { $proxy } · PAC { $pac }
settings-location = Impostazioni in { $path }

## Risultati di “Prova” in Risoluzione dei problemi

check-empty = Digita un nome di dispositivo o un indirizzo web.
check-bad-port = { $input }: non è una porta valida.
check-not-routed = { $host } non viene instradato da { -app-name }: non termina con il dominio di nessun tailnet attivo in questo momento, quindi va diretto (attraverso la tua rete normale e il tuo Tailscale).
check-gone = Quel tailnet è appena scomparso.
check-not-running = { $tailnet } non è in esecuzione.
check-ok = { $address } funziona: connesso tramite { $tailnet } in { $ms } ms.
check-failed =
    { $host } è instradato tramite { $tailnet }, ma la connessione alla porta { $port } non è riuscita: { $error }
    Controlla che il dispositivo sia online e che qualcosa sia in ascolto su quella porta.
check-timeout = { $host } è instradato tramite { $tailnet }, ma la porta { $port } non ha risposto entro 10 secondi.
# Due tailnet rivendicano lo stesso dominio; $tailnet è quello di cui si usano le route.
domain-conflict = { $domain } è instradato anche da { $tailnet }; prevale quello.

## Errori nelle impostazioni digitate

forwards-line-format = Riga { $line }: scrivi LOCALPORT = host:port.
forwards-line-port = Riga { $line }: “{ $value }” non è un numero di porta (né auto).
forwards-line-target = Riga { $line }: “{ $value }” deve essere host:port.
forwards-line-duplicate = Riga { $line }: la porta locale { $port } è usata due volte.
domain-invalid = “{ $domain }” non è un dominio; usa qualcosa come example.ts.net.
domain-characters = “{ $domain }” contiene caratteri non ammessi in un dominio.
autostart-unsupported = L'avvio all'accesso non è supportato su questo sistema.

## Finestre di dialogo

ok = OK
cancel = Annulla
done = Fatto
copy = Copia
error-title = Si è verificato un problema
error-details = Dettagli in { $path }
# $tailnet è il nome del tailnet.
edit-title = Modifica { $tailnet }
tailnet-name = Nome
tailnet-name-hint = Mostrato in questa app e nel menu dell'area di notifica
extra-domains = Domini aggiuntivi (facoltativi)
extra-domains-help = Il dominio del tailnet viene instradato automaticamente. Aggiungine uno per riga.
forward-dialog-title = Inoltra una porta
forward-dialog-text = Ottieni una porta su questo computer che conduce a { $host }. Quale porta su quel dispositivo?
port-preset-remote-desktop = Desktop remoto
port-tooltip = Porta { $port }
port = Porta
port-hint = es. 8080
add-forward = Aggiungi inoltro
not-a-port = “{ $value }” non è un numero di porta (1-65535).
forward-ready-title = Port forwarding pronto
forward-ready-text = Indica questo indirizzo alla tua app per raggiungere { $target }:
forward-ready-note = La porta resta la stessa. La trovi nelle Impostazioni.
open-remote-desktop = Apri Desktop remoto
remove-title = Rimuovere questo tailnet?
remove-text = { -app-name } esce da { $tailnet } e lo dimentica su questo computer. Potrai aggiungerlo di nuovo in seguito.
remove = Rimuovi
log-out-title = Uscire dall'account?
log-out-text = Uscire da { $tailnet }? I suoi indirizzi smettono di funzionare qui finché non accedi di nuovo.
log-out = Esci

## Menu dell'area di notifica (Windows, Linux) o della barra dei menu (macOS)

tray-sign-in = { $tailnet }: accedi…
# $state è una delle etichette state-* qui sopra.
tray-tailnet = { $tailnet }: { $state }
tray-add-tailnet = Aggiungi un tailnet…
tray-route = Instrada attraverso gli altri tailnet
tray-open = Apri { -app-name }…
tray-quit = Esci
tray-tooltip = { -app-name }: { $summary }

## Notifica alla prima chiusura della finestra

still-running-title = { -app-name } è ancora in esecuzione
still-running-windows = Continua a instradare in background. Lo trovi nell'area di notifica; Windows potrebbe nasconderlo sotto la freccia ^ vicino all'orologio.
still-running-macos = Continua a instradare in background. Lo trovi nella barra dei menu.
still-running-linux = Continua a instradare in background. Lo trovi nell'area di notifica.

## Nomi delle lingue nelle Impostazioni, dopo il nome di ogni lingua nella lingua stessa

english = Inglese
french = Francese
german = Tedesco
spanish-latin-america = Spagnolo latinoamericano
spanish-spain = Spagnolo di Spagna
chinese-simplified = Cinese semplificato
chinese-traditional = Cinese tradizionale
korean = Coreano
japanese = Giapponese
polish = Polacco
russian = Russo
portuguese-brazil = Portoghese brasiliano
italian = Italiano
turkish = Turco
ukrainian = Ucraino
czech = Ceco
portuguese-portugal = Portoghese europeo
dutch = Olandese
indonesian = Indonesiano
vietnamese = Vietnamita
thai = Thailandese
swedish = Svedese
romanian = Rumeno
hungarian = Ungherese
afrikaans = Afrikaans
catalan = Catalano
serbian-cyrillic = Serbo, cirillico
danish = Danese
finnish = Finlandese
greek = Greco
norwegian-bokmal = Norvegese bokmål
summary-proxy-problem = Connesso, ma le tue app non lo usano
hero-proxy-taken = Il browser non aprirà gli indirizzi di questi tailnet: l'impostazione del proxy di sistema usa un altro script di configurazione ({ $script }).
hero-proxy-other-copy = Il browser non aprirà gli indirizzi di questi tailnet: un'altra copia di { -app-name } controlla l'impostazione del proxy di sistema. Chiudi quella copia e questa subentrerà.
hero-proxy-changed = Il browser non aprirà gli indirizzi di questi tailnet: qualcos'altro ha modificato l'impostazione del proxy di sistema.
hero-proxy-failed = Il browser non aprirà gli indirizzi di questi tailnet: non è stato possibile modificare l'impostazione del proxy di sistema ({ $error }).
hero-proxy-manual = L'impostazione del proxy di sistema è disattivata, quindi solo le app che configuri tu raggiungono questi tailnet. Indirizzale a { $pac }
proxy-replace = Sostituiscilo
proxy-replace-tooltip = Usa lo script di configurazione di { -app-name } mentre è in esecuzione e poi ripristina l'altro
proxy-retry = Riprova
proxy-retry-tooltip = Indirizza di nuovo l'impostazione del proxy di sistema a { -app-name }
system-setting = Impostazione del proxy di sistema attuale: { $value }
system-setting-none = nessuno
check-updates = Cerca nuove versioni
find-websites = Cerca siti web sui dispositivi dei tuoi tailnet
tray-update = Scarica { -app-name } { $version }…
update-available = Versione { $version } disponibile
update-available-tooltip = Hai la versione { $current }. Apre la pagina di download.
update-notify-title = { -app-name } { $version } è disponibile
update-notify-text = Apri { -app-name } per scaricarlo.
migrate-failed = Non è stato possibile trasferire i tuoi accessi da tailnet-proxy, la versione precedente di questa app ({ $error }). Probabilmente è ancora in esecuzione. Chiudi tailnet-proxy, poi riavvia { -app-name } prima di accedere qui: accedere di nuovo aggiungerebbe questo computer a ogni tailnet una seconda volta.
