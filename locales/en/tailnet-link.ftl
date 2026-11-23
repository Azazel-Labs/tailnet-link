### Tailnet Link: English source catalog.
### Translations live in locales/<language>/tailnet-link.ftl; see docs/translations.md.
### Keep the product names Tailnet Link and Tailscale, and the word "tailnet"
### (a Tailscale network) as Tailscale's own translation of your language does.

-app-name = Tailnet Link

## Window header

tab-tailnets = Tailnets
tab-settings = Settings

## Unsaved-changes bar at the bottom of Settings

unsaved-changes = You have unsaved changes.
save = Save
revert = Revert
revert-tooltip = Undo the changes
settings-saved = Settings saved

## Short notes at the bottom of the window

# $address is a machine name or 127.0.0.1:port.
copied-address = Copied { $address }
copied-sign-in-link = Copied the sign-in link

## Errors shown in the "Something went wrong" dialog

start-failed =
    { -app-name } can't start:
    { $error }
add-tailnet-failed =
    Couldn't add a tailnet:
    { $error }
add-forward-failed =
    Couldn't add the port forward:
    { $error }
remote-desktop-failed = Couldn't start Remote Desktop: { $error }
remote-desktop-windows-only = Remote Desktop is only built in on Windows.
no-free-port = Couldn't find a free local port.

## Dialog after "Add a tailnet"

sign-in-dialog-title = Sign in to the new tailnet
sign-in-dialog-text =
    Your browser is opening Tailscale's sign-in page. It may open behind this window.
    
    Sign in with your account for that tailnet, then come back here. Its domain is picked up automatically.

## One tailnet's state, shown as a colored label beside its name

state-waiting-sign-in = Waiting for sign-in
state-signed-out = Signed out
state-problem = Problem
state-connecting = Connecting
state-paused = Paused
state-no-domain = No domain yet
state-not-routing = Not routing
state-routing = Routing

## The whole app's state, in the status card and the tray menu

summary-no-tailnets = No tailnets yet
summary-paused = Paused
# $tailnet is the name of the only tailnet.
summary-routing-one = Routing via { $tailnet }
# Every tailnet is routing; $count is at least 2.
summary-routing-all =
    { $count ->
        [one] Routing via { $count } tailnet
       *[other] Routing via { $count } tailnets
    }
summary-routing-some =
    { $count ->
        [one] Routing via { $routing } of { $count } tailnet
       *[other] Routing via { $routing } of { $count } tailnets
    }
summary-signed-out = Not logged in
summary-problem = Problem: { $problem }
summary-connecting = Connecting…
# Signed in and routing, but the system proxy setting doesn't send anything to the app.
summary-proxy-problem = Connected, but your apps aren't using it
# A tailnet before its first sign-in, when it has no name yet.
new-tailnet = New tailnet

## Status card at the top of the Tailnets tab

hero-starting = Starting…
hero-connecting = Connecting to your tailnets.
hero-paused = Nothing goes through other tailnets right now. Your own network and tailnet work as usual.
hero-finish-sign-in = Finish signing in to { $tailnet } in your browser.
hero-sign-in = Sign in to { $tailnet } to reach its machines.
# $address is a machine's name, such as build-pc.example.ts.net.
hero-routing-example = Open { $address } or any other address in these tailnets. Everything else goes direct.
hero-routing = Addresses in these tailnets open in your browser. Everything else goes direct.
# Why browsers don't use the app although it's connected. $script is another program's proxy setup script address.
hero-proxy-taken = Your browser won't open these tailnets' addresses: the system proxy setting uses another setup script ({ $script }).
hero-proxy-other-copy = Your browser won't open these tailnets' addresses: another copy of { -app-name } has the system proxy setting. Quit that copy, and this one takes over.
hero-proxy-changed = Your browser won't open these tailnets' addresses: something else changed the system proxy setting.
# $error is a system error message.
hero-proxy-failed = Your browser won't open these tailnets' addresses: the system proxy setting couldn't be changed ({ $error }).
# The user turned the system proxy setting off in Settings. $pac is a web address.
hero-proxy-manual = The system proxy setting is off, so only apps you set up yourself reach these tailnets. Point them at { $pac }
proxy-replace = Replace it
proxy-replace-tooltip = Use { -app-name }'s setup script while it runs, and put the other one back afterwards
proxy-retry = Try again
proxy-retry-tooltip = Point the system proxy setting at { -app-name } again
add-tailnet = Add a tailnet
pause-all = Pause all
pause-all-tooltip = Stop routing through other tailnets for now
resume = Resume
resume-tooltip = Start routing through other tailnets again

## First run, before any tailnet is added

welcome-title = Reach machines on other tailnets
welcome-text = Stay on your own tailnet and open machines in others at the same time. Your Tailscale app keeps working as usual.
welcome-sign-in = Sign in to another tailnet
welcome-sign-in-detail = Tailscale's sign-in page opens in your browser.
welcome-open = Open its machines by name
# $example is a sample address, build-pc.example.ts.net.
welcome-open-detail = Addresses like { $example } work in your browser.
welcome-forward = Forward a port when an app needs one
welcome-forward-detail = Remote Desktop, SSH and database apps get a local port that leads to a machine.

## A tailnet's card

machine-search-hint = Find a machine by name, OS or address
clear-search = Clear the search
open-terminal-tooltip = Open a terminal where your tailnets' names work, for curl, git, ssh, ping and more. Or put tl in front of any command in any terminal.
open-terminal-missing = { -app-name } can't find tl, its terminal helper, next to the app. Reinstall { -app-name } to get it.
open-terminal-failed = Couldn't open a terminal: { $error }
more-actions = More actions
edit-tailnet-menu = Rename or add domains…
log-out-menu = Log out…
remove-menu = Remove…
sign-in = Sign in
pause-tailnet = Pause this tailnet
resume-tailnet = Resume this tailnet
detail-tailnet = Tailnet
detail-routes = Routes
detail-this-computer = This computer
detail-problem = Problem
routes-after-sign-in = Found after you sign in
# $hostname is this computer's name in the tailnet.
hostname-after-sign-in = { $hostname } (after you sign in)
sign-in-help = Browser didn't open, or opened the wrong profile?
sign-in-open-again = Open the sign-in page again
sign-in-copy-link = Copy the link
sign-in-copy-link-tooltip = Paste it into the browser, or browser profile, you use for this tailnet

## Machine list inside a tailnet's card

machines-online = Machines · { $online } of { $total } online
machines-matching = Machines · { $shown } of { $total } match
no-machines = No other machines are visible in this tailnet.
no-machine-matches = No machine matches your search.
machine-offline = { $name } (offline)
forward-port-tooltip = Forward a port: for apps that ignore the proxy setting, like Remote Desktop or a database client
copy-address = Copy { $address }
open-in-browser = Open { $url } in your browser
not-routing-tooltip = This tailnet isn't routing right now. Is it paused?

## Websites found on the machines

sites-heading = Websites
sites-help = Machines in your tailnets that serve a website over HTTPS. Each machine is checked at most once a day.
# $done and $total count machines.
sites-checking = Checking { $done } of { $total }…
sites-recheck-tooltip = Check every machine again now
site-untrusted = Its certificate isn't trusted, so your browser will warn you.
site-favorite-add = Add to favorites
site-favorite-remove = Remove from favorites
# $count is how many websites there are.
sites-show-all = Show all websites ({ $count })
sites-show-fewer = Show fewer

## Settings: port forwards

forwards-heading = Port forwards
forwards-help = For apps that ignore the proxy setting, like Remote Desktop, SSH and database clients. Each forward is a port on this computer that leads to a machine in a tailnet.
edit-forwards = Edit forwards
# Keep LOCALPORT, auto and host:port as they are: they are what you type.
forwards-format-help = One per line: LOCALPORT = host:port, or auto = host:port to have a free port picked. The host's name decides which tailnet carries it. To add one quickly, use the plug button on a machine in the Tailnets tab.
forward-cant-listen = Can't listen: { $error }
forward-port-on-save = A port is picked when you save
forward-no-tailnet = No routing tailnet has this name
# $tailnet is the tailnet that carries the forward.
forward-via = via { $tailnet }
open-remote-desktop-to = Open Remote Desktop to { $address }

## Settings: system proxy

proxy-heading = System proxy setting
proxy-on = On (recommended)
proxy-force = On, and replace a proxy script set by your company while running
proxy-off = Off: I'll set up my apps myself
proxy-help-windows = "On" points Windows at this app's rules only while it's running and routing, and puts things back when it stops, pauses, disconnects or crashes.
proxy-help-macos = "On" sets the proxy for your network services while the app is running and puts it back afterwards. If your Mac needs an admin password for that, you'll be asked when routing starts and when you quit.
# Settings > Network Settings > "Use system proxy settings" is Firefox's own wording; use Firefox's translation.
proxy-help-linux = "On" sets the GNOME or KDE proxy setting while the app is running and routing, and puts it back afterwards. In Firefox, turn on Settings > Network Settings > "Use system proxy settings".

## Settings: general

general-heading = General
start-at-login = Start { -app-name } when I log in
language = Language
system-default = System default

## Settings: troubleshooting

troubleshooting-heading = Troubleshooting
troubleshooting-help = Test a web address or name:port to see which tailnet carries it and whether it connects.
test = Test
testing = Testing…
open-log = Open log
open-settings-folder = Open settings folder
about-line = { -app-name } { $version } · local proxy { $proxy } · PAC { $pac }
settings-location = Settings in { $path }
# $value is the setup script address the system uses now, or system-setting-none.
system-setting = System proxy setting now: { $value }
system-setting-none = none
check-updates = Check for new versions
find-websites = Look for websites on the machines in your tailnets
# $version is the version that's running, such as 0.6.0.
version-current = Version { $version }
update-check-now = Check now
update-checking = Checking…
update-up-to-date = You have the latest version
update-check-failed = Couldn't check for updates

## Settings: names

names-heading = Names
names-help = Names of your own for addresses in your tailnets, such as a server behind a subnet router. They work in browsers and port forwards on this computer only.
edit-names = Edit names
# Keep "name = address" and the example as they are: they are what you type.
names-format-help = One per line: name = address, for example wiki = 192.168.20.15. The address can be an IP address or a machine's name. Open it as http://wiki:8080/, with the port the website uses.

## Results of "Test" in Troubleshooting

check-empty = Type a machine name or a web address.
check-bad-port = { $input }: that's not a valid port.
check-not-routed = { $host } isn't routed by { -app-name }: it isn't a name, address or subnet of any tailnet that's routing right now, so it goes direct (through your normal network and your own Tailscale).
# $tailnets lists the tailnets, separated by commas.
check-ambiguous = { $host } is in more than one tailnet ({ $tailnets }), so it isn't routed. Use the machine's name instead, or turn off subnets for one of those tailnets.
check-gone = That tailnet just went away.
check-not-running = { $tailnet } isn't running.
ping-no-machine = { $host } goes through { $tailnet }, but it isn't one of its machines, so there's nothing for Tailscale to ping.
check-ok = { $address } works: connected through { $tailnet } in { $ms } ms.
check-failed =
    { $host } is routed through { $tailnet }, but connecting to port { $port } failed: { $error }
    Check the machine is online and something is listening on that port.
check-timeout = { $host } is routed through { $tailnet }, but port { $port } didn't answer within 10 seconds.
# Two tailnets claim the same domain; $tailnet is the one whose routes are used.
domain-conflict = { $domain } is also routed by { $tailnet }; that one wins.

## Mistakes in typed settings

forwards-line-format = Line { $line }: write LOCALPORT = host:port.
forwards-line-port = Line { $line }: “{ $value }” isn't a port number (or auto).
forwards-line-target = Line { $line }: “{ $value }” should be host:port.
forwards-line-duplicate = Line { $line }: local port { $port } is used twice.
domain-invalid = “{ $domain }” isn't a domain; use something like example.ts.net.
domain-characters = “{ $domain }” contains characters a domain can't have.
names-line-format = Line { $line }: write name = address.
names-line-name = Line { $line }: “{ $value }” can't be a name. Use letters, digits, hyphens and dots.
names-line-target = Line { $line }: “{ $value }” isn't an IP address or a machine's name.
names-line-duplicate = Line { $line }: { $value } is named twice.
autostart-unsupported = Starting at login isn't supported on this system.

## Dialogs

ok = OK
cancel = Cancel
done = Done
copy = Copy
error-title = Something went wrong
error-details = Details are in { $path }
# $tailnet is the tailnet's name.
edit-title = Edit { $tailnet }
tailnet-name = Name
tailnet-name-hint = Shown in this app and the tray menu
extra-domains = Extra domains (optional)
extra-domains-help = The tailnet's own domain is routed automatically. Add one per line.
route-subnets = Route its subnets
route-subnets-help = Networks this tailnet reaches through its subnet routers, such as a cloud network. Turn this off if one overlaps a network this computer is on.
forward-dialog-title = Forward a port
forward-dialog-text = Get a port on this computer that leads to { $host }. Which port on that machine?
port-preset-remote-desktop = Remote Desktop
port-tooltip = Port { $port }
port = Port
port-hint = e.g. 8080
add-forward = Add forward
not-a-port = “{ $value }” isn't a port number (1-65535).
forward-ready-title = Port forward ready
forward-ready-text = Point your app at this address to reach { $target }:
forward-ready-note = The port stays the same. You'll find it in Settings.
open-remote-desktop = Open Remote Desktop
remove-title = Remove this tailnet?
remove-text = { -app-name } logs out of { $tailnet } and forgets it on this computer. You can add it again later.
remove = Remove
log-out-title = Log out?
log-out-text = Log out of { $tailnet }? Its addresses stop working here until you sign in again.
log-out = Log out

## Tray (Windows, Linux) or menu bar (macOS) menu

tray-sign-in = { $tailnet }: sign in…
# $state is one of the state-* labels above.
tray-tailnet = { $tailnet }: { $state }
tray-add-tailnet = Add a tailnet…
tray-route = Route through other tailnets
tray-open = Open { -app-name }…
tray-quit = Quit
tray-tooltip = { -app-name }: { $summary }
# $version is a version number such as 0.5.0. Opens the download page.
tray-update = Download { -app-name } { $version }…

## Notification the first time the window is closed

still-running-title = { -app-name } is still running
still-running-windows = It keeps routing in the background. Find it in the system tray; Windows may tuck it under the ^ arrow by the clock.
still-running-macos = It keeps routing in the background. Find it in the menu bar.
still-running-linux = It keeps routing in the background. Find it in the system tray.

## A newer version ($version, such as 0.5.0; $current is the one running)

update-available = Version { $version } is out
update-available-tooltip = You have { $current }. Opens the download page.
update-notify-title = { -app-name } { $version } is available
update-notify-text = Open { -app-name } to download it.

## Starting up

# tailnet-proxy is this app's earlier name; keep it as it is. $error is a system error message.
migrate-failed = Your sign-ins from tailnet-proxy, this app's earlier version, couldn't be moved over ({ $error }). It's probably still running. Quit tailnet-proxy, then start { -app-name } again before you sign in here: signing in again would add this computer to each tailnet a second time.

## Language names in Settings, after each language's own name

english = English
french = French
german = German
spanish-latin-america = Latin American Spanish
spanish-spain = Spanish (Spain)
chinese-simplified = Simplified Chinese
chinese-traditional = Traditional Chinese
korean = Korean
japanese = Japanese
polish = Polish
russian = Russian
portuguese-brazil = Brazilian Portuguese
italian = Italian
turkish = Turkish
ukrainian = Ukrainian
czech = Czech
portuguese-portugal = European Portuguese
dutch = Dutch
indonesian = Indonesian
vietnamese = Vietnamese
thai = Thai
swedish = Swedish
romanian = Romanian
hungarian = Hungarian
afrikaans = Afrikaans
catalan = Catalan
serbian-cyrillic = Serbian (Cyrillic)
danish = Danish
finnish = Finnish
greek = Greek
norwegian-bokmal = Norwegian Bokmål
