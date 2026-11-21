### Tailnet Link: Türkçe katalog.
### İngilizce kaynak: locales/en/tailnet-link.ftl; bkz. docs/translations.md.
### Tailnet Link ve Tailscale ürün adları ile "tailnet" sözcüğü (bir Tailscale ağı) değişmez.
### Ekler kesme işaretiyle eklenir (tailnet'e); değişkenlere asla ek eklenmez.

-app-name = Tailnet Link

## Pencere başlığı

tab-tailnets = Tailnet'ler
tab-settings = Ayarlar

## Ayarlar'ın altındaki kaydedilmemiş değişiklikler çubuğu

unsaved-changes = Kaydedilmemiş değişiklikleriniz var.
save = Kaydet
revert = Geri döndür
revert-tooltip = Değişiklikleri geri al
settings-saved = Ayarlar kaydedildi

## Pencerenin altındaki kısa bildirimler

# $address bir makine adı veya 127.0.0.1:port.
copied-address = Kopyalandı: { $address }
copied-sign-in-link = Oturum açma bağlantısı kopyalandı

## "Bir sorun oluştu" iletişim kutusundaki hatalar

start-failed =
    { -app-name } başlatılamıyor:
    { $error }
add-tailnet-failed =
    Tailnet eklenemedi:
    { $error }
add-forward-failed =
    Port yönlendirmesi eklenemedi:
    { $error }
remote-desktop-failed = Uzak Masaüstü başlatılamadı: { $error }
remote-desktop-windows-only = Uzak Masaüstü yalnızca Windows'ta yerleşik olarak bulunur.
no-free-port = Boş bir yerel port bulunamadı.

## "Tailnet ekle" sonrasındaki iletişim kutusu

sign-in-dialog-title = Yeni tailnet'te oturum açın
sign-in-dialog-text =
    Tarayıcınız Tailscale'in oturum açma sayfasını açıyor. Sayfa bu pencerenin arkasında açılabilir.
    
    O tailnet'e ait hesabınızla oturum açın, ardından buraya dönün. Alan adı otomatik olarak algılanır.

## Bir tailnet'in durumu, adının yanında renkli bir etiket olarak

state-waiting-sign-in = Oturum açılması bekleniyor
state-signed-out = Oturum kapalı
state-problem = Sorun
state-connecting = Bağlanıyor
state-paused = Duraklatıldı
state-no-domain = Henüz alan adı yok
state-not-routing = Yönlendirmiyor
state-routing = Yönlendiriyor

## Uygulamanın genel durumu, durum kartında ve tepsi menüsünde

summary-no-tailnets = Henüz tailnet yok
summary-paused = Duraklatıldı
# $tailnet tek tailnet'in adı.
summary-routing-one = { $tailnet } üzerinden yönlendiriliyor
# Tüm tailnet'ler yönlendiriyor; $count en az 2.
summary-routing-all =
    { $count ->
        [one] { $count } tailnet üzerinden yönlendiriliyor
       *[other] { $count } tailnet üzerinden yönlendiriliyor
    }
summary-routing-some =
    { $count ->
        [one] { $count } tailnet'ten { $routing } tanesi üzerinden yönlendiriliyor
       *[other] { $count } tailnet'ten { $routing } tanesi üzerinden yönlendiriliyor
    }
summary-signed-out = Oturum açılmadı
summary-problem = Sorun: { $problem }
summary-connecting = Bağlanıyor…
# İlk oturum açmadan önce, henüz adı olmayan bir tailnet.
new-tailnet = Yeni tailnet

## Tailnet'ler sekmesinin üstündeki durum kartı

hero-starting = Başlatılıyor…
hero-connecting = Tailnet'lerinize bağlanılıyor.
hero-paused = Şu anda diğer tailnet'ler üzerinden hiçbir şey geçmiyor. Kendi ağınız ve tailnet'iniz her zamanki gibi çalışır.
hero-finish-sign-in = { $tailnet } adlı tailnet'te oturum açmayı tarayıcınızda tamamlayın.
hero-sign-in = Makinelerine erişmek için { $tailnet } adlı tailnet'te oturum açın.
# $address bir makinenin adı, örneğin build-pc.example.ts.net.
hero-routing-example = { $address } adresini veya bu tailnet'lerdeki başka herhangi bir adresi açın. Geri kalan her şey doğrudan gider.
hero-routing = Bu tailnet'lerdeki adresler tarayıcınızda açılır. Geri kalan her şey doğrudan gider.
add-tailnet = Tailnet ekle
pause-all = Tümünü duraklat
pause-all-tooltip = Diğer tailnet'ler üzerinden yönlendirmeyi şimdilik durdur
resume = Sürdür
resume-tooltip = Diğer tailnet'ler üzerinden yönlendirmeyi yeniden başlat

## İlk çalıştırma, henüz tailnet eklenmemişken

welcome-title = Diğer tailnet'lerdeki makinelere erişin
welcome-text = Kendi tailnet'inizde kalırken aynı anda diğerlerindeki makineleri açın. Tailscale uygulamanız her zamanki gibi çalışmaya devam eder.
welcome-sign-in = Başka bir tailnet'te oturum açın
welcome-sign-in-detail = Tailscale'in oturum açma sayfası tarayıcınızda açılır.
welcome-open = Makinelerini adlarıyla açın
# $example örnek bir adres, build-pc.example.ts.net.
welcome-open-detail = { $example } gibi adresler tarayıcınızda çalışır.
welcome-forward = Bir uygulama ihtiyaç duyduğunda port yönlendirin
welcome-forward-detail = Uzak Masaüstü, SSH ve veritabanı uygulamaları bir makineye giden yerel bir port alır.

## Bir tailnet'in kartı

machine-search-hint = Ada, işletim sistemine veya adrese göre makine bulun
clear-search = Aramayı temizle
more-actions = Diğer işlemler
edit-tailnet-menu = Yeniden adlandır veya alan adı ekle…
log-out-menu = Oturumu kapat…
remove-menu = Kaldır…
sign-in = Oturum aç
pause-tailnet = Bu tailnet'i duraklat
resume-tailnet = Bu tailnet'i sürdür
detail-tailnet = Tailnet
detail-routes = Rotalar
detail-this-computer = Bu bilgisayar
detail-problem = Sorun
routes-after-sign-in = Oturum açtıktan sonra bulunur
# $hostname bu bilgisayarın tailnet'teki adı.
hostname-after-sign-in = { $hostname } (oturum açtıktan sonra)
sign-in-help = Tarayıcı açılmadı mı, yoksa yanlış profilde mi açıldı?
sign-in-open-again = Oturum açma sayfasını yeniden aç
sign-in-copy-link = Bağlantıyı kopyala
sign-in-copy-link-tooltip = Bu tailnet için kullandığınız tarayıcıya veya tarayıcı profiline yapıştırın

## Bir tailnet kartındaki makine listesi

machines-online = Makineler · { $online }/{ $total } çevrimiçi
machines-matching = Makineler · { $shown }/{ $total } eşleşiyor
no-machines = Bu tailnet'te başka makine görünmüyor.
no-machine-matches = Aramanızla eşleşen makine yok.
machine-offline = { $name } (çevrimdışı)
forward-port-tooltip = Port yönlendir: Uzak Masaüstü veya bir veritabanı istemcisi gibi proxy ayarını yok sayan uygulamalar için
copy-address = { $address } adresini kopyala
open-in-browser = { $url } adresini tarayıcınızda açın
not-routing-tooltip = Bu tailnet şu anda yönlendirme yapmıyor. Duraklatılmış olabilir mi?

## Ayarlar: port yönlendirmeleri

forwards-heading = Port yönlendirmeleri
forwards-help = Uzak Masaüstü, SSH ve veritabanı istemcileri gibi proxy ayarını yok sayan uygulamalar için. Her yönlendirme, bu bilgisayarda bir tailnet'teki bir makineye giden bir porttur.
edit-forwards = Yönlendirmeleri düzenle
# LOCALPORT, auto ve host:port olduğu gibi kalmalı: bunlar yazılan değerlerdir.
forwards-format-help = Her satıra bir tane: LOCALPORT = host:port veya boş bir port seçilmesi için auto = host:port. Hangi tailnet'in taşıyacağını makinenin adı belirler. Hızlıca eklemek için Tailnet'ler sekmesinde bir makinenin yanındaki fiş düğmesini kullanın.
forward-cant-listen = Dinlenemiyor: { $error }
forward-port-on-save = Kaydettiğinizde bir port seçilir
forward-no-tailnet = Bu ada sahip, yönlendirme yapan bir tailnet yok
# $tailnet yönlendirmeyi taşıyan tailnet.
forward-via = { $tailnet } üzerinden
open-remote-desktop-to = { $address } adresine Uzak Masaüstü bağlantısı aç

## Ayarlar: sistem proxy'si

proxy-heading = Sistem proxy ayarı
proxy-on = Açık (önerilen)
proxy-force = Açık; çalışırken şirketinizin ayarladığı proxy betiğinin de yerine geç
proxy-off = Kapalı: uygulamalarımı kendim ayarlayacağım
proxy-help-windows = “Açık” seçeneği Windows'u yalnızca uygulama çalışıp yönlendirme yaparken bu uygulamanın kurallarına yönlendirir; uygulama durduğunda, duraklatıldığında, bağlantısı kesildiğinde veya çöktüğünde her şeyi eski haline getirir.
proxy-help-macos = “Açık” seçeneği, uygulama çalışırken ağ hizmetleriniz için proxy'yi ayarlar ve sonrasında eski haline getirir. Mac'iniz bunun için yönetici parolası gerektiriyorsa, yönlendirme başladığında ve çıkış yaptığınızda parola istenir.
# Firefox'un Türkçe arayüzündeki adlar.
proxy-help-linux = “Açık” seçeneği, uygulama çalışıp yönlendirme yaparken GNOME veya KDE proxy ayarını yapar ve sonrasında eski haline getirir. Firefox'ta Ayarlar > Ağ ayarları > “Sistem vekil sunucu ayarlarını kullan” seçeneğini açın.

## Ayarlar: genel

general-heading = Genel
start-at-login = Oturum açtığımda { -app-name } uygulamasını başlat
language = Dil
system-default = Sistem varsayılanı

## Ayarlar: sorun giderme

troubleshooting-heading = Sorun giderme
troubleshooting-help = Hangi tailnet'in taşıdığını ve bağlantı kurulup kurulmadığını görmek için bir web adresini veya ad:port bilgisini test edin.
test = Test et
testing = Test ediliyor…
open-log = Günlüğü aç
open-settings-folder = Ayarlar klasörünü aç
about-line = { -app-name } { $version } · yerel proxy { $proxy } · PAC { $pac }
settings-location = Ayarların konumu: { $path }

## Sorun giderme'deki "Test et" sonuçları

check-empty = Bir makine adı veya web adresi yazın.
check-bad-port = { $input }: bu geçerli bir port değil.
check-not-routed = { $host }, { -app-name } tarafından yönlendirilmiyor: şu anda yönlendirme yapan hiçbir tailnet'in alan adıyla bitmiyor, bu yüzden doğrudan gidiyor (normal ağınız ve kendi Tailscale'iniz üzerinden).
check-gone = Bu tailnet az önce kayboldu.
check-not-running = { $tailnet } adlı tailnet çalışmıyor.
check-ok = { $address } çalışıyor: { $tailnet } üzerinden { $ms } ms içinde bağlandı.
check-failed =
    { $host }, { $tailnet } üzerinden yönlendiriliyor ancak { $port } numaralı porta bağlanılamadı: { $error }
    Makinenin çevrimiçi olduğunu ve o portu dinleyen bir şey bulunduğunu kontrol edin.
check-timeout = { $host }, { $tailnet } üzerinden yönlendiriliyor ancak { $port } numaralı port 10 saniye içinde yanıt vermedi.
# İki tailnet aynı alan adını sahipleniyor; $tailnet, rotaları kullanılan tailnet.
domain-conflict = { $domain } alan adı { $tailnet } tarafından da yönlendiriliyor; geçerli olan o.

## Yazılan ayarlardaki hatalar

forwards-line-format = Satır { $line }: LOCALPORT = host:port biçiminde yazın.
forwards-line-port = Satır { $line }: “{ $value }” bir port numarası (veya auto) değil.
forwards-line-target = Satır { $line }: “{ $value }” host:port biçiminde olmalı.
forwards-line-duplicate = Satır { $line }: { $port } yerel portu iki kez kullanılmış.
domain-invalid = “{ $domain }” bir alan adı değil; example.ts.net gibi bir şey kullanın.
domain-characters = “{ $domain }” bir alan adında bulunamayacak karakterler içeriyor.
autostart-unsupported = Oturum açıldığında başlatma bu sistemde desteklenmiyor.

## İletişim kutuları

ok = Tamam
cancel = İptal
done = Bitti
copy = Kopyala
error-title = Bir sorun oluştu
error-details = Ayrıntılar: { $path }
# $tailnet tailnet'in adı.
edit-title = Düzenle: { $tailnet }
tailnet-name = Ad
tailnet-name-hint = Bu uygulamada ve tepsi menüsünde gösterilir
extra-domains = Ek alan adları (isteğe bağlı)
extra-domains-help = Tailnet'in kendi alan adı otomatik olarak yönlendirilir. Her satıra bir tane ekleyin.
forward-dialog-title = Port yönlendir
forward-dialog-text = Bu bilgisayarda { $host } makinesine giden bir port alın. O makinedeki hangi port?
port-preset-remote-desktop = Uzak Masaüstü
port-tooltip = Port { $port }
port = Port
port-hint = ör. 8080
add-forward = Yönlendirme ekle
not-a-port = “{ $value }” bir port numarası (1-65535) değil.
forward-ready-title = Port yönlendirmesi hazır
forward-ready-text = { $target } hedefine ulaşmak için uygulamanızı bu adrese yönlendirin:
forward-ready-note = Port aynı kalır. Ayarlar'da bulabilirsiniz.
open-remote-desktop = Uzak Masaüstü'nü aç
remove-title = Bu tailnet kaldırılsın mı?
remove-text = { -app-name }, { $tailnet } adlı tailnet'teki oturumu kapatır ve onu bu bilgisayarda unutur. Daha sonra yeniden ekleyebilirsiniz.
remove = Kaldır
log-out-title = Oturum kapatılsın mı?
log-out-text = { $tailnet } adlı tailnet'teki oturum kapatılsın mı? Yeniden oturum açana kadar adresleri burada çalışmaz.
log-out = Oturumu kapat

## Tepsi (Windows, Linux) veya menü çubuğu (macOS) menüsü

tray-sign-in = { $tailnet }: oturum aç…
# $state yukarıdaki state-* etiketlerinden biri.
tray-tailnet = { $tailnet }: { $state }
tray-add-tailnet = Tailnet ekle…
tray-route = Diğer tailnet'ler üzerinden yönlendir
tray-open = { -app-name } uygulamasını aç…
tray-quit = Çık
tray-tooltip = { -app-name }: { $summary }

## Pencere ilk kez kapatıldığında gösterilen bildirim

still-running-title = { -app-name } hâlâ çalışıyor
still-running-windows = Arka planda yönlendirmeye devam ediyor. Sistem tepsisinde bulabilirsiniz; Windows onu saatin yanındaki ^ okunun altına gizleyebilir.
still-running-macos = Arka planda yönlendirmeye devam ediyor. Menü çubuğunda bulabilirsiniz.
still-running-linux = Arka planda yönlendirmeye devam ediyor. Sistem tepsisinde bulabilirsiniz.

## Ayarlar'daki dil adları, her dilin kendi adından sonra

english = İngilizce
french = Fransızca
german = Almanca
spanish-latin-america = Latin Amerika İspanyolcası
spanish-spain = İspanya İspanyolcası
chinese-simplified = Basitleştirilmiş Çince
chinese-traditional = Geleneksel Çince
korean = Korece
japanese = Japonca
polish = Lehçe
russian = Rusça
portuguese-brazil = Brezilya Portekizcesi
italian = İtalyanca
turkish = Türkçe
ukrainian = Ukraynaca
czech = Çekçe
portuguese-portugal = Portekiz Portekizcesi
dutch = Felemenkçe
indonesian = Endonezce
vietnamese = Vietnamca
thai = Tayca
swedish = İsveççe
romanian = Rumence
hungarian = Macarca
afrikaans = Afrikaanca
catalan = Katalanca
serbian-cyrillic = Sırpça, Kiril
danish = Danca
finnish = Fince
greek = Yunanca
norwegian-bokmal = Norveççe Bokmål
