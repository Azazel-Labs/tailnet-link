### Tailnet Link: magyar katalógus.
### Az angol forrás: locales/en/tailnet-link.ftl; lásd docs/translations.md.
### A Tailnet Link és a Tailscale terméknév, a „tailnet” szó (Tailscale-hálózat) változatlan marad.
### A változók elé „a(z)” kerül, és soha nem kapnak ragot.

-app-name = Tailnet Link

## Ablakfejléc

tab-tailnets = Tailnetek
tab-settings = Beállítások

## Nem mentett módosítások sávja a Beállítások alján

unsaved-changes = Nem mentett módosításai vannak.
save = Mentés
revert = Visszaállítás
revert-tooltip = A módosítások visszavonása
settings-saved = Beállítások mentve

## Rövid üzenetek az ablak alján

# $address egy gépnév vagy 127.0.0.1:port.
copied-address = Másolva: { $address }
copied-sign-in-link = A bejelentkezési hivatkozás másolva

## Hibák a „Hiba történt” párbeszédablakban

start-failed =
    A { -app-name } nem tud elindulni:
    { $error }
add-tailnet-failed =
    Nem sikerült tailnetet hozzáadni:
    { $error }
add-forward-failed =
    Nem sikerült hozzáadni a porttovábbítást:
    { $error }
remote-desktop-failed = A Távoli asztal nem indítható el: { $error }
remote-desktop-windows-only = A Távoli asztal csak a Windowsba van beépítve.
no-free-port = Nem található szabad helyi port.

## Párbeszédablak a „Tailnet hozzáadása” után

sign-in-dialog-title = Bejelentkezés az új tailnetbe
sign-in-dialog-text =
    A böngészőben megnyílik a Tailscale bejelentkezési oldala. Lehet, hogy ez mögött az ablak mögött jelenik meg.
    
    Jelentkezzen be az adott tailnethez tartozó fiókjával, majd térjen vissza ide. A tailnet tartományát a program automatikusan felismeri.

## Egy tailnet állapota, színes címkeként a neve mellett

state-waiting-sign-in = Bejelentkezésre vár
state-signed-out = Kijelentkezve
state-problem = Hiba
state-connecting = Csatlakozás
state-paused = Szüneteltetve
state-no-domain = Még nincs tartomány
state-not-routing = Nincs útválasztás
state-routing = Útválasztás aktív

## Az alkalmazás teljes állapota az állapotkártyán és a tálcamenüben

summary-no-tailnets = Még nincs tailnet
summary-paused = Szüneteltetve
# $tailnet az egyetlen tailnet neve.
summary-routing-one = Útválasztás: { $tailnet }
# Minden tailnet útválaszt; $count legalább 2.
summary-routing-all =
    { $count ->
        [one] Útválasztás { $count } tailneten át
       *[other] Útválasztás { $count } tailneten át
    }
summary-routing-some =
    { $count ->
        [one] Útválasztás { $routing } tailneten át (összesen { $count })
       *[other] Útválasztás { $routing } tailneten át (összesen { $count })
    }
summary-signed-out = Nincs bejelentkezve
summary-problem = Hiba: { $problem }
summary-connecting = Csatlakozás…
# Egy tailnet az első bejelentkezés előtt, amikor még nincs neve.
new-tailnet = Új tailnet

## Állapotkártya a Tailnetek lap tetején

hero-starting = Indítás…
hero-connecting = Csatlakozás a tailnetekhez.
hero-paused = Most semmi sem halad át más tailneteken. A saját hálózata és tailnetje a szokásos módon működik.
hero-finish-sign-in = Fejezze be a böngészőben a bejelentkezést a(z) { $tailnet } tailnetbe.
hero-sign-in = Jelentkezzen be a(z) { $tailnet } tailnetbe, hogy elérje a gépeit.
# $address egy gép neve, például build-pc.example.ts.net.
hero-routing-example = Nyissa meg a(z) { $address } címet vagy bármely más címet ezekben a tailnetekben. Minden más forgalom közvetlenül halad.
hero-routing = Ezeknek a tailneteknek a címei megnyílnak a böngészőben. Minden más forgalom közvetlenül halad.
add-tailnet = Tailnet hozzáadása
pause-all = Összes szüneteltetése
pause-all-tooltip = Az útválasztás ideiglenes leállítása a többi tailneten át
resume = Folytatás
resume-tooltip = Az útválasztás újraindítása a többi tailneten át

## Első indítás, mielőtt bármilyen tailnet hozzá lenne adva

welcome-title = Érje el más tailnetek gépeit
welcome-text = Maradjon a saját tailnetjén, és közben nyissa meg a többi tailnet gépeit is. A Tailscale alkalmazás a szokásos módon működik tovább.
welcome-sign-in = Jelentkezzen be egy másik tailnetbe
welcome-sign-in-detail = A Tailscale bejelentkezési oldala megnyílik a böngészőben.
welcome-open = Nyissa meg a gépeit név szerint
# $example egy mintacím, build-pc.example.ts.net.
welcome-open-detail = Az olyan címek, mint { $example }, működnek a böngészőben.
welcome-forward = Továbbítson portot, ha egy alkalmazásnak szüksége van rá
welcome-forward-detail = A Távoli asztal, az SSH és az adatbázis-alkalmazások egy helyi portot kapnak, amely egy géphez vezet.

## Egy tailnet kártyája

machine-search-hint = Gép keresése név, operációs rendszer vagy cím szerint
clear-search = Keresés törlése
more-actions = További műveletek
edit-tailnet-menu = Átnevezés vagy tartományok hozzáadása…
log-out-menu = Kijelentkezés…
remove-menu = Eltávolítás…
sign-in = Bejelentkezés
pause-tailnet = A tailnet szüneteltetése
resume-tailnet = A tailnet folytatása
detail-tailnet = Tailnet
detail-routes = Útvonalak
detail-this-computer = Ez a számítógép
detail-problem = Hiba
routes-after-sign-in = Bejelentkezés után derül ki
# $hostname ennek a számítógépnek a neve a tailnetben.
hostname-after-sign-in = { $hostname } (bejelentkezés után)
sign-in-help = Nem nyílt meg a böngésző, vagy rossz profilban nyílt meg?
sign-in-open-again = A bejelentkezési oldal újbóli megnyitása
sign-in-copy-link = Hivatkozás másolása
sign-in-copy-link-tooltip = Illessze be abba a böngészőbe vagy böngészőprofilba, amelyet ehhez a tailnethez használ

## Géplista egy tailnet kártyáján

machines-online = Gépek · { $online } online, összesen { $total }
machines-matching = Gépek · { $shown } találat, összesen { $total }
no-machines = Ebben a tailnetben nem látható más gép.
no-machine-matches = Egy gép sem felel meg a keresésnek.
machine-offline = { $name } (offline)
forward-port-tooltip = Porttovábbítás: a proxybeállítást figyelmen kívül hagyó alkalmazásokhoz, például a Távoli asztalhoz vagy egy adatbázis-klienshez
copy-address = Másolás: { $address }
open-in-browser = Megnyitás a böngészőben: { $url }
not-routing-tooltip = Ez a tailnet most nem végez útválasztást. Talán szüneteltetve van?

## Beállítások: porttovábbítások

forwards-heading = Porttovábbítások
forwards-help = A proxybeállítást figyelmen kívül hagyó alkalmazásokhoz, például a Távoli asztalhoz, az SSH- és az adatbázis-kliensekhez. Minden továbbítás egy port ezen a számítógépen, amely egy tailnet egyik gépéhez vezet.
edit-forwards = Továbbítások szerkesztése
# A LOCALPORT, auto és host:port maradjon változatlan: ezeket kell begépelni.
forwards-format-help = Soronként egy: LOCALPORT = host:port, vagy auto = host:port, ha a program válasszon szabad portot. A gép neve dönti el, melyik tailnet viszi a forgalmat. Gyors hozzáadáshoz használja a csatlakozó gombot egy gép mellett a Tailnetek lapon.
forward-cant-listen = Nem lehet figyelni: { $error }
forward-port-on-save = A port kiválasztása mentéskor történik
forward-no-tailnet = Nincs ilyen nevű, útválasztást végző tailnet
# $tailnet a továbbítást vivő tailnet.
forward-via = { $tailnet } útján
open-remote-desktop-to = Távoli asztal megnyitása: { $address }

## Beállítások: rendszerproxy

proxy-heading = Rendszer proxybeállítása
proxy-on = Be (ajánlott)
proxy-force = Be, és futás közben a cége által beállított proxyszkript cseréje
proxy-off = Ki: az alkalmazásaimat magam állítom be
proxy-help-windows = A „Be” csak akkor irányítja a Windowst az alkalmazás szabályaira, amikor az fut és útválasztást végez, és mindent visszaállít, amikor leáll, szünetel, megszakad a kapcsolata vagy összeomlik.
proxy-help-macos = A „Be” az alkalmazás futása alatt beállítja a proxyt a hálózati szolgáltatásokhoz, utána pedig visszaállítja. Ha a Mac ehhez rendszergazdai jelszót kér, az útválasztás indításakor és kilépéskor kell megadnia.
# A Firefox saját magyar feliratai.
proxy-help-linux = A „Be” az alkalmazás futása és útválasztása alatt beállítja a GNOME vagy a KDE proxybeállítását, utána pedig visszaállítja. A Firefoxban kapcsolja be ezt: Beállítások > Hálózati beállítások > „Rendszerbeállítások használata”.

## Beállítások: általános

general-heading = Általános
start-at-login = A { -app-name } indítása bejelentkezéskor
language = Nyelv
system-default = Rendszer alapértelmezése

## Beállítások: hibaelhárítás

troubleshooting-heading = Hibaelhárítás
troubleshooting-help = Teszteljen egy webcímet vagy név:port párost, hogy lássa, melyik tailnet viszi, és létrejön-e a kapcsolat.
test = Teszt
testing = Tesztelés…
open-log = Napló megnyitása
open-settings-folder = Beállításmappa megnyitása
about-line = { -app-name } { $version } · helyi proxy { $proxy } · PAC { $pac }
settings-location = Beállítások helye: { $path }

## A hibaelhárítási „Teszt” eredményei

check-empty = Írjon be egy gépnevet vagy webcímet.
check-bad-port = { $input }: ez nem érvényes port.
check-not-routed = { $host }: a { -app-name } nem irányítja át, mert egyik éppen útválasztást végző tailnet tartományára sem végződik. Ezért közvetlenül halad (a szokásos hálózatán és a saját Tailscale-kapcsolatán át).
check-gone = Ez a tailnet épp eltűnt.
check-not-running = A(z) { $tailnet } tailnet nem fut.
check-ok = { $address } működik: kapcsolódva a(z) { $tailnet } tailneten át, { $ms } ms alatt.
check-failed =
    { $host } a(z) { $tailnet } tailneten át van irányítva, de a(z) { $port } portra nem sikerült csatlakozni: { $error }
    Ellenőrizze, hogy a gép online van-e, és figyel-e valami azon a porton.
check-timeout = { $host } a(z) { $tailnet } tailneten át van irányítva, de a(z) { $port } port 10 másodpercen belül nem válaszolt.
# Két tailnet ugyanazt a tartományt igényli; $tailnet az, amelyiknek az útvonalai érvényesek.
domain-conflict = A(z) { $domain } tartományt a(z) { $tailnet } tailnet is irányítja; az utóbbi érvényes.

## Hibák a begépelt beállításokban

forwards-line-format = { $line }. sor: írja így: LOCALPORT = host:port.
forwards-line-port = { $line }. sor: „{ $value }” nem portszám (és nem auto).
forwards-line-target = { $line }. sor: „{ $value }” helyett host:port formátum kell.
forwards-line-duplicate = { $line }. sor: a(z) { $port } helyi port kétszer szerepel.
domain-invalid = „{ $domain }” nem tartomány; adjon meg ilyesmit: example.ts.net.
domain-characters = „{ $domain }” olyan karaktereket tartalmaz, amelyek tartománynévben nem fordulhatnak elő.
autostart-unsupported = A bejelentkezéskori indítás ezen a rendszeren nem támogatott.

## Párbeszédablakok

ok = OK
cancel = Mégse
done = Kész
copy = Másolás
error-title = Hiba történt
error-details = Részletek: { $path }
# $tailnet a tailnet neve.
edit-title = Szerkesztés: { $tailnet }
tailnet-name = Név
tailnet-name-hint = Ebben az alkalmazásban és a tálcamenüben jelenik meg
extra-domains = További tartományok (nem kötelező)
extra-domains-help = A tailnet saját tartománya automatikusan át van irányítva. Soronként egyet adjon meg.
forward-dialog-title = Porttovábbítás
forward-dialog-text = Kapjon egy portot ezen a számítógépen, amely ide vezet: { $host }. A gép melyik portjára?
port-preset-remote-desktop = Távoli asztal
port-tooltip = Port: { $port }
port = Port
port-hint = pl. 8080
add-forward = Továbbítás hozzáadása
not-a-port = „{ $value }” nem portszám (1–65535).
forward-ready-title = A porttovábbítás kész
forward-ready-text = Erre a címre irányítsa az alkalmazást a(z) { $target } eléréséhez:
forward-ready-note = A port nem változik. A Beállításokban megtalálja.
open-remote-desktop = Távoli asztal megnyitása
remove-title = Eltávolítja ezt a tailnetet?
remove-text = A { -app-name } kijelentkezik a(z) { $tailnet } tailnetből, és elfelejti ezen a számítógépen. Később újra hozzáadhatja.
remove = Eltávolítás
log-out-title = Kijelentkezik?
log-out-text = Kijelentkezik a(z) { $tailnet } tailnetből? A címei itt nem működnek, amíg újra be nem jelentkezik.
log-out = Kijelentkezés

## Tálcamenü (Windows, Linux) vagy menüsor (macOS)

tray-sign-in = { $tailnet }: bejelentkezés…
# $state a fenti state-* címkék egyike.
tray-tailnet = { $tailnet }: { $state }
tray-add-tailnet = Tailnet hozzáadása…
tray-route = Útválasztás más tailneteken át
tray-open = A { -app-name } megnyitása…
tray-quit = Kilépés
tray-tooltip = { -app-name }: { $summary }

## Értesítés az ablak első bezárásakor

still-running-title = A { -app-name } továbbra is fut
still-running-windows = A háttérben folytatja az útválasztást. Az értesítési területen találja; a Windows elrejtheti az óra melletti ^ nyíl alá.
still-running-macos = A háttérben folytatja az útválasztást. A menüsorban találja.
still-running-linux = A háttérben folytatja az útválasztást. A rendszertálcán találja.

## Nyelvnevek a Beállításokban, az egyes nyelvek saját neve után

english = Angol
french = Francia
german = Német
spanish-latin-america = Latin-amerikai spanyol
spanish-spain = Spanyolországi spanyol
chinese-simplified = Egyszerűsített kínai
chinese-traditional = Hagyományos kínai
korean = Koreai
japanese = Japán
polish = Lengyel
russian = Orosz
portuguese-brazil = Brazil portugál
italian = Olasz
turkish = Török
ukrainian = Ukrán
czech = Cseh
portuguese-portugal = Európai portugál
dutch = Holland
indonesian = Indonéz
vietnamese = Vietnámi
thai = Thai
swedish = Svéd
romanian = Román
hungarian = Magyar
afrikaans = Afrikaans
catalan = Katalán
serbian-cyrillic = Szerb, cirill
danish = Dán
finnish = Finn
greek = Görög
norwegian-bokmal = Norvég bokmål
