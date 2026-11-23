### Tailnet Link: katalog bahasa Indonesia.
### Sumber bahasa Inggris ada di locales/en/tailnet-link.ftl; lihat docs/translations.md.
### Pertahankan nama produk Tailnet Link dan Tailscale, serta kata "tailnet" (jaringan Tailscale).

-app-name = Tailnet Link

## Kepala jendela

tab-tailnets = Tailnet
tab-settings = Pengaturan

## Bilah perubahan yang belum disimpan di bagian bawah Pengaturan

unsaved-changes = Ada perubahan yang belum disimpan.
save = Simpan
revert = Kembalikan
revert-tooltip = Batalkan perubahan
settings-saved = Pengaturan disimpan

## Catatan singkat di bagian bawah jendela

# $address adalah nama mesin atau 127.0.0.1:port.
copied-address = { $address } disalin
copied-sign-in-link = Tautan masuk disalin

## Kesalahan yang ditampilkan dalam dialog "Terjadi kesalahan"

start-failed =
    { -app-name } tidak dapat dimulai:
    { $error }
add-tailnet-failed =
    Tidak dapat menambahkan tailnet:
    { $error }
add-forward-failed =
    Tidak dapat menambahkan penerusan port:
    { $error }
remote-desktop-failed = Tidak dapat memulai Desktop Jarak Jauh: { $error }
remote-desktop-windows-only = Desktop Jarak Jauh hanya tersedia bawaan di Windows.
no-free-port = Tidak dapat menemukan port lokal yang kosong.

## Dialog setelah "Tambahkan tailnet"

sign-in-dialog-title = Masuk ke tailnet baru
sign-in-dialog-text =
    Browser Anda sedang membuka halaman masuk Tailscale. Halaman itu mungkin terbuka di belakang jendela ini.
    
    Masuk dengan akun Anda untuk tailnet tersebut, lalu kembali ke sini. Domainnya dideteksi secara otomatis.

## Status satu tailnet, ditampilkan sebagai label berwarna di samping namanya

state-waiting-sign-in = Menunggu masuk
state-signed-out = Sudah keluar
state-problem = Masalah
state-connecting = Menghubungkan
state-paused = Dijeda
state-no-domain = Belum ada domain
state-not-routing = Tidak merutekan
state-routing = Merutekan

## Status seluruh aplikasi, di kartu status dan menu baki

summary-no-tailnets = Belum ada tailnet
summary-paused = Dijeda
# $tailnet adalah nama satu-satunya tailnet.
summary-routing-one = Merutekan melalui { $tailnet }
# Semua tailnet sedang merutekan; $count minimal 2.
summary-routing-all =
    { $count ->
       *[other] Merutekan melalui { $count } tailnet
    }
summary-routing-some =
    { $count ->
       *[other] Merutekan melalui { $routing } dari { $count } tailnet
    }
summary-signed-out = Belum masuk
summary-problem = Masalah: { $problem }
summary-connecting = Menghubungkan…
# Tailnet sebelum masuk pertama kali, saat belum punya nama.
new-tailnet = Tailnet baru

## Kartu status di bagian atas tab Tailnet

hero-starting = Memulai…
hero-connecting = Menghubungkan ke tailnet Anda.
hero-paused = Saat ini tidak ada yang melewati tailnet lain. Jaringan dan tailnet Anda sendiri berfungsi seperti biasa.
hero-finish-sign-in = Selesaikan proses masuk ke { $tailnet } di browser Anda.
hero-sign-in = Masuk ke { $tailnet } untuk menjangkau mesin-mesinnya.
# $address adalah nama mesin, misalnya build-pc.example.ts.net.
hero-routing-example = Buka { $address } atau alamat lain di tailnet ini. Selebihnya berjalan langsung.
hero-routing = Alamat di tailnet ini terbuka di browser Anda. Selebihnya berjalan langsung.
add-tailnet = Tambahkan tailnet
pause-all = Jeda semua
pause-all-tooltip = Hentikan perutean melalui tailnet lain untuk sementara
resume = Lanjutkan
resume-tooltip = Mulai lagi perutean melalui tailnet lain

## Penggunaan pertama, sebelum ada tailnet yang ditambahkan

welcome-title = Jangkau mesin di tailnet lain
welcome-text = Tetap di tailnet Anda sendiri sambil membuka mesin di tailnet lain secara bersamaan. Aplikasi Tailscale Anda tetap berfungsi seperti biasa.
welcome-sign-in = Masuk ke tailnet lain
welcome-sign-in-detail = Halaman masuk Tailscale terbuka di browser Anda.
welcome-open = Buka mesinnya berdasarkan nama
# $example adalah contoh alamat, build-pc.example.ts.net.
welcome-open-detail = Alamat seperti { $example } berfungsi di browser Anda.
welcome-forward = Teruskan port saat aplikasi membutuhkannya
welcome-forward-detail = Desktop Jarak Jauh, SSH, dan aplikasi basis data mendapat port lokal yang mengarah ke sebuah mesin.

## Kartu tailnet

machine-search-hint = Cari mesin berdasarkan nama, OS, atau alamat
clear-search = Hapus pencarian
open-terminal-tooltip = Buka terminal tempat nama-nama di tailnet Anda berfungsi, untuk curl, git, ssh, ping, dan lainnya. Atau tambahkan tl di depan perintah apa pun di terminal mana pun.
open-terminal-missing = { -app-name } tidak dapat menemukan tl, alat bantu terminalnya, di samping aplikasi. Instal ulang { -app-name } untuk mendapatkannya.
open-terminal-failed = Tidak dapat membuka terminal: { $error }
more-actions = Tindakan lainnya
edit-tailnet-menu = Ganti nama atau tambahkan domain…
log-out-menu = Keluar…
remove-menu = Hapus…
sign-in = Masuk
pause-tailnet = Jeda tailnet ini
resume-tailnet = Lanjutkan tailnet ini
detail-tailnet = Tailnet
detail-routes = Rute
detail-this-computer = Komputer ini
detail-problem = Masalah
routes-after-sign-in = Ditemukan setelah Anda masuk
# $hostname adalah nama komputer ini di tailnet.
hostname-after-sign-in = { $hostname } (setelah Anda masuk)
sign-in-help = Browser tidak terbuka, atau terbuka di profil yang salah?
sign-in-open-again = Buka lagi halaman masuk
sign-in-copy-link = Salin tautan
sign-in-copy-link-tooltip = Tempelkan ke browser, atau profil browser, yang Anda gunakan untuk tailnet ini

## Daftar mesin di kartu tailnet

machines-online = Mesin · { $online } dari { $total } daring
machines-matching = Mesin · { $shown } dari { $total } cocok
no-machines = Tidak ada mesin lain yang terlihat di tailnet ini.
no-machine-matches = Tidak ada mesin yang cocok dengan pencarian Anda.
machine-offline = { $name } (luring)
forward-port-tooltip = Teruskan port: untuk aplikasi yang mengabaikan pengaturan proksi, seperti Desktop Jarak Jauh atau klien basis data
copy-address = Salin { $address }
open-in-browser = Buka { $url } di browser Anda
not-routing-tooltip = Tailnet ini sedang tidak merutekan. Apakah sedang dijeda?

## Situs web yang ditemukan di mesin

sites-heading = Situs web
sites-help = Mesin di tailnet Anda yang menyajikan situs web melalui HTTPS. Setiap mesin diperiksa paling banyak sekali sehari.
# $done dan $total menghitung mesin.
sites-checking = Memeriksa { $done } dari { $total }…
sites-recheck-tooltip = Periksa ulang semua mesin sekarang
site-untrusted = Sertifikatnya tidak tepercaya, jadi browser Anda akan menampilkan peringatan.
site-favorite-add = Tambahkan ke favorit
site-favorite-remove = Hapus dari favorit
sites-show-all = Tampilkan semua situs web ({ $count })
sites-show-fewer = Tampilkan lebih sedikit

## Pengaturan: penerusan port

forwards-heading = Penerusan port
forwards-help = Untuk aplikasi yang mengabaikan pengaturan proksi, seperti Desktop Jarak Jauh, SSH, dan klien basis data. Setiap penerusan adalah port di komputer ini yang mengarah ke sebuah mesin di tailnet.
edit-forwards = Edit penerusan
# Biarkan LOCALPORT, auto, dan host:port apa adanya: itulah yang diketik.
forwards-format-help = Satu per baris: LOCALPORT = host:port, atau auto = host:port agar port kosong dipilihkan. Nama host menentukan tailnet mana yang membawanya. Untuk menambahkan dengan cepat, gunakan tombol colokan pada mesin di tab Tailnet.
forward-cant-listen = Tidak dapat mendengarkan: { $error }
forward-port-on-save = Port dipilih saat Anda menyimpan
forward-no-tailnet = Tidak ada tailnet yang sedang merutekan dengan nama ini
# $tailnet adalah tailnet yang membawa penerusan ini.
forward-via = melalui { $tailnet }
open-remote-desktop-to = Buka Desktop Jarak Jauh ke { $address }

## Pengaturan: proksi sistem

proxy-heading = Pengaturan proksi sistem
proxy-on = Aktif (disarankan)
proxy-force = Aktif, dan ganti skrip proksi dari perusahaan Anda selama berjalan
proxy-off = Nonaktif: saya akan mengatur aplikasi sendiri
proxy-help-windows = "Aktif" mengarahkan Windows ke aturan aplikasi ini hanya selama aplikasi berjalan dan merutekan, lalu mengembalikan semuanya saat aplikasi berhenti, dijeda, terputus, atau mogok.
proxy-help-macos = "Aktif" mengatur proksi untuk layanan jaringan Anda selama aplikasi berjalan, lalu mengembalikannya setelahnya. Jika Mac Anda memerlukan kata sandi admin untuk itu, Anda akan dimintai kata sandi saat perutean dimulai dan saat Anda keluar.
# Label menu sesuai Firefox bahasa Indonesia.
proxy-help-linux = "Aktif" mengatur proksi GNOME atau KDE selama aplikasi berjalan dan merutekan, lalu mengembalikannya setelahnya. Di Firefox, aktifkan Pengaturan > Setelan Jaringan > "Gunakan pengaturan proksi dari sistem".

## Pengaturan: umum

general-heading = Umum
start-at-login = Jalankan { -app-name } saat saya masuk
language = Bahasa
system-default = Bawaan sistem

## Pengaturan: pemecahan masalah

troubleshooting-heading = Pemecahan masalah
troubleshooting-help = Uji alamat web atau nama:port untuk melihat tailnet mana yang membawanya dan apakah koneksinya berhasil.
test = Uji
testing = Menguji…
open-log = Buka log
open-settings-folder = Buka folder pengaturan
about-line = { -app-name } { $version } · proksi lokal { $proxy } · PAC { $pac }
settings-location = Pengaturan di { $path }

## Pengaturan: nama

names-heading = Nama
names-help = Nama Anda sendiri untuk alamat di tailnet Anda, seperti server di balik router subnet. Nama ini hanya berfungsi di browser dan penerusan port di komputer ini.
edit-names = Edit nama
# Biarkan "name = address" dan contohnya apa adanya: itulah yang diketik.
names-format-help = Satu per baris: name = address, misalnya wiki = 192.168.20.15. Alamatnya bisa berupa alamat IP atau nama mesin. Buka sebagai http://wiki:8080/, dengan port yang dipakai situs web tersebut.

## Hasil "Uji" di Pemecahan masalah

check-empty = Ketik nama mesin atau alamat web.
check-bad-port = { $input }: itu bukan port yang valid.
check-not-routed = { $host } tidak dirutekan oleh { -app-name }: ini bukan nama, alamat, atau subnet dari tailnet mana pun yang sedang merutekan, jadi lalu lintasnya berjalan langsung (melalui jaringan biasa dan Tailscale Anda sendiri).
# $tailnets berisi daftar tailnet, dipisahkan koma.
check-ambiguous = { $host } ada di lebih dari satu tailnet ({ $tailnets }), jadi tidak dirutekan. Gunakan nama mesinnya, atau matikan subnet untuk salah satu tailnet tersebut.
check-gone = Tailnet itu baru saja hilang.
check-not-running = { $tailnet } tidak berjalan.
ping-no-machine = { $host } melewati { $tailnet }, tetapi bukan salah satu mesinnya, jadi tidak ada yang bisa di-ping oleh Tailscale.
check-ok = { $address } berfungsi: terhubung melalui { $tailnet } dalam { $ms } ms.
check-failed =
    { $host } dirutekan melalui { $tailnet }, tetapi koneksi ke port { $port } gagal: { $error }
    Pastikan mesin sedang daring dan ada yang mendengarkan di port tersebut.
check-timeout = { $host } dirutekan melalui { $tailnet }, tetapi port { $port } tidak menjawab dalam 10 detik.
# Dua tailnet mengklaim domain yang sama; $tailnet adalah yang rutenya dipakai.
domain-conflict = { $domain } juga dirutekan oleh { $tailnet }; tailnet itulah yang dipakai.

## Kesalahan dalam pengaturan yang diketik

forwards-line-format = Baris { $line }: tulis LOCALPORT = host:port.
forwards-line-port = Baris { $line }: “{ $value }” bukan nomor port (atau auto).
forwards-line-target = Baris { $line }: “{ $value }” seharusnya host:port.
forwards-line-duplicate = Baris { $line }: port lokal { $port } digunakan dua kali.
domain-invalid = “{ $domain }” bukan domain; gunakan sesuatu seperti example.ts.net.
domain-characters = “{ $domain }” berisi karakter yang tidak boleh ada dalam domain.
names-line-format = Baris { $line }: tulis name = address.
names-line-name = Baris { $line }: “{ $value }” tidak bisa menjadi nama. Gunakan huruf, angka, tanda hubung, dan titik.
names-line-target = Baris { $line }: “{ $value }” bukan alamat IP atau nama mesin.
names-line-duplicate = Baris { $line }: nama { $value } muncul dua kali.
autostart-unsupported = Memulai saat masuk tidak didukung di sistem ini.

## Dialog

ok = OK
cancel = Batal
done = Selesai
copy = Salin
error-title = Terjadi kesalahan
error-details = Detail ada di { $path }
# $tailnet adalah nama tailnet.
edit-title = Edit { $tailnet }
tailnet-name = Nama
tailnet-name-hint = Ditampilkan di aplikasi ini dan menu baki
extra-domains = Domain tambahan (opsional)
extra-domains-help = Domain milik tailnet itu sendiri dirutekan secara otomatis. Tambahkan satu per baris.
route-subnets = Rutekan subnetnya
route-subnets-help = Jaringan yang dijangkau tailnet ini melalui router subnetnya, seperti jaringan cloud. Matikan ini jika salah satunya tumpang tindih dengan jaringan tempat komputer ini berada.
forward-dialog-title = Teruskan port
forward-dialog-text = Dapatkan port di komputer ini yang mengarah ke { $host }. Port mana di mesin itu?
port-preset-remote-desktop = Desktop Jarak Jauh
port-tooltip = Port { $port }
port = Port
port-hint = mis. 8080
add-forward = Tambahkan penerusan
not-a-port = “{ $value }” bukan nomor port (1-65535).
forward-ready-title = Penerusan port siap
forward-ready-text = Arahkan aplikasi Anda ke alamat ini untuk menjangkau { $target }:
forward-ready-note = Port-nya tetap sama. Anda dapat menemukannya di Pengaturan.
open-remote-desktop = Buka Desktop Jarak Jauh
remove-title = Hapus tailnet ini?
remove-text = { -app-name } akan keluar dari { $tailnet } dan melupakannya di komputer ini. Anda dapat menambahkannya lagi nanti.
remove = Hapus
log-out-title = Keluar?
log-out-text = Keluar dari { $tailnet }? Alamat-alamatnya berhenti berfungsi di sini sampai Anda masuk lagi.
log-out = Keluar

## Menu baki (Windows, Linux) atau bilah menu (macOS)

tray-sign-in = { $tailnet }: masuk…
# $state adalah salah satu label state-* di atas.
tray-tailnet = { $tailnet }: { $state }
tray-add-tailnet = Tambahkan tailnet…
tray-route = Rutekan melalui tailnet lain
tray-open = Buka { -app-name }…
tray-quit = Keluar
tray-tooltip = { -app-name }: { $summary }

## Notifikasi saat jendela pertama kali ditutup

still-running-title = { -app-name } masih berjalan
still-running-windows = Aplikasi tetap merutekan di latar belakang. Temukan di baki sistem; Windows mungkin menyembunyikannya di bawah panah ^ di dekat jam.
still-running-macos = Aplikasi tetap merutekan di latar belakang. Temukan di bilah menu.
still-running-linux = Aplikasi tetap merutekan di latar belakang. Temukan di baki sistem.

## Nama bahasa di Pengaturan, setelah nama asli setiap bahasa

english = Bahasa Inggris
french = Bahasa Prancis
german = Bahasa Jerman
spanish-latin-america = Bahasa Spanyol Amerika Latin
spanish-spain = Bahasa Spanyol dari Spanyol
chinese-simplified = Bahasa Tionghoa Sederhana
chinese-traditional = Bahasa Tionghoa Tradisional
korean = Bahasa Korea
japanese = Bahasa Jepang
polish = Bahasa Polandia
russian = Bahasa Rusia
portuguese-brazil = Bahasa Portugis Brasil
italian = Bahasa Italia
turkish = Bahasa Turki
ukrainian = Bahasa Ukraina
czech = Bahasa Ceko
portuguese-portugal = Bahasa Portugis Eropa
dutch = Bahasa Belanda
indonesian = Bahasa Indonesia
vietnamese = Bahasa Vietnam
thai = Bahasa Thai
swedish = Bahasa Swedia
romanian = Bahasa Rumania
hungarian = Bahasa Hungaria
afrikaans = Bahasa Afrikaans
catalan = Bahasa Katala
serbian-cyrillic = Bahasa Serbia, Sirilik
danish = Bahasa Denmark
finnish = Bahasa Finlandia
greek = Bahasa Yunani
norwegian-bokmal = Bahasa Norwegia Bokmål
summary-proxy-problem = Terhubung, tetapi aplikasi Anda tidak menggunakannya
hero-proxy-taken = Browser Anda tidak akan membuka alamat di tailnet ini: pengaturan proksi sistem menggunakan skrip penyiapan lain ({ $script }).
hero-proxy-other-copy = Browser Anda tidak akan membuka alamat di tailnet ini: salinan { -app-name } yang lain sedang memegang pengaturan proksi sistem. Tutup salinan itu, lalu salinan ini akan mengambil alih.
hero-proxy-changed = Browser Anda tidak akan membuka alamat di tailnet ini: sesuatu yang lain telah mengubah pengaturan proksi sistem.
hero-proxy-failed = Browser Anda tidak akan membuka alamat di tailnet ini: pengaturan proksi sistem tidak dapat diubah ({ $error }).
hero-proxy-manual = Pengaturan proksi sistem nonaktif, jadi hanya aplikasi yang Anda atur sendiri yang dapat menjangkau tailnet ini. Arahkan aplikasi tersebut ke { $pac }
proxy-replace = Ganti
proxy-replace-tooltip = Gunakan skrip penyiapan { -app-name } selama aplikasi berjalan, lalu kembalikan skrip yang lain setelahnya
proxy-retry = Coba lagi
proxy-retry-tooltip = Arahkan lagi pengaturan proksi sistem ke { -app-name }
system-setting = Pengaturan proksi sistem saat ini: { $value }
system-setting-none = tidak ada
check-updates = Periksa versi baru
find-websites = Cari situs web di mesin dalam tailnet Anda
# $version is the version that's running, such as 0.6.0.
version-current = Versi { $version }
update-check-now = Periksa sekarang
update-checking = Memeriksa…
update-up-to-date = Anda memakai versi terbaru
update-check-failed = Tidak dapat memeriksa pembaruan
tray-update = Unduh { -app-name } { $version }…
update-available = Versi { $version } sudah rilis
update-available-tooltip = Versi Anda { $current }. Membuka halaman unduhan.
update-notify-title = { -app-name } { $version } sudah tersedia
update-notify-text = Buka { -app-name } untuk mengunduhnya.
migrate-failed = Sesi masuk Anda dari tailnet-proxy, versi lama aplikasi ini, tidak dapat dipindahkan ({ $error }). Aplikasi itu mungkin masih berjalan. Tutup tailnet-proxy, lalu jalankan ulang { -app-name } sebelum Anda masuk di sini: masuk lagi akan menambahkan komputer ini ke setiap tailnet untuk kedua kalinya.
