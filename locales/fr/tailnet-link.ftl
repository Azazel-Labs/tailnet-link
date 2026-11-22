### Tailnet Link : catalogue français.
### Gardez les noms Tailnet Link et Tailscale, ainsi que le mot « tailnet » (un réseau Tailscale).

-app-name = Tailnet Link

## En-tête de la fenêtre

tab-tailnets = Tailnets
tab-settings = Paramètres

## Barre des modifications non enregistrées, en bas des Paramètres

unsaved-changes = Vous avez des modifications non enregistrées.
save = Enregistrer
revert = Rétablir
revert-tooltip = Annuler les modifications
settings-saved = Paramètres enregistrés

## Courtes notes en bas de la fenêtre

# $address est un nom de machine ou 127.0.0.1:port.
copied-address = { $address } copié
copied-sign-in-link = Lien de connexion copié

## Erreurs affichées dans la boîte « Un problème est survenu »

start-failed =
    { -app-name } ne peut pas démarrer :
    { $error }
add-tailnet-failed =
    Impossible d’ajouter un tailnet :
    { $error }
add-forward-failed =
    Impossible d’ajouter la redirection de port :
    { $error }
remote-desktop-failed = Impossible de lancer Bureau à distance : { $error }
remote-desktop-windows-only = Bureau à distance n’est intégré qu’à Windows.
no-free-port = Aucun port local libre n’a été trouvé.

## Boîte de dialogue après « Ajouter un tailnet »

sign-in-dialog-title = Connectez-vous au nouveau tailnet
sign-in-dialog-text =
    Votre navigateur ouvre la page de connexion de Tailscale. Elle peut s’ouvrir derrière cette fenêtre.
    
    Connectez-vous avec votre compte pour ce tailnet, puis revenez ici. Son domaine est détecté automatiquement.

## État d’un tailnet, affiché en couleur à côté de son nom

state-waiting-sign-in = En attente de connexion
state-signed-out = Déconnecté
state-problem = Problème
state-connecting = Connexion en cours
state-paused = En pause
state-no-domain = Pas encore de domaine
state-not-routing = Routage inactif
state-routing = Routage actif

## État global de l’application, dans la carte d’état et le menu de la zone de notification

summary-no-tailnets = Aucun tailnet pour l’instant
summary-paused = En pause
# $tailnet est le nom du seul tailnet.
summary-routing-one = Routage via { $tailnet }
# Tous les tailnets routent ; $count vaut au moins 2.
summary-routing-all =
    { $count ->
        [one] Routage via { $count } tailnet
       *[other] Routage via { $count } tailnets
    }
summary-routing-some =
    { $count ->
        [one] Routage via { $routing } tailnet sur { $count }
       *[other] Routage via { $routing } tailnets sur { $count }
    }
summary-signed-out = Non connecté
summary-problem = Problème : { $problem }
summary-connecting = Connexion…
# Un tailnet avant sa première connexion, quand il n’a pas encore de nom.
new-tailnet = Nouveau tailnet

## Carte d’état en haut de l’onglet Tailnets

hero-starting = Démarrage…
hero-connecting = Connexion à vos tailnets.
hero-paused = Rien ne passe par les autres tailnets pour le moment. Votre réseau et votre propre tailnet fonctionnent normalement.
hero-finish-sign-in = Terminez la connexion à { $tailnet } dans votre navigateur.
hero-sign-in = Connectez-vous à { $tailnet } pour accéder à ses machines.
# $address est le nom d’une machine, par exemple build-pc.example.ts.net.
hero-routing-example = Ouvrez { $address } ou toute autre adresse de ces tailnets. Tout le reste passe en direct.
hero-routing = Les adresses de ces tailnets s’ouvrent dans votre navigateur. Tout le reste passe en direct.
add-tailnet = Ajouter un tailnet
pause-all = Tout mettre en pause
pause-all-tooltip = Arrêter pour l’instant le routage via les autres tailnets
resume = Reprendre
resume-tooltip = Reprendre le routage via les autres tailnets

## Premier lancement, avant l’ajout d’un tailnet

welcome-title = Accédez aux machines d’autres tailnets
welcome-text = Restez sur votre propre tailnet tout en ouvrant les machines des autres. Votre application Tailscale continue de fonctionner normalement.
welcome-sign-in = Connectez-vous à un autre tailnet
welcome-sign-in-detail = La page de connexion de Tailscale s’ouvre dans votre navigateur.
welcome-open = Ouvrez ses machines par leur nom
# $example est une adresse d’exemple, build-pc.example.ts.net.
welcome-open-detail = Les adresses comme { $example } fonctionnent dans votre navigateur.
welcome-forward = Redirigez un port quand une application en a besoin
welcome-forward-detail = Bureau à distance, SSH et les clients de bases de données obtiennent un port local qui mène à une machine.

## Carte d’un tailnet

machine-search-hint = Chercher une machine par nom, OS ou adresse
clear-search = Effacer la recherche
more-actions = Plus d’actions
edit-tailnet-menu = Renommer ou ajouter des domaines…
log-out-menu = Se déconnecter…
remove-menu = Supprimer…
sign-in = Se connecter
pause-tailnet = Mettre ce tailnet en pause
resume-tailnet = Reprendre ce tailnet
detail-tailnet = Tailnet
detail-routes = Routes
detail-this-computer = Cet ordinateur
detail-problem = Problème
routes-after-sign-in = Détectées après la connexion
# $hostname est le nom de cet ordinateur dans le tailnet.
hostname-after-sign-in = { $hostname } (après la connexion)
sign-in-help = Le navigateur ne s’est pas ouvert, ou avec le mauvais profil ?
sign-in-open-again = Rouvrir la page de connexion
sign-in-copy-link = Copier le lien
sign-in-copy-link-tooltip = Collez-le dans le navigateur, ou le profil de navigateur, que vous utilisez pour ce tailnet

## Liste des machines dans la carte d’un tailnet

machines-online = Machines · { $online } sur { $total } en ligne
machines-matching = Machines · { $shown } sur { $total } correspondent
no-machines = Aucune autre machine n’est visible dans ce tailnet.
no-machine-matches = Aucune machine ne correspond à votre recherche.
machine-offline = { $name } (hors ligne)
forward-port-tooltip = Rediriger un port : pour les applications qui ignorent le paramètre de proxy, comme Bureau à distance ou un client de base de données
copy-address = Copier { $address }
open-in-browser = Ouvrir { $url } dans votre navigateur
not-routing-tooltip = Ce tailnet ne route pas en ce moment. Est-il en pause ?

## Paramètres : redirections de port

forwards-heading = Redirections de port
forwards-help = Pour les applications qui ignorent le paramètre de proxy, comme Bureau à distance, SSH et les clients de bases de données. Chaque redirection est un port de cet ordinateur qui mène à une machine d’un tailnet.
edit-forwards = Modifier les redirections
# Gardez LOCALPORT, auto et host:port tels quels : c’est ce que l’on tape.
forwards-format-help = Une par ligne : LOCALPORT = host:port, ou auto = host:port pour obtenir un port libre. Le nom de l’hôte détermine le tailnet utilisé. Pour en ajouter une rapidement, utilisez le bouton en forme de prise à côté d’une machine dans l’onglet Tailnets.
forward-cant-listen = Écoute impossible : { $error }
forward-port-on-save = Un port est choisi à l’enregistrement
forward-no-tailnet = Aucun tailnet actif ne porte ce nom
# $tailnet est le tailnet qui transporte la redirection.
forward-via = via { $tailnet }
open-remote-desktop-to = Ouvrir Bureau à distance vers { $address }

## Paramètres : proxy système

proxy-heading = Paramètre de proxy système
proxy-on = Activé (recommandé)
proxy-force = Activé, et remplacer le script de proxy de votre entreprise pendant l’exécution
proxy-off = Désactivé : je configure mes applications moi-même
proxy-help-windows = « Activé » applique les règles de cette application à Windows uniquement pendant qu’elle tourne et route, puis rétablit tout quand elle s’arrête, se met en pause, se déconnecte ou plante.
proxy-help-macos = « Activé » définit le proxy de vos services réseau pendant que l’application tourne, puis le rétablit ensuite. Si votre Mac exige un mot de passe administrateur pour cela, il vous sera demandé au démarrage du routage et à la fermeture.
proxy-help-linux = « Activé » définit le proxy de GNOME ou KDE pendant que l’application tourne et route, puis le rétablit ensuite. Dans Firefox, activez Paramètres > Paramètres réseau > « Utiliser les paramètres proxy du système ».

## Paramètres : général

general-heading = Général
start-at-login = Lancer { -app-name } à l’ouverture de session
language = Langue
system-default = Langue du système

## Paramètres : dépannage

troubleshooting-heading = Dépannage
troubleshooting-help = Testez une adresse web ou un nom:port pour voir quel tailnet le transporte et si la connexion aboutit.
test = Tester
testing = Test en cours…
open-log = Ouvrir le journal
open-settings-folder = Ouvrir le dossier des paramètres
about-line = { -app-name } { $version } · proxy local { $proxy } · PAC { $pac }
settings-location = Paramètres dans { $path }

## Résultats de « Tester » dans Dépannage

check-empty = Saisissez un nom de machine ou une adresse web.
check-bad-port = { $input } : ce n’est pas un port valide.
check-not-routed = { $host } n’est pas routé par { -app-name } : il ne se termine par le domaine d’aucun tailnet actif en ce moment, il passe donc en direct (par votre réseau habituel et votre propre Tailscale).
check-gone = Ce tailnet vient de disparaître.
check-not-running = { $tailnet } n’est pas en cours d’exécution.
check-ok = { $address } fonctionne : connecté via { $tailnet } en { $ms } ms.
check-failed =
    { $host } est routé via { $tailnet }, mais la connexion au port { $port } a échoué : { $error }
    Vérifiez que la machine est en ligne et qu’un service écoute sur ce port.
check-timeout = { $host } est routé via { $tailnet }, mais le port { $port } n’a pas répondu dans les 10 secondes.
# Deux tailnets revendiquent le même domaine ; $tailnet est celui dont les routes sont utilisées.
domain-conflict = { $domain } est aussi routé par { $tailnet } ; c’est celui-ci qui l’emporte.

## Erreurs dans les paramètres saisis

forwards-line-format = Ligne { $line } : écrivez LOCALPORT = host:port.
forwards-line-port = Ligne { $line } : « { $value } » n’est pas un numéro de port (ni auto).
forwards-line-target = Ligne { $line } : « { $value } » doit être de la forme host:port.
forwards-line-duplicate = Ligne { $line } : le port local { $port } est utilisé deux fois.
domain-invalid = « { $domain } » n’est pas un domaine ; utilisez par exemple example.ts.net.
domain-characters = « { $domain } » contient des caractères interdits dans un domaine.
autostart-unsupported = Le lancement à l’ouverture de session n’est pas pris en charge sur ce système.

## Boîtes de dialogue

ok = OK
cancel = Annuler
done = Terminé
copy = Copier
error-title = Un problème est survenu
error-details = Détails dans { $path }
# $tailnet est le nom du tailnet.
edit-title = Modifier { $tailnet }
tailnet-name = Nom
tailnet-name-hint = Affiché dans cette application et dans le menu de la zone de notification
extra-domains = Domaines supplémentaires (facultatif)
extra-domains-help = Le domaine propre du tailnet est routé automatiquement. Ajoutez-en un par ligne.
forward-dialog-title = Rediriger un port
forward-dialog-text = Obtenez un port sur cet ordinateur qui mène à { $host }. Quel port sur cette machine ?
port-preset-remote-desktop = Bureau à distance
port-tooltip = Port { $port }
port = Port
port-hint = ex. 8080
add-forward = Ajouter la redirection
not-a-port = « { $value } » n’est pas un numéro de port (1-65535).
forward-ready-title = Redirection de port prête
forward-ready-text = Indiquez cette adresse à votre application pour atteindre { $target } :
forward-ready-note = Le port reste le même. Vous le retrouverez dans les Paramètres.
open-remote-desktop = Ouvrir Bureau à distance
remove-title = Supprimer ce tailnet ?
remove-text = { -app-name } se déconnecte de { $tailnet } et l’oublie sur cet ordinateur. Vous pourrez le rajouter plus tard.
remove = Supprimer
log-out-title = Se déconnecter ?
log-out-text = Se déconnecter de { $tailnet } ? Ses adresses ne fonctionneront plus ici tant que vous ne vous reconnectez pas.
log-out = Se déconnecter

## Menu de la zone de notification (Windows, Linux) ou de la barre des menus (macOS)

tray-sign-in = { $tailnet } : se connecter…
# $state est l’un des libellés state-* ci-dessus.
tray-tailnet = { $tailnet } : { $state }
tray-add-tailnet = Ajouter un tailnet…
tray-route = Router via les autres tailnets
tray-open = Ouvrir { -app-name }…
tray-quit = Quitter
tray-tooltip = { -app-name } : { $summary }

## Notification à la première fermeture de la fenêtre

still-running-title = { -app-name } fonctionne toujours
still-running-windows = Le routage continue en arrière-plan. Retrouvez l’application dans la zone de notification ; Windows peut la cacher sous la flèche ^ près de l’horloge.
still-running-macos = Le routage continue en arrière-plan. Retrouvez l’application dans la barre des menus.
still-running-linux = Le routage continue en arrière-plan. Retrouvez l’application dans la zone de notification.

## Noms des langues dans les Paramètres, après le nom de chaque langue dans sa propre langue

english = Anglais
french = Français
german = Allemand
spanish-latin-america = Espagnol latino-américain
spanish-spain = Espagnol d’Espagne
chinese-simplified = Chinois simplifié
chinese-traditional = Chinois traditionnel
korean = Coréen
japanese = Japonais
polish = Polonais
russian = Russe
portuguese-brazil = Portugais du Brésil
italian = Italien
turkish = Turc
ukrainian = Ukrainien
czech = Tchèque
portuguese-portugal = Portugais du Portugal
dutch = Néerlandais
indonesian = Indonésien
vietnamese = Vietnamien
thai = Thaï
swedish = Suédois
romanian = Roumain
hungarian = Hongrois
afrikaans = Afrikaans
catalan = Catalan
serbian-cyrillic = Serbe, cyrillique
danish = Danois
finnish = Finnois
greek = Grec
norwegian-bokmal = Norvégien bokmål
summary-proxy-problem = Connecté, mais vos applications ne l’utilisent pas
hero-proxy-taken = Votre navigateur n’ouvrira pas les adresses de ces tailnets : le paramètre de proxy système utilise un autre script de configuration ({ $script }).
hero-proxy-other-copy = Votre navigateur n’ouvrira pas les adresses de ces tailnets : une autre copie de { -app-name } détient le paramètre de proxy système. Quittez cette copie, et celle-ci prendra le relais.
hero-proxy-changed = Votre navigateur n’ouvrira pas les adresses de ces tailnets : autre chose a modifié le paramètre de proxy système.
hero-proxy-failed = Votre navigateur n’ouvrira pas les adresses de ces tailnets : impossible de modifier le paramètre de proxy système ({ $error }).
hero-proxy-manual = Le paramètre de proxy système est désactivé, donc seules les applications que vous configurez vous-même accèdent à ces tailnets. Indiquez-leur cette adresse : { $pac }
proxy-replace = Le remplacer
proxy-replace-tooltip = Utiliser le script de configuration de { -app-name } pendant son exécution, puis remettre l’autre ensuite
proxy-retry = Réessayer
proxy-retry-tooltip = Faire de nouveau pointer le paramètre de proxy système vers { -app-name }
system-setting = Paramètre de proxy système actuel : { $value }
system-setting-none = aucun
check-updates = Rechercher de nouvelles versions
tray-update = Télécharger { -app-name } { $version }…
update-available = Version { $version } disponible
update-available-tooltip = Vous avez la version { $current }. Ouvre la page de téléchargement.
update-notify-title = { -app-name } { $version } est disponible
update-notify-text = Ouvrez { -app-name } pour le télécharger.
migrate-failed = Vos connexions de tailnet-proxy, l’ancienne version de cette application, n’ont pas pu être transférées ({ $error }). Il est probablement encore en cours d’exécution. Quittez tailnet-proxy, puis redémarrez { -app-name } avant de vous connecter ici : se connecter à nouveau ajouterait cet ordinateur une seconde fois à chaque tailnet.
