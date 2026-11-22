### Tailnet Link: suomenkielinen katalogi.
### Säilytä tuotenimet Tailnet Link ja Tailscale sekä sana "tailnet"
### (Tailscale-verkko): tailnet, tailnetin, tailnetiin, tailnetissä, tailnetistä, tailnetit.
### Käyttäjän antamat nimet ({ $tailnet }, { $host } ym.) eivät saa sijapäätteitä:
### taivuta niiden edessä olevaa sanaa (esim. "tailnetiin { $tailnet }").

-app-name = Tailnet Link

## Window header

tab-tailnets = Tailnetit
tab-settings = Asetukset

## Unsaved-changes bar at the bottom of Settings

unsaved-changes = Sinulla on tallentamattomia muutoksia.
save = Tallenna
revert = Palauta
revert-tooltip = Kumoa muutokset
settings-saved = Asetukset tallennettu

## Short notes at the bottom of the window

copied-address = Kopioitu: { $address }
copied-sign-in-link = Kirjautumislinkki kopioitu

## Errors shown in the "Something went wrong" dialog

start-failed =
    { -app-name } ei käynnisty:
    { $error }
add-tailnet-failed =
    Tailnetin lisääminen epäonnistui:
    { $error }
add-forward-failed =
    Portin edelleenohjauksen lisääminen epäonnistui:
    { $error }
remote-desktop-failed = Etätyöpöydän käynnistäminen epäonnistui: { $error }
remote-desktop-windows-only = Etätyöpöytä on sisäänrakennettuna vain Windowsissa.
no-free-port = Vapaata paikallista porttia ei löytynyt.

## Dialog after "Add a tailnet"

sign-in-dialog-title = Kirjaudu uuteen tailnetiin
sign-in-dialog-text =
    Selain avaa Tailscalen kirjautumissivun. Se voi avautua tämän ikkunan taakse.
    
    Kirjaudu sisään kyseisen tailnetin tililläsi ja palaa sitten tänne. Tailnetin verkkotunnus haetaan automaattisesti.

## One tailnet's state, shown as a coloured label beside its name

state-waiting-sign-in = Odottaa kirjautumista
state-signed-out = Kirjautunut ulos
state-problem = Ongelma
state-connecting = Yhdistetään
state-paused = Keskeytetty
state-no-domain = Ei vielä verkkotunnusta
state-not-routing = Ei reititä
state-routing = Reitittää

## The whole app's state, in the status card and the tray menu

summary-no-tailnets = Ei vielä tailnetejä
summary-paused = Keskeytetty
summary-routing-one = Reititetään tailnetin { $tailnet } kautta
summary-routing-all =
    { $count ->
        [one] Reititetään { $count } tailnetin kautta
       *[other] Reititetään { $count } tailnetin kautta
    }
summary-routing-some =
    { $count ->
        [one] Reititetään { $routing }/{ $count } tailnetin kautta
       *[other] Reititetään { $routing }/{ $count } tailnetin kautta
    }
summary-signed-out = Ei kirjautunut
summary-problem = Ongelma: { $problem }
summary-connecting = Yhdistetään…
new-tailnet = Uusi tailnet

## Status card at the top of the Tailnets tab

hero-starting = Käynnistetään…
hero-connecting = Yhdistetään tailneteihisi.
hero-paused = Muiden tailnetien kautta ei kulje juuri nyt mitään. Oma verkkosi ja tailnetisi toimivat tavalliseen tapaan.
hero-finish-sign-in = Viimeistele kirjautuminen tailnetiin { $tailnet } selaimessa.
hero-sign-in = Kirjaudu tailnetiin { $tailnet }, niin pääset sen koneisiin.
hero-routing-example = Avaa { $address } tai mikä tahansa muu näiden tailnetien osoite. Kaikki muu kulkee suoraan.
hero-routing = Näiden tailnetien osoitteet avautuvat selaimessa. Kaikki muu kulkee suoraan.
add-tailnet = Lisää tailnet
pause-all = Keskeytä kaikki
pause-all-tooltip = Lopeta reititys muiden tailnetien kautta toistaiseksi
resume = Jatka
resume-tooltip = Jatka reititystä muiden tailnetien kautta

## First run, before any tailnet is added

welcome-title = Käytä muiden tailnetien koneita
welcome-text = Pysy omassa tailnetissäsi ja avaa samalla koneita muissa. Tailscale-sovelluksesi toimii tavalliseen tapaan.
welcome-sign-in = Kirjaudu toiseen tailnetiin
welcome-sign-in-detail = Tailscalen kirjautumissivu avautuu selaimessa.
welcome-open = Avaa sen koneet nimellä
welcome-open-detail = Osoitteet, kuten { $example }, toimivat selaimessa.
welcome-forward = Ohjaa portti edelleen, kun sovellus tarvitsee sitä
welcome-forward-detail = Etätyöpöytä, SSH ja tietokantasovellukset saavat paikallisen portin, joka johtaa koneeseen.

## A tailnet's card

machine-search-hint = Etsi konetta nimen, käyttöjärjestelmän tai osoitteen perusteella
clear-search = Tyhjennä haku
more-actions = Lisää toimintoja
edit-tailnet-menu = Nimeä uudelleen tai lisää verkkotunnuksia…
log-out-menu = Kirjaudu ulos…
remove-menu = Poista…
sign-in = Kirjaudu sisään
pause-tailnet = Keskeytä tämä tailnet
resume-tailnet = Jatka tätä tailnetiä
detail-tailnet = Tailnet
detail-routes = Reitit
detail-this-computer = Tämä tietokone
detail-problem = Ongelma
routes-after-sign-in = Selviää kirjautumisen jälkeen
hostname-after-sign-in = { $hostname } (kirjautumisen jälkeen)
sign-in-help = Eikö selain avautunut, tai avautuiko väärä profiili?
sign-in-open-again = Avaa kirjautumissivu uudelleen
sign-in-copy-link = Kopioi linkki
sign-in-copy-link-tooltip = Liitä se selaimeen tai selainprofiiliin, jota käytät tälle tailnetille

## Machine list inside a tailnet's card

machines-online = Koneet · { $online }/{ $total } verkossa
machines-matching = Koneet · { $shown }/{ $total } vastaa hakua
no-machines = Tässä tailnetissä ei näy muita koneita.
no-machine-matches = Mikään kone ei vastaa hakua.
machine-offline = { $name } (ei verkossa)
forward-port-tooltip = Ohjaa portti edelleen: sovelluksille, jotka ohittavat välityspalvelinasetuksen, kuten Etätyöpöytä tai tietokantaohjelma
copy-address = Kopioi { $address }
open-in-browser = Avaa { $url } selaimessa
not-routing-tooltip = Tämä tailnet ei reititä juuri nyt. Onko se keskeytetty?

## Settings: port forwards

forwards-heading = Portin edelleenohjaukset
forwards-help = Sovelluksille, jotka ohittavat välityspalvelinasetuksen, kuten Etätyöpöytä, SSH ja tietokantaohjelmat. Jokainen edelleenohjaus on tämän tietokoneen portti, joka johtaa koneeseen jossakin tailnetissä.
edit-forwards = Muokkaa edelleenohjauksia
# Säilytä LOCALPORT, auto ja host:port sellaisinaan: ne kirjoitetaan juuri noin.
forwards-format-help = Yksi riviä kohden: LOCALPORT = host:port, tai auto = host:port, jolloin vapaa portti valitaan puolestasi. Isäntänimi ratkaisee, mikä tailnet välittää yhteyden. Nopeimmin lisäät edelleenohjauksen koneen pistokepainikkeella Tailnetit-välilehdellä.
forward-cant-listen = Kuuntelu ei onnistu: { $error }
forward-port-on-save = Portti valitaan, kun tallennat
forward-no-tailnet = Millään reitittävällä tailnetillä ei ole tätä nimeä
forward-via = tailnetin { $tailnet } kautta
open-remote-desktop-to = Avaa Etätyöpöytä-yhteys kohteeseen { $address }

## Settings: system proxy

proxy-heading = Järjestelmän välityspalvelinasetus
proxy-on = Käytössä (suositus)
proxy-force = Käytössä, ja korvaa yrityksesi asettama välityspalvelinskripti sovelluksen ollessa käynnissä
proxy-off = Ei käytössä: määritän sovellukseni itse
proxy-help-windows = ”Käytössä” ohjaa Windowsin tämän sovelluksen sääntöihin vain, kun sovellus on käynnissä ja reitittää, ja palauttaa kaiken ennalleen, kun se pysähtyy, keskeytetään, menettää yhteyden tai kaatuu.
proxy-help-macos = ”Käytössä” asettaa välityspalvelimen verkkopalveluillesi sovelluksen ollessa käynnissä ja palauttaa sen jälkeenpäin. Jos Macisi vaatii tähän järjestelmänvalvojan salasanan, sitä kysytään reitityksen alkaessa ja sovelluksesta poistuttaessa.
proxy-help-linux = ”Käytössä” asettaa GNOMEn tai KDE:n välityspalvelinasetuksen, kun sovellus on käynnissä ja reitittää, ja palauttaa sen jälkeenpäin. Ota Firefoxissa käyttöön Asetukset > Verkkoasetukset > ”Käytä järjestelmän välityspalvelinasetuksia”.

## Settings: general

general-heading = Yleiset
start-at-login = Käynnistä { -app-name }, kun kirjaudun sisään
language = Kieli
system-default = Järjestelmän oletus

## Settings: troubleshooting

troubleshooting-heading = Vianmääritys
troubleshooting-help = Testaa verkko-osoite tai nimi:portti nähdäksesi, mikä tailnet välittää sen ja saako siihen yhteyden.
test = Testaa
testing = Testataan…
open-log = Avaa loki
open-settings-folder = Avaa asetuskansio
about-line = { -app-name } { $version } · paikallinen välityspalvelin { $proxy } · PAC { $pac }
settings-location = Asetukset: { $path }

## Results of "Test" in Troubleshooting

check-empty = Kirjoita koneen nimi tai verkko-osoite.
check-bad-port = { $input }: portti ei kelpaa.
check-not-routed = { -app-name } ei reititä kohdetta { $host }: se ei pääty minkään juuri nyt reitittävän tailnetin verkkotunnukseen, joten se kulkee suoraan (tavallisen verkkosi ja oman Tailscalesi kautta).
check-gone = Tuo tailnet katosi juuri.
check-not-running = Tailnet { $tailnet } ei ole käynnissä.
check-ok = { $address } toimii: yhteys tailnetin { $tailnet } kautta, { $ms } ms.
check-failed =
    Kohde { $host } reititetään tailnetin { $tailnet } kautta, mutta yhteys porttiin { $port } epäonnistui: { $error }
    Tarkista, että kone on verkossa ja että jokin kuuntelee kyseistä porttia.
check-timeout = Kohde { $host } reititetään tailnetin { $tailnet } kautta, mutta portti { $port } ei vastannut 10 sekunnin kuluessa.
domain-conflict = Myös tailnet { $tailnet } reitittää verkkotunnuksen { $domain }, ja se on etusijalla.

## Mistakes in typed settings

forwards-line-format = Rivi { $line }: kirjoita LOCALPORT = host:port.
forwards-line-port = Rivi { $line }: ”{ $value }” ei ole porttinumero (eikä auto).
forwards-line-target = Rivi { $line }: ”{ $value }” pitää olla muotoa host:port.
forwards-line-duplicate = Rivi { $line }: paikallinen portti { $port } on käytössä kahdesti.
domain-invalid = ”{ $domain }” ei ole verkkotunnus; käytä esimerkiksi muotoa example.ts.net.
domain-characters = ”{ $domain }” sisältää merkkejä, joita verkkotunnuksessa ei voi olla.
autostart-unsupported = Käynnistystä sisäänkirjautumisen yhteydessä ei tueta tässä järjestelmässä.

## Dialogs

ok = OK
cancel = Peruuta
done = Valmis
copy = Kopioi
error-title = Jokin meni vikaan
error-details = Lisätiedot: { $path }
edit-title = Muokkaa: { $tailnet }
tailnet-name = Nimi
tailnet-name-hint = Näkyy tässä sovelluksessa ja ilmaisinalueen valikossa
extra-domains = Lisäverkkotunnukset (valinnainen)
extra-domains-help = Tailnetin oma verkkotunnus reititetään automaattisesti. Lisää yksi riviä kohden.
forward-dialog-title = Ohjaa portti edelleen
forward-dialog-text = Saat tähän tietokoneeseen portin, joka johtaa kohteeseen { $host }. Mikä portti kyseisessä koneessa?
port-preset-remote-desktop = Etätyöpöytä
port-tooltip = Portti { $port }
port = Portti
port-hint = esim. 8080
add-forward = Lisää edelleenohjaus
not-a-port = ”{ $value }” ei ole porttinumero (1–65535).
forward-ready-title = Portin edelleenohjaus on valmis
forward-ready-text = Osoita sovelluksesi tähän osoitteeseen, niin pääset kohteeseen { $target }:
forward-ready-note = Portti pysyy samana. Löydät sen asetuksista.
open-remote-desktop = Avaa Etätyöpöytä
remove-title = Poistetaanko tämä tailnet?
remove-text = { -app-name } kirjautuu ulos tailnetistä { $tailnet } ja unohtaa sen tällä tietokoneella. Voit lisätä sen myöhemmin uudelleen.
remove = Poista
log-out-title = Kirjaudutaanko ulos?
log-out-text = Kirjaudutaanko ulos tailnetistä { $tailnet }? Sen osoitteet lakkaavat toimimasta täällä, kunnes kirjaudut uudelleen.
log-out = Kirjaudu ulos

## Tray (Windows, Linux) or menu bar (macOS) menu

tray-sign-in = { $tailnet }: kirjaudu sisään…
tray-tailnet = { $tailnet }: { $state }
tray-add-tailnet = Lisää tailnet…
tray-route = Reititä muiden tailnetien kautta
tray-open = Avaa { -app-name }…
tray-quit = Lopeta
tray-tooltip = { -app-name }: { $summary }

## Notification the first time the window is closed

still-running-title = { -app-name } on yhä käynnissä
still-running-windows = Se jatkaa reititystä taustalla. Löydät sen ilmaisinalueelta; Windows saattaa piilottaa sen kellon vieressä olevan ^-nuolen alle.
still-running-macos = Se jatkaa reititystä taustalla. Löydät sen valikkoriviltä.
still-running-linux = Se jatkaa reititystä taustalla. Löydät sen ilmaisinalueelta.

## Language names in Settings, after each language's own name

english = Englanti
french = Ranska
german = Saksa
spanish-latin-america = Latinalaisen Amerikan espanja
spanish-spain = Espanjan espanja
chinese-simplified = Yksinkertaistettu kiina
chinese-traditional = Perinteinen kiina
korean = Korea
japanese = Japani
polish = Puola
russian = Venäjä
portuguese-brazil = Brasilian portugali
italian = Italia
turkish = Turkki
ukrainian = Ukraina
czech = Tšekki
portuguese-portugal = Euroopan portugali
dutch = Hollanti
indonesian = Indonesia
vietnamese = Vietnam
thai = Thai
swedish = Ruotsi
romanian = Romania
hungarian = Unkari
afrikaans = Afrikaans
catalan = Katalaani
serbian-cyrillic = Serbia, kyrillinen
danish = Tanska
finnish = Suomi
greek = Kreikka
norwegian-bokmal = Norjan bokmål
summary-proxy-problem = Yhdistetty, mutta sovelluksesi eivät käytä yhteyttä
hero-proxy-taken = Selaimesi ei avaa näiden tailnetien osoitteita: järjestelmän välityspalvelinasetus käyttää toista asetusskriptiä ({ $script }).
hero-proxy-other-copy = Selaimesi ei avaa näiden tailnetien osoitteita: toinen { -app-name } -kopio hallitsee järjestelmän välityspalvelinasetusta. Lopeta toinen kopio, niin tämä ottaa ohjat.
hero-proxy-changed = Selaimesi ei avaa näiden tailnetien osoitteita: jokin muu muutti järjestelmän välityspalvelinasetusta.
hero-proxy-failed = Selaimesi ei avaa näiden tailnetien osoitteita: järjestelmän välityspalvelinasetusta ei voitu muuttaa ({ $error }).
hero-proxy-manual = Järjestelmän välityspalvelinasetus ei ole käytössä, joten näihin tailneteihin pääsevät vain sovellukset, jotka määrität itse. Ohjaa ne osoitteeseen { $pac }
proxy-replace = Korvaa se
proxy-replace-tooltip = Käytä sovelluksen { -app-name } asetusskriptiä sen ollessa käynnissä ja palauta toinen sen jälkeen
proxy-retry = Yritä uudelleen
proxy-retry-tooltip = Ohjaa järjestelmän välityspalvelinasetus taas sovellukseen { -app-name }
system-setting = Järjestelmän välityspalvelinasetus nyt: { $value }
system-setting-none = ei mitään
check-updates = Tarkista uudet versiot
tray-update = Lataa { -app-name } { $version }…
update-available = Versio { $version } on julkaistu
update-available-tooltip = Sinulla on { $current }. Avaa lataussivun.
update-notify-title = { -app-name } { $version } on saatavilla
update-notify-text = Lataa se avaamalla { -app-name }.
migrate-failed = Kirjautumisiasi ei voitu siirtää sovelluksesta tailnet-proxy, joka on tämän sovelluksen aiempi versio ({ $error }). Se on luultavasti yhä käynnissä. Lopeta tailnet-proxy ja käynnistä sitten { -app-name } uudelleen ennen kuin kirjaudut täällä: uusi kirjautuminen lisäisi tämän tietokoneen jokaiseen tailnetiin toiseen kertaan.
