### Tailnet Link: deutscher Katalog.
### Die Namen Tailnet Link und Tailscale sowie das Wort „Tailnet“ (ein Tailscale-Netzwerk) bleiben erhalten.

-app-name = Tailnet Link

## Fensterkopf

tab-tailnets = Tailnets
tab-settings = Einstellungen

## Leiste für ungespeicherte Änderungen unten in den Einstellungen

unsaved-changes = Sie haben ungespeicherte Änderungen.
save = Speichern
revert = Verwerfen
revert-tooltip = Änderungen rückgängig machen
settings-saved = Einstellungen gespeichert

## Kurze Hinweise unten im Fenster

# $address ist ein Gerätename oder 127.0.0.1:Port.
copied-address = { $address } kopiert
copied-sign-in-link = Anmeldelink kopiert

## Fehler im Dialog „Etwas ist schiefgelaufen“

start-failed =
    { -app-name } kann nicht starten:
    { $error }
add-tailnet-failed =
    Tailnet konnte nicht hinzugefügt werden:
    { $error }
add-forward-failed =
    Portweiterleitung konnte nicht hinzugefügt werden:
    { $error }
remote-desktop-failed = Remotedesktop konnte nicht gestartet werden: { $error }
remote-desktop-windows-only = Remotedesktop ist nur unter Windows integriert.
no-free-port = Es wurde kein freier lokaler Port gefunden.

## Dialog nach „Tailnet hinzufügen“

sign-in-dialog-title = Beim neuen Tailnet anmelden
sign-in-dialog-text =
    Ihr Browser öffnet die Anmeldeseite von Tailscale. Sie kann sich hinter diesem Fenster öffnen.
    
    Melden Sie sich mit Ihrem Konto für dieses Tailnet an und kehren Sie dann hierher zurück. Seine Domain wird automatisch erkannt.

## Status eines Tailnets, als farbige Beschriftung neben seinem Namen

state-waiting-sign-in = Wartet auf Anmeldung
state-signed-out = Abgemeldet
state-problem = Problem
state-connecting = Verbindet
state-paused = Pausiert
state-no-domain = Noch keine Domain
state-not-routing = Routing inaktiv
state-routing = Routing aktiv

## Gesamtstatus der App, in der Statuskarte und im Infobereich-Menü

summary-no-tailnets = Noch keine Tailnets
summary-paused = Pausiert
# $tailnet ist der Name des einzigen Tailnets.
summary-routing-one = Routing über { $tailnet }
# Alle Tailnets leiten weiter; $count ist mindestens 2.
summary-routing-all =
    { $count ->
        [one] Routing über { $count } Tailnet
       *[other] Routing über { $count } Tailnets
    }
summary-routing-some =
    { $count ->
        [one] Routing über { $routing } von { $count } Tailnet
       *[other] Routing über { $routing } von { $count } Tailnets
    }
summary-signed-out = Nicht angemeldet
summary-problem = Problem: { $problem }
summary-connecting = Verbindung wird hergestellt…
# Ein Tailnet vor der ersten Anmeldung, wenn es noch keinen Namen hat.
new-tailnet = Neues Tailnet

## Statuskarte oben im Tab „Tailnets“

hero-starting = Wird gestartet…
hero-connecting = Verbindung zu Ihren Tailnets wird hergestellt.
hero-paused = Zurzeit läuft nichts über andere Tailnets. Ihr eigenes Netzwerk und Tailnet funktionieren wie gewohnt.
hero-finish-sign-in = Schließen Sie die Anmeldung bei { $tailnet } in Ihrem Browser ab.
hero-sign-in = Melden Sie sich bei { $tailnet } an, um seine Geräte zu erreichen.
# $address ist der Name eines Geräts, z. B. build-pc.example.ts.net.
hero-routing-example = Öffnen Sie { $address } oder eine andere Adresse in diesen Tailnets. Alles andere geht direkt.
hero-routing = Adressen in diesen Tailnets öffnen sich in Ihrem Browser. Alles andere geht direkt.
add-tailnet = Tailnet hinzufügen
pause-all = Alle pausieren
pause-all-tooltip = Routing über andere Tailnets vorerst anhalten
resume = Fortsetzen
resume-tooltip = Routing über andere Tailnets wieder aufnehmen

## Erster Start, bevor ein Tailnet hinzugefügt wurde

welcome-title = Geräte in anderen Tailnets erreichen
welcome-text = Bleiben Sie in Ihrem eigenen Tailnet und öffnen Sie gleichzeitig Geräte in anderen. Ihre Tailscale-App funktioniert weiter wie gewohnt.
welcome-sign-in = Bei einem anderen Tailnet anmelden
welcome-sign-in-detail = Die Anmeldeseite von Tailscale öffnet sich in Ihrem Browser.
welcome-open = Seine Geräte per Name öffnen
# $example ist eine Beispieladresse, build-pc.example.ts.net.
welcome-open-detail = Adressen wie { $example } funktionieren in Ihrem Browser.
welcome-forward = Einen Port weiterleiten, wenn eine App einen braucht
welcome-forward-detail = Remotedesktop, SSH und Datenbank-Apps erhalten einen lokalen Port, der zu einem Gerät führt.

## Karte eines Tailnets

machine-search-hint = Gerät nach Name, Betriebssystem oder Adresse suchen
clear-search = Suche löschen
more-actions = Weitere Aktionen
edit-tailnet-menu = Umbenennen oder Domains hinzufügen…
log-out-menu = Abmelden…
remove-menu = Entfernen…
sign-in = Anmelden
pause-tailnet = Dieses Tailnet pausieren
resume-tailnet = Dieses Tailnet fortsetzen
detail-tailnet = Tailnet
detail-routes = Routen
detail-this-computer = Dieser Computer
detail-problem = Problem
routes-after-sign-in = Werden nach der Anmeldung ermittelt
# $hostname ist der Name dieses Computers im Tailnet.
hostname-after-sign-in = { $hostname } (nach der Anmeldung)
sign-in-help = Browser nicht geöffnet oder falsches Profil?
sign-in-open-again = Anmeldeseite erneut öffnen
sign-in-copy-link = Link kopieren
sign-in-copy-link-tooltip = Fügen Sie ihn in den Browser oder das Browserprofil ein, das Sie für dieses Tailnet verwenden

## Geräteliste in der Karte eines Tailnets

machines-online = Geräte · { $online } von { $total } online
machines-matching = Geräte · { $shown } von { $total } passen
no-machines = In diesem Tailnet sind keine anderen Geräte sichtbar.
no-machine-matches = Kein Gerät passt zu Ihrer Suche.
machine-offline = { $name } (offline)
forward-port-tooltip = Port weiterleiten: für Apps, die die Proxy-Einstellung ignorieren, wie Remotedesktop oder ein Datenbankclient
copy-address = { $address } kopieren
open-in-browser = { $url } im Browser öffnen
not-routing-tooltip = Dieses Tailnet leitet gerade nicht weiter. Ist es pausiert?

## Websites auf den Geräten

sites-heading = Websites
sites-help = Geräte in Ihren Tailnets, die eine Website über HTTPS bereitstellen. Jedes Gerät wird höchstens einmal am Tag geprüft.
# $done und $total zählen Geräte.
sites-checking = Gerät { $done } von { $total } wird geprüft…
sites-recheck-tooltip = Alle Geräte jetzt erneut prüfen
site-untrusted = Das Zertifikat ist nicht vertrauenswürdig, daher zeigt Ihr Browser eine Warnung an.
site-favorite-add = Zu Favoriten hinzufügen
site-favorite-remove = Aus Favoriten entfernen
sites-show-all = Alle Websites anzeigen ({ $count })
sites-show-fewer = Weniger anzeigen

## Einstellungen: Portweiterleitungen

forwards-heading = Portweiterleitungen
forwards-help = Für Apps, die die Proxy-Einstellung ignorieren, wie Remotedesktop, SSH und Datenbankclients. Jede Weiterleitung ist ein Port auf diesem Computer, der zu einem Gerät in einem Tailnet führt.
edit-forwards = Weiterleitungen bearbeiten
# LOCALPORT, auto und host:port bleiben unverändert: Das ist die Eingabe.
forwards-format-help = Eine pro Zeile: LOCALPORT = host:port, oder auto = host:port, um einen freien Port wählen zu lassen. Der Hostname bestimmt, welches Tailnet sie trägt. Schneller geht es mit dem Stecker-Symbol neben einem Gerät im Tab „Tailnets“.
forward-cant-listen = Lauschen nicht möglich: { $error }
forward-port-on-save = Beim Speichern wird ein Port gewählt
forward-no-tailnet = Kein aktives Tailnet hat diesen Namen
# $tailnet ist das Tailnet, das die Weiterleitung trägt.
forward-via = über { $tailnet }
open-remote-desktop-to = Remotedesktop zu { $address } öffnen

## Einstellungen: System-Proxy

proxy-heading = System-Proxy-Einstellung
proxy-on = Ein (empfohlen)
proxy-force = Ein, und ein Proxy-Skript Ihres Unternehmens während der Ausführung ersetzen
proxy-off = Aus: Ich richte meine Apps selbst ein
proxy-help-windows = „Ein“ richtet Windows nur auf die Regeln dieser App aus, solange sie läuft und weiterleitet, und stellt alles wieder her, wenn sie beendet, pausiert, getrennt wird oder abstürzt.
proxy-help-macos = „Ein“ setzt den Proxy für Ihre Netzwerkdienste, solange die App läuft, und stellt ihn danach wieder her. Wenn Ihr Mac dafür ein Administratorpasswort verlangt, werden Sie beim Start des Routings und beim Beenden danach gefragt.
proxy-help-linux = „Ein“ setzt die Proxy-Einstellung von GNOME oder KDE, solange die App läuft und weiterleitet, und stellt sie danach wieder her. Aktivieren Sie in Firefox Einstellungen > Netzwerk-Einstellungen > „Proxy-Einstellungen des Systems verwenden“.

## Einstellungen: Allgemein

general-heading = Allgemein
start-at-login = { -app-name } bei der Anmeldung starten
language = Sprache
system-default = Systemsprache

## Einstellungen: Fehlerbehebung

troubleshooting-heading = Fehlerbehebung
troubleshooting-help = Testen Sie eine Webadresse oder Name:Port, um zu sehen, welches Tailnet sie trägt und ob eine Verbindung zustande kommt.
test = Testen
testing = Wird getestet…
open-log = Protokoll öffnen
open-settings-folder = Einstellungsordner öffnen
about-line = { -app-name } { $version } · lokaler Proxy { $proxy } · PAC { $pac }
settings-location = Einstellungen in { $path }

## Einstellungen: Namen

names-heading = Namen
names-help = Eigene Namen für Adressen in Ihren Tailnets, etwa für einen Server hinter einem Subnetz-Router. Sie funktionieren nur in Browsern und Portweiterleitungen auf diesem Computer.
edit-names = Namen bearbeiten
# „name = address“ und das Beispiel bleiben unverändert: Das ist die Eingabe.
names-format-help = Einer pro Zeile: name = address, zum Beispiel wiki = 192.168.20.15. Die Adresse kann eine IP-Adresse oder der Name eines Geräts sein. Öffnen Sie ihn als http://wiki:8080/, mit dem Port, den die Website verwendet.

## Ergebnisse von „Testen“ in der Fehlerbehebung

check-empty = Geben Sie einen Gerätenamen oder eine Webadresse ein.
check-bad-port = { $input }: Das ist kein gültiger Port.
check-not-routed = { $host } wird nicht von { -app-name } weitergeleitet: Es ist weder Name noch Adresse noch Subnetz eines gerade aktiven Tailnets und geht daher direkt (über Ihr normales Netzwerk und Ihr eigenes Tailscale).
# $tailnets listet die Tailnets auf, durch Kommas getrennt.
check-ambiguous = { $host } liegt in mehr als einem Tailnet ({ $tailnets }) und wird daher nicht weitergeleitet. Verwenden Sie stattdessen den Namen des Geräts, oder schalten Sie die Subnetze für eines dieser Tailnets aus.
check-gone = Dieses Tailnet ist gerade verschwunden.
check-not-running = { $tailnet } läuft nicht.
check-ok = { $address } funktioniert: verbunden über { $tailnet } in { $ms } ms.
check-failed =
    { $host } wird über { $tailnet } geleitet, aber die Verbindung zu Port { $port } ist fehlgeschlagen: { $error }
    Prüfen Sie, ob das Gerät online ist und etwas auf diesem Port lauscht.
check-timeout = { $host } wird über { $tailnet } geleitet, aber Port { $port } hat nicht innerhalb von 10 Sekunden geantwortet.
# Zwei Tailnets beanspruchen dieselbe Domain; $tailnet ist das, dessen Routen verwendet werden.
domain-conflict = { $domain } wird auch von { $tailnet } geleitet; dieses hat Vorrang.

## Fehler in eingegebenen Einstellungen

forwards-line-format = Zeile { $line }: Schreiben Sie LOCALPORT = host:port.
forwards-line-port = Zeile { $line }: „{ $value }“ ist keine Portnummer (oder auto).
forwards-line-target = Zeile { $line }: „{ $value }“ sollte host:port sein.
forwards-line-duplicate = Zeile { $line }: Lokaler Port { $port } wird doppelt verwendet.
domain-invalid = „{ $domain }“ ist keine Domain; verwenden Sie etwa example.ts.net.
domain-characters = „{ $domain }“ enthält Zeichen, die in einer Domain nicht erlaubt sind.
names-line-format = Zeile { $line }: Schreiben Sie name = address.
names-line-name = Zeile { $line }: „{ $value }“ kann kein Name sein. Verwenden Sie Buchstaben, Ziffern, Bindestriche und Punkte.
names-line-target = Zeile { $line }: „{ $value }“ ist weder eine IP-Adresse noch der Name eines Geräts.
names-line-duplicate = Zeile { $line }: Der Name { $value } kommt doppelt vor.
autostart-unsupported = Der Start bei der Anmeldung wird auf diesem System nicht unterstützt.

## Dialoge

ok = OK
cancel = Abbrechen
done = Fertig
copy = Kopieren
error-title = Etwas ist schiefgelaufen
error-details = Details in { $path }
# $tailnet ist der Name des Tailnets.
edit-title = { $tailnet } bearbeiten
tailnet-name = Name
tailnet-name-hint = Wird in dieser App und im Infobereich-Menü angezeigt
extra-domains = Zusätzliche Domains (optional)
extra-domains-help = Die eigene Domain des Tailnets wird automatisch weitergeleitet. Eine pro Zeile hinzufügen.
route-subnets = Seine Subnetze weiterleiten
route-subnets-help = Netzwerke, die dieses Tailnet über seine Subnetz-Router erreicht, etwa ein Cloud-Netzwerk. Schalten Sie dies aus, wenn sich eines davon mit einem Netzwerk überschneidet, in dem dieser Computer ist.
forward-dialog-title = Port weiterleiten
forward-dialog-text = Erhalten Sie einen Port auf diesem Computer, der zu { $host } führt. Welcher Port auf diesem Gerät?
port-preset-remote-desktop = Remotedesktop
port-tooltip = Port { $port }
port = Port
port-hint = z. B. 8080
add-forward = Weiterleitung hinzufügen
not-a-port = „{ $value }“ ist keine Portnummer (1-65535).
forward-ready-title = Portweiterleitung bereit
forward-ready-text = Richten Sie Ihre App auf diese Adresse aus, um { $target } zu erreichen:
forward-ready-note = Der Port bleibt gleich. Sie finden ihn in den Einstellungen.
open-remote-desktop = Remotedesktop öffnen
remove-title = Dieses Tailnet entfernen?
remove-text = { -app-name } meldet sich von { $tailnet } ab und vergisst es auf diesem Computer. Sie können es später wieder hinzufügen.
remove = Entfernen
log-out-title = Abmelden?
log-out-text = Von { $tailnet } abmelden? Seine Adressen funktionieren hier erst wieder, wenn Sie sich erneut anmelden.
log-out = Abmelden

## Menü im Infobereich (Windows, Linux) oder in der Menüleiste (macOS)

tray-sign-in = { $tailnet }: anmelden…
# $state ist eine der state-*-Beschriftungen oben.
tray-tailnet = { $tailnet }: { $state }
tray-add-tailnet = Tailnet hinzufügen…
tray-route = Über andere Tailnets leiten
tray-open = { -app-name } öffnen…
tray-quit = Beenden
tray-tooltip = { -app-name }: { $summary }

## Benachrichtigung beim ersten Schließen des Fensters

still-running-title = { -app-name } läuft weiter
still-running-windows = Das Routing läuft im Hintergrund weiter. Sie finden die App im Infobereich; Windows blendet sie eventuell hinter dem Pfeil ^ neben der Uhr aus.
still-running-macos = Das Routing läuft im Hintergrund weiter. Sie finden die App in der Menüleiste.
still-running-linux = Das Routing läuft im Hintergrund weiter. Sie finden die App im Infobereich.

## Sprachnamen in den Einstellungen, nach dem Eigennamen jeder Sprache

english = Englisch
french = Französisch
german = Deutsch
spanish-latin-america = Lateinamerikanisches Spanisch
spanish-spain = Spanisch aus Spanien
chinese-simplified = Vereinfachtes Chinesisch
chinese-traditional = Traditionelles Chinesisch
korean = Koreanisch
japanese = Japanisch
polish = Polnisch
russian = Russisch
portuguese-brazil = Brasilianisches Portugiesisch
italian = Italienisch
turkish = Türkisch
ukrainian = Ukrainisch
czech = Tschechisch
portuguese-portugal = Europäisches Portugiesisch
dutch = Niederländisch
indonesian = Indonesisch
vietnamese = Vietnamesisch
thai = Thailändisch
swedish = Schwedisch
romanian = Rumänisch
hungarian = Ungarisch
afrikaans = Afrikaans
catalan = Katalanisch
serbian-cyrillic = Serbisch, Kyrillisch
danish = Dänisch
finnish = Finnisch
greek = Griechisch
norwegian-bokmal = Norwegisch Bokmål
summary-proxy-problem = Verbunden, aber Ihre Apps nutzen die Verbindung nicht
hero-proxy-taken = Ihr Browser öffnet die Adressen dieser Tailnets nicht: Die System-Proxy-Einstellung verwendet ein anderes Setupskript ({ $script }).
hero-proxy-other-copy = Ihr Browser öffnet die Adressen dieser Tailnets nicht: Eine andere Instanz von { -app-name } belegt die System-Proxy-Einstellung. Beenden Sie die andere Instanz, dann übernimmt diese.
hero-proxy-changed = Ihr Browser öffnet die Adressen dieser Tailnets nicht: Etwas anderes hat die System-Proxy-Einstellung geändert.
hero-proxy-failed = Ihr Browser öffnet die Adressen dieser Tailnets nicht: Die System-Proxy-Einstellung konnte nicht geändert werden ({ $error }).
hero-proxy-manual = Die System-Proxy-Einstellung ist aus, daher erreichen nur Apps, die Sie selbst einrichten, diese Tailnets. Tragen Sie dort diese Adresse ein: { $pac }
proxy-replace = Ersetzen
proxy-replace-tooltip = Das Setupskript von { -app-name } verwenden, solange es läuft, und das andere danach wiederherstellen
proxy-retry = Erneut versuchen
proxy-retry-tooltip = Die System-Proxy-Einstellung wieder auf { -app-name } richten
system-setting = Aktuelle System-Proxy-Einstellung: { $value }
system-setting-none = keine
check-updates = Nach neuen Versionen suchen
find-websites = Auf den Geräten in Ihren Tailnets nach Websites suchen
# $version is the version that's running, such as 0.6.0.
version-current = Version { $version }
update-check-now = Jetzt suchen
update-checking = Wird gesucht…
update-up-to-date = Sie haben die neueste Version
update-check-failed = Suche nach Updates fehlgeschlagen
tray-update = { -app-name } { $version } herunterladen…
update-available = Version { $version } ist da
update-available-tooltip = Sie haben { $current }. Öffnet die Downloadseite.
update-notify-title = { -app-name } { $version } ist verfügbar
update-notify-text = Öffnen Sie { -app-name }, um es herunterzuladen.
migrate-failed = Ihre Anmeldungen aus tailnet-proxy, der früheren Version dieser App, konnten nicht übernommen werden ({ $error }). Wahrscheinlich läuft tailnet-proxy noch. Beenden Sie tailnet-proxy und starten Sie { -app-name } dann neu, bevor Sie sich hier anmelden: Eine erneute Anmeldung würde diesen Computer jedem Tailnet ein zweites Mal hinzufügen.
