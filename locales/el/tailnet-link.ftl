### Tailnet Link: ελληνικός κατάλογος.
### Η αγγλική πηγή είναι το locales/en/tailnet-link.ftl· δείτε το docs/translations.md.
### Τα Tailnet Link και Tailscale μένουν ως έχουν. Η λέξη «tailnet» (δίκτυο Tailscale)
### μένει με λατινικούς χαρακτήρες, ουδέτερη και άκλιτη: το tailnet, τα tailnet.

-app-name = Tailnet Link

## Κεφαλίδα παραθύρου

tab-tailnets = Tailnet
tab-settings = Ρυθμίσεις

## Γραμμή μη αποθηκευμένων αλλαγών στο κάτω μέρος των Ρυθμίσεων

unsaved-changes = Έχετε μη αποθηκευμένες αλλαγές.
save = Αποθήκευση
revert = Επαναφορά
revert-tooltip = Αναίρεση των αλλαγών
settings-saved = Οι ρυθμίσεις αποθηκεύτηκαν

## Σύντομα μηνύματα στο κάτω μέρος του παραθύρου

# Το $address είναι όνομα μηχανήματος ή 127.0.0.1:θύρα.
copied-address = Αντιγράφηκε: { $address }
copied-sign-in-link = Ο σύνδεσμος σύνδεσης αντιγράφηκε

## Σφάλματα στο παράθυρο «Κάτι πήγε στραβά»

start-failed =
    Το { -app-name } δεν μπορεί να ξεκινήσει:
    { $error }
add-tailnet-failed =
    Δεν ήταν δυνατή η προσθήκη tailnet:
    { $error }
add-forward-failed =
    Δεν ήταν δυνατή η προσθήκη της προώθησης θύρας:
    { $error }
remote-desktop-failed = Δεν ήταν δυνατή η εκκίνηση της Απομακρυσμένης επιφάνειας εργασίας: { $error }
remote-desktop-windows-only = Η Απομακρυσμένη επιφάνεια εργασίας είναι ενσωματωμένη μόνο στα Windows.
no-free-port = Δεν βρέθηκε ελεύθερη τοπική θύρα.

## Παράθυρο μετά την «Προσθήκη tailnet»

sign-in-dialog-title = Σύνδεση στο νέο tailnet
sign-in-dialog-text =
    Το πρόγραμμα περιήγησης ανοίγει τη σελίδα σύνδεσης του Tailscale. Μπορεί να ανοίξει πίσω από αυτό το παράθυρο.
    
    Συνδεθείτε με τον λογαριασμό σας για εκείνο το tailnet και, στη συνέχεια, επιστρέψτε εδώ. Ο τομέας του εντοπίζεται αυτόματα.

## Κατάσταση ενός tailnet, ως έγχρωμη ετικέτα δίπλα στο όνομά του

state-waiting-sign-in = Αναμονή για σύνδεση
state-signed-out = Αποσυνδεδεμένο
state-problem = Πρόβλημα
state-connecting = Γίνεται σύνδεση
state-paused = Σε παύση
state-no-domain = Χωρίς τομέα ακόμη
state-not-routing = Χωρίς δρομολόγηση
state-routing = Δρομολόγηση

## Η κατάσταση όλης της εφαρμογής, στην κάρτα κατάστασης και στο μενού

summary-no-tailnets = Κανένα tailnet ακόμη
summary-paused = Σε παύση
# Το $tailnet είναι το όνομα του μοναδικού tailnet.
summary-routing-one = Δρομολόγηση μέσω { $tailnet }
# Όλα τα tailnet δρομολογούν· το $count είναι τουλάχιστον 2.
summary-routing-all =
    { $count ->
        [one] Δρομολόγηση μέσω { $count } tailnet
       *[other] Δρομολόγηση μέσω { $count } tailnet
    }
summary-routing-some =
    { $count ->
        [one] Δρομολόγηση μέσω { $routing } από { $count } tailnet
       *[other] Δρομολόγηση μέσω { $routing } από { $count } tailnet
    }
summary-signed-out = Δεν έχετε συνδεθεί
summary-problem = Πρόβλημα: { $problem }
summary-connecting = Γίνεται σύνδεση…
# Ένα tailnet πριν από την πρώτη σύνδεση, όταν δεν έχει ακόμη όνομα.
new-tailnet = Νέο tailnet

## Κάρτα κατάστασης στην κορυφή της καρτέλας Tailnet

hero-starting = Εκκίνηση…
hero-connecting = Γίνεται σύνδεση με τα tailnet σας.
hero-paused = Τίποτα δεν περνά από άλλα tailnet αυτή τη στιγμή. Το δικό σας δίκτυο και το tailnet σας λειτουργούν κανονικά.
hero-finish-sign-in = Ολοκληρώστε τη σύνδεση στο { $tailnet } στο πρόγραμμα περιήγησης.
hero-sign-in = Συνδεθείτε στο { $tailnet } για πρόσβαση στα μηχανήματά του.
# Το $address είναι όνομα μηχανήματος, π.χ. build-pc.example.ts.net.
hero-routing-example = Ανοίξτε το { $address } ή οποιαδήποτε άλλη διεύθυνση σε αυτά τα tailnet. Όλα τα υπόλοιπα πηγαίνουν απευθείας.
hero-routing = Οι διευθύνσεις σε αυτά τα tailnet ανοίγουν στο πρόγραμμα περιήγησης. Όλα τα υπόλοιπα πηγαίνουν απευθείας.
add-tailnet = Προσθήκη tailnet
pause-all = Παύση όλων
pause-all-tooltip = Προσωρινή διακοπή της δρομολόγησης μέσω άλλων tailnet
resume = Συνέχιση
resume-tooltip = Επανέναρξη της δρομολόγησης μέσω άλλων tailnet

## Πρώτη εκτέλεση, πριν προστεθεί κάποιο tailnet

welcome-title = Πρόσβαση σε μηχανήματα άλλων tailnet
welcome-text = Μείνετε στο δικό σας tailnet και ανοίξτε ταυτόχρονα μηχανήματα σε άλλα. Η εφαρμογή Tailscale συνεχίζει να λειτουργεί κανονικά.
welcome-sign-in = Συνδεθείτε σε άλλο tailnet
welcome-sign-in-detail = Η σελίδα σύνδεσης του Tailscale ανοίγει στο πρόγραμμα περιήγησης.
welcome-open = Ανοίξτε τα μηχανήματά του με το όνομά τους
# Το $example είναι μια ενδεικτική διεύθυνση, build-pc.example.ts.net.
welcome-open-detail = Διευθύνσεις όπως { $example } λειτουργούν στο πρόγραμμα περιήγησης.
welcome-forward = Προωθήστε μια θύρα όταν τη χρειάζεται μια εφαρμογή
welcome-forward-detail = Η Απομακρυσμένη επιφάνεια εργασίας, το SSH και οι εφαρμογές βάσεων δεδομένων αποκτούν μια τοπική θύρα που οδηγεί σε ένα μηχάνημα.

## Η κάρτα ενός tailnet

machine-search-hint = Εύρεση μηχανήματος με όνομα, ΛΣ ή διεύθυνση
clear-search = Εκκαθάριση αναζήτησης
more-actions = Περισσότερες ενέργειες
edit-tailnet-menu = Μετονομασία ή προσθήκη τομέων…
log-out-menu = Αποσύνδεση…
remove-menu = Κατάργηση…
sign-in = Σύνδεση
pause-tailnet = Παύση αυτού του tailnet
resume-tailnet = Συνέχιση αυτού του tailnet
detail-tailnet = Tailnet
detail-routes = Διαδρομές
detail-this-computer = Αυτός ο υπολογιστής
detail-problem = Πρόβλημα
routes-after-sign-in = Θα εντοπιστούν μετά τη σύνδεση
# Το $hostname είναι το όνομα αυτού του υπολογιστή στο tailnet.
hostname-after-sign-in = { $hostname } (μετά τη σύνδεση)
sign-in-help = Δεν άνοιξε το πρόγραμμα περιήγησης ή άνοιξε σε λάθος προφίλ;
sign-in-open-again = Ξανά άνοιγμα της σελίδας σύνδεσης
sign-in-copy-link = Αντιγραφή συνδέσμου
sign-in-copy-link-tooltip = Επικολλήστε τον στο πρόγραμμα περιήγησης ή στο προφίλ που χρησιμοποιείτε για αυτό το tailnet

## Λίστα μηχανημάτων στην κάρτα ενός tailnet

machines-online = Μηχανήματα · { $online } από { $total } συνδεδεμένα
machines-matching = Μηχανήματα · { $shown } από { $total } ταιριάζουν
no-machines = Δεν είναι ορατά άλλα μηχανήματα σε αυτό το tailnet.
no-machine-matches = Κανένα μηχάνημα δεν ταιριάζει με την αναζήτησή σας.
machine-offline = { $name } (εκτός σύνδεσης)
forward-port-tooltip = Προώθηση θύρας: για εφαρμογές που αγνοούν τη ρύθμιση διακομιστή μεσολάβησης, όπως η Απομακρυσμένη επιφάνεια εργασίας ή ένα πρόγραμμα-πελάτης βάσης δεδομένων
copy-address = Αντιγραφή { $address }
open-in-browser = Άνοιγμα του { $url } στο πρόγραμμα περιήγησης
not-routing-tooltip = Αυτό το tailnet δεν δρομολογεί αυτή τη στιγμή. Μήπως είναι σε παύση;

## Ιστότοποι στα μηχανήματα

sites-heading = Ιστότοποι
sites-help = Μηχανήματα στα tailnet σας που εξυπηρετούν έναν ιστότοπο μέσω HTTPS. Κάθε μηχάνημα ελέγχεται το πολύ μία φορά την ημέρα.
# Τα $done και $total μετρούν μηχανήματα.
sites-checking = Έλεγχος { $done } από { $total }…
sites-recheck-tooltip = Επανέλεγχος όλων των μηχανημάτων τώρα
site-untrusted = Το πιστοποιητικό του δεν είναι αξιόπιστο, οπότε το πρόγραμμα περιήγησης θα σας προειδοποιήσει.

## Ρυθμίσεις: προωθήσεις θυρών

forwards-heading = Προωθήσεις θυρών
forwards-help = Για εφαρμογές που αγνοούν τη ρύθμιση διακομιστή μεσολάβησης, όπως η Απομακρυσμένη επιφάνεια εργασίας, το SSH και τα προγράμματα-πελάτες βάσεων δεδομένων. Κάθε προώθηση είναι μια θύρα σε αυτόν τον υπολογιστή που οδηγεί σε ένα μηχάνημα ενός tailnet.
edit-forwards = Επεξεργασία προωθήσεων
# Τα LOCALPORT, auto και host:port μένουν ως έχουν: αυτά πληκτρολογεί ο χρήστης.
forwards-format-help = Μία ανά γραμμή: LOCALPORT = host:port, ή auto = host:port για να επιλεγεί μια ελεύθερη θύρα. Το όνομα του μηχανήματος καθορίζει ποιο tailnet τη μεταφέρει. Για γρήγορη προσθήκη, χρησιμοποιήστε το κουμπί με το βύσμα δίπλα σε ένα μηχάνημα στην καρτέλα Tailnet.
forward-cant-listen = Αδυναμία ακρόασης: { $error }
forward-port-on-save = Μια θύρα επιλέγεται κατά την αποθήκευση
forward-no-tailnet = Κανένα tailnet με ενεργή δρομολόγηση δεν έχει αυτό το όνομα
# Το $tailnet είναι το tailnet που μεταφέρει την προώθηση.
forward-via = μέσω { $tailnet }
open-remote-desktop-to = Άνοιγμα Απομακρυσμένης επιφάνειας εργασίας προς { $address }

## Ρυθμίσεις: διακομιστής μεσολάβησης συστήματος

proxy-heading = Ρύθμιση διακομιστή μεσολάβησης συστήματος
proxy-on = Ενεργή (συνιστάται)
proxy-force = Ενεργή, με αντικατάσταση του σεναρίου διακομιστή μεσολάβησης της εταιρείας σας όσο εκτελείται
proxy-off = Ανενεργή: θα ρυθμίσω τις εφαρμογές μου χειροκίνητα
proxy-help-windows = Η επιλογή «Ενεργή» κατευθύνει τα Windows στους κανόνες αυτής της εφαρμογής μόνο όσο εκτελείται και δρομολογεί, και επαναφέρει τα πάντα όταν σταματά, τίθεται σε παύση, αποσυνδέεται ή καταρρέει.
proxy-help-macos = Η επιλογή «Ενεργή» ορίζει τον διακομιστή μεσολάβησης για τις υπηρεσίες δικτύου σας όσο εκτελείται η εφαρμογή και τον επαναφέρει μετά. Αν το Mac σας χρειάζεται κωδικό διαχειριστή γι' αυτό, θα σας ζητηθεί κατά την έναρξη της δρομολόγησης και κατά την έξοδο.
# Οι ετικέτες είναι αυτές της ελληνικής έκδοσης του Firefox.
proxy-help-linux = Η επιλογή «Ενεργή» ορίζει τη ρύθμιση διακομιστή μεσολάβησης του GNOME ή του KDE όσο η εφαρμογή εκτελείται και δρομολογεί, και την επαναφέρει μετά. Στο Firefox, ενεργοποιήστε: Ρυθμίσεις > Ρυθμίσεις δικτύου > «Χρήση ρυθμίσεων διακομιστή μεσολάβησης συστήματος».

## Ρυθμίσεις: γενικά

general-heading = Γενικά
start-at-login = Εκκίνηση του { -app-name } κατά τη σύνδεσή μου
language = Γλώσσα
system-default = Προεπιλογή συστήματος

## Ρυθμίσεις: αντιμετώπιση προβλημάτων

troubleshooting-heading = Αντιμετώπιση προβλημάτων
troubleshooting-help = Δοκιμάστε μια διεύθυνση web ή ένα όνομα:θύρα για να δείτε ποιο tailnet τη μεταφέρει και αν συνδέεται.
test = Δοκιμή
testing = Δοκιμή…
open-log = Άνοιγμα αρχείου καταγραφής
open-settings-folder = Άνοιγμα φακέλου ρυθμίσεων
about-line = { -app-name } { $version } · τοπικός διακομιστής μεσολάβησης { $proxy } · PAC { $pac }
settings-location = Ρυθμίσεις στο { $path }

## Αποτελέσματα της «Δοκιμής» στην Αντιμετώπιση προβλημάτων

check-empty = Πληκτρολογήστε ένα όνομα μηχανήματος ή μια διεύθυνση web.
check-bad-port = { $input }: δεν είναι έγκυρη θύρα.
check-not-routed = Το { $host } δεν δρομολογείται από το { -app-name }: δεν τελειώνει στον τομέα κανενός tailnet που δρομολογεί αυτή τη στιγμή, οπότε πηγαίνει απευθείας (μέσω του κανονικού σας δικτύου και του δικού σας Tailscale).
check-gone = Αυτό το tailnet μόλις εξαφανίστηκε.
check-not-running = Το { $tailnet } δεν εκτελείται.
check-ok = Το { $address } λειτουργεί: συνδέθηκε μέσω { $tailnet } σε { $ms } ms.
check-failed =
    Το { $host } δρομολογείται μέσω { $tailnet }, αλλά η σύνδεση στη θύρα { $port } απέτυχε: { $error }
    Ελέγξτε ότι το μηχάνημα είναι συνδεδεμένο και ότι κάτι ακούει σε αυτή τη θύρα.
check-timeout = Το { $host } δρομολογείται μέσω { $tailnet }, αλλά η θύρα { $port } δεν απάντησε μέσα σε 10 δευτερόλεπτα.
# Δύο tailnet διεκδικούν τον ίδιο τομέα· το $tailnet είναι αυτό του οποίου οι διαδρομές χρησιμοποιούνται.
domain-conflict = Το { $domain } δρομολογείται και από το { $tailnet }· εκείνο υπερισχύει.

## Λάθη στις πληκτρολογημένες ρυθμίσεις

forwards-line-format = Γραμμή { $line }: γράψτε LOCALPORT = host:port.
forwards-line-port = Γραμμή { $line }: το «{ $value }» δεν είναι αριθμός θύρας (ούτε auto).
forwards-line-target = Γραμμή { $line }: το «{ $value }» πρέπει να έχει τη μορφή host:port.
forwards-line-duplicate = Γραμμή { $line }: η τοπική θύρα { $port } χρησιμοποιείται δύο φορές.
domain-invalid = Το «{ $domain }» δεν είναι τομέας· χρησιμοποιήστε κάτι σαν example.ts.net.
domain-characters = Το «{ $domain }» περιέχει χαρακτήρες που δεν επιτρέπονται σε τομέα.
autostart-unsupported = Η εκκίνηση κατά τη σύνδεση δεν υποστηρίζεται σε αυτό το σύστημα.

## Παράθυρα διαλόγου

ok = OK
cancel = Ακύρωση
done = Τέλος
copy = Αντιγραφή
error-title = Κάτι πήγε στραβά
error-details = Λεπτομέρειες στο { $path }
# Το $tailnet είναι το όνομα του tailnet.
edit-title = Επεξεργασία: { $tailnet }
tailnet-name = Όνομα
tailnet-name-hint = Εμφανίζεται σε αυτή την εφαρμογή και στο μενού της περιοχής ειδοποιήσεων
extra-domains = Επιπλέον τομείς (προαιρετικά)
extra-domains-help = Ο τομέας του ίδιου του tailnet δρομολογείται αυτόματα. Προσθέστε έναν ανά γραμμή.
forward-dialog-title = Προώθηση θύρας
forward-dialog-text = Αποκτήστε μια θύρα σε αυτόν τον υπολογιστή που οδηγεί στο { $host }. Ποια θύρα σε εκείνο το μηχάνημα;
port-preset-remote-desktop = Απομακρυσμένη επιφάνεια εργασίας
port-tooltip = Θύρα { $port }
port = Θύρα
port-hint = π.χ. 8080
add-forward = Προσθήκη προώθησης
not-a-port = Το «{ $value }» δεν είναι αριθμός θύρας (1-65535).
forward-ready-title = Η προώθηση θύρας είναι έτοιμη
forward-ready-text = Ρυθμίστε την εφαρμογή σας σε αυτή τη διεύθυνση για πρόσβαση στο { $target }:
forward-ready-note = Η θύρα παραμένει ίδια. Θα τη βρείτε στις Ρυθμίσεις.
open-remote-desktop = Άνοιγμα Απομακρυσμένης επιφάνειας εργασίας
remove-title = Κατάργηση αυτού του tailnet;
remove-text = Το { -app-name } αποσυνδέεται από το { $tailnet } και το ξεχνά σε αυτόν τον υπολογιστή. Μπορείτε να το προσθέσετε ξανά αργότερα.
remove = Κατάργηση
log-out-title = Αποσύνδεση;
log-out-text = Αποσύνδεση από το { $tailnet }; Οι διευθύνσεις του σταματούν να λειτουργούν εδώ μέχρι να συνδεθείτε ξανά.
log-out = Αποσύνδεση

## Μενού περιοχής ειδοποιήσεων (Windows, Linux) ή γραμμής μενού (macOS)

tray-sign-in = { $tailnet }: σύνδεση…
# Το $state είναι μία από τις ετικέτες state-* παραπάνω.
tray-tailnet = { $tailnet }: { $state }
tray-add-tailnet = Προσθήκη tailnet…
tray-route = Δρομολόγηση μέσω άλλων tailnet
tray-open = Άνοιγμα του { -app-name }…
tray-quit = Έξοδος
tray-tooltip = { -app-name }: { $summary }

## Ειδοποίηση την πρώτη φορά που κλείνει το παράθυρο

still-running-title = Το { -app-name } εξακολουθεί να εκτελείται
still-running-windows = Συνεχίζει τη δρομολόγηση στο παρασκήνιο. Θα το βρείτε στην περιοχή ειδοποιήσεων· τα Windows μπορεί να το κρύψουν κάτω από το βέλος ^ δίπλα στο ρολόι.
still-running-macos = Συνεχίζει τη δρομολόγηση στο παρασκήνιο. Θα το βρείτε στη γραμμή μενού.
still-running-linux = Συνεχίζει τη δρομολόγηση στο παρασκήνιο. Θα το βρείτε στην περιοχή ειδοποιήσεων του συστήματος.

## Ονόματα γλωσσών στις Ρυθμίσεις, μετά το όνομα κάθε γλώσσας στη δική της γλώσσα

english = Αγγλικά
french = Γαλλικά
german = Γερμανικά
spanish-latin-america = Ισπανικά Λατινικής Αμερικής
spanish-spain = Ισπανικά από Ισπανία
chinese-simplified = Απλοποιημένα Κινέζικα
chinese-traditional = Παραδοσιακά Κινέζικα
korean = Κορεάτικα
japanese = Ιαπωνικά
polish = Πολωνικά
russian = Ρωσικά
portuguese-brazil = Πορτογαλικά Βραζιλίας
italian = Ιταλικά
turkish = Τουρκικά
ukrainian = Ουκρανικά
czech = Τσέχικα
portuguese-portugal = Ευρωπαϊκά Πορτογαλικά
dutch = Ολλανδικά
indonesian = Ινδονησιακά
vietnamese = Βιετναμικά
thai = Ταϊλανδικά
swedish = Σουηδικά
romanian = Ρουμανικά
hungarian = Ουγγρικά
afrikaans = Αφρικάανς
catalan = Καταλανικά
serbian-cyrillic = Σερβικά, κυριλλικά
danish = Δανικά
finnish = Φινλανδικά
greek = Ελληνικά
norwegian-bokmal = Νορβηγικά Μπόκμαλ
summary-proxy-problem = Συνδέθηκε, αλλά οι εφαρμογές σας δεν το χρησιμοποιούν
hero-proxy-taken = Το πρόγραμμα περιήγησης δεν θα ανοίξει διευθύνσεις αυτών των tailnet: η ρύθμιση διακομιστή μεσολάβησης συστήματος χρησιμοποιεί άλλο σενάριο ρύθμισης ({ $script }).
hero-proxy-other-copy = Το πρόγραμμα περιήγησης δεν θα ανοίξει διευθύνσεις αυτών των tailnet: ένα άλλο αντίγραφο του { -app-name } κατέχει τη ρύθμιση διακομιστή μεσολάβησης συστήματος. Κλείστε εκείνο το αντίγραφο και θα την αναλάβει αυτό.
hero-proxy-changed = Το πρόγραμμα περιήγησης δεν θα ανοίξει διευθύνσεις αυτών των tailnet: κάτι άλλο άλλαξε τη ρύθμιση διακομιστή μεσολάβησης συστήματος.
hero-proxy-failed = Το πρόγραμμα περιήγησης δεν θα ανοίξει διευθύνσεις αυτών των tailnet: δεν ήταν δυνατή η αλλαγή της ρύθμισης διακομιστή μεσολάβησης συστήματος ({ $error }).
hero-proxy-manual = Η ρύθμιση διακομιστή μεσολάβησης συστήματος είναι ανενεργή, οπότε μόνο οι εφαρμογές που ρυθμίζετε εσείς φτάνουν σε αυτά τα tailnet. Κατευθύνετέ τες στο { $pac }
proxy-replace = Αντικατάσταση
proxy-replace-tooltip = Χρήση του σεναρίου ρύθμισης του { -app-name } όσο εκτελείται και επαναφορά του άλλου μετά
proxy-retry = Δοκιμή ξανά
proxy-retry-tooltip = Νέα κατεύθυνση της ρύθμισης διακομιστή μεσολάβησης συστήματος στο { -app-name }
system-setting = Τρέχουσα ρύθμιση διακομιστή μεσολάβησης συστήματος: { $value }
system-setting-none = καμία
check-updates = Έλεγχος για νέες εκδόσεις
find-websites = Αναζήτηση ιστότοπων στα μηχανήματα των tailnet σας
# $version is the version that's running, such as 0.6.0.
version-current = Έκδοση { $version }
update-check-now = Έλεγχος τώρα
update-checking = Έλεγχος…
update-up-to-date = Έχετε την πιο πρόσφατη έκδοση
update-check-failed = Δεν ήταν δυνατός ο έλεγχος για ενημερώσεις
tray-update = Λήψη του { -app-name } { $version }…
update-available = Κυκλοφόρησε η έκδοση { $version }
update-available-tooltip = Έχετε την έκδοση { $current }. Ανοίγει τη σελίδα λήψης.
update-notify-title = Το { -app-name } { $version } είναι διαθέσιμο
update-notify-text = Ανοίξτε το { -app-name } για να το κατεβάσετε.
migrate-failed = Δεν ήταν δυνατή η μεταφορά των συνδέσεών σας από το tailnet-proxy, την προηγούμενη έκδοση αυτής της εφαρμογής ({ $error }). Μάλλον εκτελείται ακόμα. Κλείστε το tailnet-proxy και μετά ξεκινήστε ξανά το { -app-name } πριν συνδεθείτε εδώ: μια νέα σύνδεση θα πρόσθετε αυτόν τον υπολογιστή σε κάθε tailnet για δεύτερη φορά.
