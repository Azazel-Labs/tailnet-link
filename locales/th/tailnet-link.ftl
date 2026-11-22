### Tailnet Link: แค็ตตาล็อกภาษาไทย
### ต้นฉบับภาษาอังกฤษอยู่ที่ locales/en/tailnet-link.ftl ดู docs/translations.md
### คงชื่อ Tailnet Link และ Tailscale ไว้ตามเดิม และใช้คำว่า "tailnet" (เครือข่าย Tailscale) ทับศัพท์

-app-name = Tailnet Link

## ส่วนหัวของหน้าต่าง

tab-tailnets = Tailnet
tab-settings = การตั้งค่า

## แถบการเปลี่ยนแปลงที่ยังไม่ได้บันทึกที่ด้านล่างของการตั้งค่า

unsaved-changes = คุณมีการเปลี่ยนแปลงที่ยังไม่ได้บันทึก
save = บันทึก
revert = ย้อนกลับ
revert-tooltip = เลิกทำการเปลี่ยนแปลง
settings-saved = บันทึกการตั้งค่าแล้ว

## ข้อความสั้นที่ด้านล่างของหน้าต่าง

# $address คือชื่อเครื่องหรือ 127.0.0.1:พอร์ต
copied-address = คัดลอก { $address } แล้ว
copied-sign-in-link = คัดลอกลิงก์ลงชื่อเข้าใช้แล้ว

## ข้อผิดพลาดในกล่องโต้ตอบ "เกิดข้อผิดพลาด"

start-failed =
    { -app-name } เริ่มทำงานไม่ได้:
    { $error }
add-tailnet-failed =
    เพิ่ม tailnet ไม่ได้:
    { $error }
add-forward-failed =
    เพิ่มการส่งต่อพอร์ตไม่ได้:
    { $error }
remote-desktop-failed = เริ่มเดสก์ท็อประยะไกลไม่ได้: { $error }
remote-desktop-windows-only = เดสก์ท็อประยะไกลมีในตัวเฉพาะบน Windows
no-free-port = ไม่พบพอร์ตในเครื่องที่ว่างอยู่

## กล่องโต้ตอบหลังจาก "เพิ่ม tailnet"

sign-in-dialog-title = ลงชื่อเข้าใช้ tailnet ใหม่
sign-in-dialog-text =
    เบราว์เซอร์กำลังเปิดหน้าลงชื่อเข้าใช้ของ Tailscale ซึ่งอาจเปิดอยู่หลังหน้าต่างนี้
    
    ลงชื่อเข้าใช้ด้วยบัญชีของคุณสำหรับ tailnet นั้น แล้วกลับมาที่นี่ ระบบจะตรวจหาโดเมนให้โดยอัตโนมัติ

## สถานะของ tailnet แต่ละรายการ แสดงเป็นป้ายสีข้างชื่อ

state-waiting-sign-in = รอการลงชื่อเข้าใช้
state-signed-out = ออกจากระบบแล้ว
state-problem = มีปัญหา
state-connecting = กำลังเชื่อมต่อ
state-paused = หยุดชั่วคราว
state-no-domain = ยังไม่มีโดเมน
state-not-routing = ไม่ได้กำหนดเส้นทาง
state-routing = กำลังกำหนดเส้นทาง

## สถานะรวมของแอป ในการ์ดสถานะและเมนูถาด

summary-no-tailnets = ยังไม่มี tailnet
summary-paused = หยุดชั่วคราว
# $tailnet คือชื่อของ tailnet เพียงรายการเดียว
summary-routing-one = กำหนดเส้นทางผ่าน { $tailnet }
# ทุก tailnet กำลังกำหนดเส้นทาง $count มีค่าอย่างน้อย 2
summary-routing-all =
    { $count ->
       *[other] กำหนดเส้นทางผ่าน { $count } tailnet
    }
summary-routing-some =
    { $count ->
       *[other] กำหนดเส้นทางผ่าน { $routing } จาก { $count } tailnet
    }
summary-signed-out = ยังไม่ได้ลงชื่อเข้าใช้
summary-problem = ปัญหา: { $problem }
summary-connecting = กำลังเชื่อมต่อ…
# tailnet ก่อนลงชื่อเข้าใช้ครั้งแรก เมื่อยังไม่มีชื่อ
new-tailnet = tailnet ใหม่

## การ์ดสถานะที่ด้านบนของแท็บ Tailnet

hero-starting = กำลังเริ่ม…
hero-connecting = กำลังเชื่อมต่อกับ tailnet ของคุณ
hero-paused = ขณะนี้ไม่มีข้อมูลใดผ่าน tailnet อื่น เครือข่ายและ tailnet ของคุณเองยังทำงานตามปกติ
hero-finish-sign-in = ลงชื่อเข้าใช้ { $tailnet } ในเบราว์เซอร์ให้เสร็จ
hero-sign-in = ลงชื่อเข้าใช้ { $tailnet } เพื่อเข้าถึงเครื่องในนั้น
# $address คือชื่อเครื่อง เช่น build-pc.example.ts.net
hero-routing-example = เปิด { $address } หรือที่อยู่อื่นใดใน tailnet เหล่านี้ได้ ส่วนการเชื่อมต่ออื่นทั้งหมดจะไปโดยตรง
hero-routing = ที่อยู่ใน tailnet เหล่านี้เปิดได้ในเบราว์เซอร์ ส่วนการเชื่อมต่ออื่นทั้งหมดจะไปโดยตรง
add-tailnet = เพิ่ม tailnet
pause-all = หยุดทั้งหมดชั่วคราว
pause-all-tooltip = หยุดกำหนดเส้นทางผ่าน tailnet อื่นไว้ก่อน
resume = ทำต่อ
resume-tooltip = กลับมากำหนดเส้นทางผ่าน tailnet อื่นอีกครั้ง

## การเรียกใช้ครั้งแรก ก่อนเพิ่ม tailnet ใดๆ

welcome-title = เข้าถึงเครื่องใน tailnet อื่น
welcome-text = อยู่ใน tailnet ของคุณเองและเปิดเครื่องใน tailnet อื่นได้ในเวลาเดียวกัน แอป Tailscale ของคุณยังทำงานตามปกติ
welcome-sign-in = ลงชื่อเข้าใช้ tailnet อื่น
welcome-sign-in-detail = หน้าลงชื่อเข้าใช้ของ Tailscale จะเปิดในเบราว์เซอร์
welcome-open = เปิดเครื่องต่างๆ ด้วยชื่อ
# $example คือที่อยู่ตัวอย่าง build-pc.example.ts.net
welcome-open-detail = ที่อยู่อย่าง { $example } ใช้งานได้ในเบราว์เซอร์
welcome-forward = ส่งต่อพอร์ตเมื่อแอปต้องใช้
welcome-forward-detail = เดสก์ท็อประยะไกล SSH และแอปฐานข้อมูลจะได้พอร์ตในเครื่องที่นำไปยังเครื่องปลายทาง

## การ์ดของ tailnet

machine-search-hint = ค้นหาเครื่องตามชื่อ ระบบปฏิบัติการ หรือที่อยู่
clear-search = ล้างการค้นหา
more-actions = การดำเนินการเพิ่มเติม
edit-tailnet-menu = เปลี่ยนชื่อหรือเพิ่มโดเมน…
log-out-menu = ออกจากระบบ…
remove-menu = นำออก…
sign-in = ลงชื่อเข้าใช้
pause-tailnet = หยุด tailnet นี้ชั่วคราว
resume-tailnet = ใช้ tailnet นี้ต่อ
detail-tailnet = Tailnet
detail-routes = เส้นทาง
detail-this-computer = คอมพิวเตอร์เครื่องนี้
detail-problem = ปัญหา
routes-after-sign-in = จะพบหลังจากลงชื่อเข้าใช้
# $hostname คือชื่อของคอมพิวเตอร์เครื่องนี้ใน tailnet
hostname-after-sign-in = { $hostname } (หลังจากลงชื่อเข้าใช้)
sign-in-help = เบราว์เซอร์ไม่เปิด หรือเปิดผิดโปรไฟล์ใช่ไหม
sign-in-open-again = เปิดหน้าลงชื่อเข้าใช้อีกครั้ง
sign-in-copy-link = คัดลอกลิงก์
sign-in-copy-link-tooltip = วางลงในเบราว์เซอร์หรือโปรไฟล์เบราว์เซอร์ที่คุณใช้กับ tailnet นี้

## รายการเครื่องในการ์ดของ tailnet

machines-online = เครื่อง · ออนไลน์ { $online } จาก { $total }
machines-matching = เครื่อง · ตรงกัน { $shown } จาก { $total }
no-machines = ไม่เห็นเครื่องอื่นใน tailnet นี้
no-machine-matches = ไม่มีเครื่องที่ตรงกับการค้นหา
machine-offline = { $name } (ออฟไลน์)
forward-port-tooltip = ส่งต่อพอร์ต: สำหรับแอปที่ไม่ทำตามการตั้งค่าพร็อกซี เช่น เดสก์ท็อประยะไกลหรือไคลเอ็นต์ฐานข้อมูล
copy-address = คัดลอก { $address }
open-in-browser = เปิด { $url } ในเบราว์เซอร์
not-routing-tooltip = tailnet นี้ไม่ได้กำหนดเส้นทางอยู่ในขณะนี้ หยุดชั่วคราวอยู่หรือเปล่า

## การตั้งค่า: การส่งต่อพอร์ต

forwards-heading = การส่งต่อพอร์ต
forwards-help = สำหรับแอปที่ไม่ทำตามการตั้งค่าพร็อกซี เช่น เดสก์ท็อประยะไกล SSH และไคลเอ็นต์ฐานข้อมูล การส่งต่อแต่ละรายการคือพอร์ตบนคอมพิวเตอร์เครื่องนี้ที่นำไปยังเครื่องใน tailnet
edit-forwards = แก้ไขการส่งต่อ
# คง LOCALPORT, auto และ host:port ไว้ตามเดิม เพราะเป็นสิ่งที่ผู้ใช้พิมพ์
forwards-format-help = บรรทัดละหนึ่งรายการ: LOCALPORT = host:port หรือ auto = host:port เพื่อให้เลือกพอร์ตว่างให้ ชื่อโฮสต์เป็นตัวกำหนดว่า tailnet ใดรับส่งข้อมูล หากต้องการเพิ่มอย่างรวดเร็ว ให้ใช้ปุ่มปลั๊กที่เครื่องในแท็บ Tailnet
forward-cant-listen = รอรับการเชื่อมต่อไม่ได้: { $error }
forward-port-on-save = จะเลือกพอร์ตเมื่อคุณบันทึก
forward-no-tailnet = ไม่มี tailnet ที่กำลังกำหนดเส้นทางซึ่งใช้ชื่อนี้
# $tailnet คือ tailnet ที่รับส่งข้อมูลของการส่งต่อนี้
forward-via = ผ่าน { $tailnet }
open-remote-desktop-to = เปิดเดสก์ท็อประยะไกลไปยัง { $address }

## การตั้งค่า: พร็อกซีของระบบ

proxy-heading = การตั้งค่าพร็อกซีของระบบ
proxy-on = เปิด (แนะนำ)
proxy-force = เปิด และแทนที่สคริปต์พร็อกซีที่บริษัทของคุณตั้งไว้ขณะทำงาน
proxy-off = ปิด: ฉันจะตั้งค่าแอปต่างๆ เอง
proxy-help-windows = "เปิด" จะชี้ Windows ไปยังกฎของแอปนี้เฉพาะขณะที่แอปทำงานและกำหนดเส้นทางอยู่ และจะคืนค่าเดิมเมื่อแอปหยุด หยุดชั่วคราว ตัดการเชื่อมต่อ หรือขัดข้อง
proxy-help-macos = "เปิด" จะตั้งค่าพร็อกซีสำหรับบริการเครือข่ายของคุณขณะที่แอปทำงาน และคืนค่าเดิมหลังจากนั้น หาก Mac ของคุณต้องใช้รหัสผ่านผู้ดูแลระบบในการนี้ ระบบจะขอเมื่อเริ่มกำหนดเส้นทางและเมื่อคุณออกจากแอป
# ชื่อเมนูตาม Firefox ภาษาไทย
proxy-help-linux = "เปิด" จะตั้งค่าพร็อกซีของ GNOME หรือ KDE ขณะที่แอปทำงานและกำหนดเส้นทางอยู่ และคืนค่าเดิมหลังจากนั้น ใน Firefox ให้เปิด การตั้งค่า > การตั้งค่าเครือข่าย > "ใช้การตั้งค่าพร็อกซีของระบบ"

## การตั้งค่า: ทั่วไป

general-heading = ทั่วไป
start-at-login = เริ่ม { -app-name } เมื่อฉันเข้าสู่ระบบ
language = ภาษา
system-default = ค่าเริ่มต้นของระบบ

## การตั้งค่า: การแก้ไขปัญหา

troubleshooting-heading = การแก้ไขปัญหา
troubleshooting-help = ทดสอบที่อยู่เว็บหรือ ชื่อ:พอร์ต เพื่อดูว่า tailnet ใดรับส่งข้อมูลและเชื่อมต่อได้หรือไม่
test = ทดสอบ
testing = กำลังทดสอบ…
open-log = เปิดไฟล์บันทึก
open-settings-folder = เปิดโฟลเดอร์การตั้งค่า
about-line = { -app-name } { $version } · พร็อกซีในเครื่อง { $proxy } · PAC { $pac }
settings-location = การตั้งค่าอยู่ใน { $path }

## ผลของ "ทดสอบ" ในการแก้ไขปัญหา

check-empty = พิมพ์ชื่อเครื่องหรือที่อยู่เว็บ
check-bad-port = { $input }: พอร์ตไม่ถูกต้อง
check-not-routed = { -app-name } ไม่ได้กำหนดเส้นทางให้ { $host } เพราะไม่ได้ลงท้ายด้วยโดเมนของ tailnet ใดที่กำลังกำหนดเส้นทางอยู่ จึงไปโดยตรง (ผ่านเครือข่ายปกติและ Tailscale ของคุณเอง)
check-gone = tailnet นั้นเพิ่งหายไป
check-not-running = { $tailnet } ไม่ได้ทำงานอยู่
check-ok = { $address } ใช้งานได้: เชื่อมต่อผ่าน { $tailnet } ใน { $ms } ms
check-failed =
    { $host } ถูกกำหนดเส้นทางผ่าน { $tailnet } แต่เชื่อมต่อกับพอร์ต { $port } ไม่สำเร็จ: { $error }
    ตรวจสอบว่าเครื่องออนไลน์อยู่และมีโปรแกรมรอรับการเชื่อมต่อที่พอร์ตนั้น
check-timeout = { $host } ถูกกำหนดเส้นทางผ่าน { $tailnet } แต่พอร์ต { $port } ไม่ตอบสนองภายใน 10 วินาที
# มีสอง tailnet ที่อ้างสิทธิ์โดเมนเดียวกัน $tailnet คือรายการที่ใช้เส้นทาง
domain-conflict = { $tailnet } ก็กำหนดเส้นทาง { $domain } ด้วย และจะใช้ tailnet นั้น

## ข้อผิดพลาดในการตั้งค่าที่พิมพ์

forwards-line-format = บรรทัด { $line }: เขียนเป็น LOCALPORT = host:port
forwards-line-port = บรรทัด { $line }: "{ $value }" ไม่ใช่หมายเลขพอร์ต (หรือ auto)
forwards-line-target = บรรทัด { $line }: "{ $value }" ควรเป็น host:port
forwards-line-duplicate = บรรทัด { $line }: พอร์ตในเครื่อง { $port } ถูกใช้สองครั้ง
domain-invalid = "{ $domain }" ไม่ใช่โดเมน ให้ใช้รูปแบบอย่าง example.ts.net
domain-characters = "{ $domain }" มีอักขระที่ใช้ในโดเมนไม่ได้
autostart-unsupported = ระบบนี้ไม่รองรับการเริ่มเมื่อเข้าสู่ระบบ

## กล่องโต้ตอบ

ok = ตกลง
cancel = ยกเลิก
done = เสร็จสิ้น
copy = คัดลอก
error-title = เกิดข้อผิดพลาด
error-details = ดูรายละเอียดได้ใน { $path }
# $tailnet คือชื่อของ tailnet
edit-title = แก้ไข { $tailnet }
tailnet-name = ชื่อ
tailnet-name-hint = แสดงในแอปนี้และเมนูถาด
extra-domains = โดเมนเพิ่มเติม (ไม่บังคับ)
extra-domains-help = โดเมนของ tailnet เองจะถูกกำหนดเส้นทางโดยอัตโนมัติ เพิ่มบรรทัดละหนึ่งโดเมน
forward-dialog-title = ส่งต่อพอร์ต
forward-dialog-text = รับพอร์ตบนคอมพิวเตอร์เครื่องนี้ที่นำไปยัง { $host } จะใช้พอร์ตใดบนเครื่องนั้น
port-preset-remote-desktop = เดสก์ท็อประยะไกล
port-tooltip = พอร์ต { $port }
port = พอร์ต
port-hint = เช่น 8080
add-forward = เพิ่มการส่งต่อ
not-a-port = "{ $value }" ไม่ใช่หมายเลขพอร์ต (1-65535)
forward-ready-title = การส่งต่อพอร์ตพร้อมแล้ว
forward-ready-text = ตั้งค่าแอปของคุณให้ใช้ที่อยู่นี้เพื่อเข้าถึง { $target }:
forward-ready-note = พอร์ตจะคงเดิม คุณดูได้ในการตั้งค่า
open-remote-desktop = เปิดเดสก์ท็อประยะไกล
remove-title = นำ tailnet นี้ออกใช่ไหม
remove-text = { -app-name } จะออกจากระบบ { $tailnet } และลืม tailnet นี้บนคอมพิวเตอร์เครื่องนี้ คุณเพิ่มกลับได้ภายหลัง
remove = นำออก
log-out-title = ออกจากระบบใช่ไหม
log-out-text = ออกจากระบบ { $tailnet } ใช่ไหม ที่อยู่ของ tailnet นี้จะใช้ที่นี่ไม่ได้จนกว่าคุณจะลงชื่อเข้าใช้อีกครั้ง
log-out = ออกจากระบบ

## เมนูถาด (Windows, Linux) หรือแถบเมนู (macOS)

tray-sign-in = { $tailnet }: ลงชื่อเข้าใช้…
# $state คือป้าย state-* รายการใดรายการหนึ่งด้านบน
tray-tailnet = { $tailnet }: { $state }
tray-add-tailnet = เพิ่ม tailnet…
tray-route = กำหนดเส้นทางผ่าน tailnet อื่น
tray-open = เปิด { -app-name }…
tray-quit = ออก
tray-tooltip = { -app-name }: { $summary }

## การแจ้งเตือนเมื่อปิดหน้าต่างครั้งแรก

still-running-title = { -app-name } ยังทำงานอยู่
still-running-windows = แอปยังกำหนดเส้นทางอยู่เบื้องหลัง ดูได้ในถาดระบบ ซึ่ง Windows อาจซ่อนไว้ใต้ลูกศร ^ ข้างนาฬิกา
still-running-macos = แอปยังกำหนดเส้นทางอยู่เบื้องหลัง ดูได้ในแถบเมนู
still-running-linux = แอปยังกำหนดเส้นทางอยู่เบื้องหลัง ดูได้ในถาดระบบ

## ชื่อภาษาในการตั้งค่า ต่อจากชื่อของแต่ละภาษาในภาษานั้นเอง

english = อังกฤษ
french = ฝรั่งเศส
german = เยอรมัน
spanish-latin-america = สเปนแบบลาตินอเมริกา
spanish-spain = สเปนแบบสเปน
chinese-simplified = จีนตัวย่อ
chinese-traditional = จีนตัวเต็ม
korean = เกาหลี
japanese = ญี่ปุ่น
polish = โปแลนด์
russian = รัสเซีย
portuguese-brazil = โปรตุเกสแบบบราซิล
italian = อิตาลี
turkish = ตุรกี
ukrainian = ยูเครน
czech = เช็ก
portuguese-portugal = โปรตุเกสแบบโปรตุเกส
dutch = ดัตช์
indonesian = อินโดนีเซีย
vietnamese = เวียดนาม
thai = ไทย
swedish = สวีเดน
romanian = โรมาเนีย
hungarian = ฮังการี
afrikaans = แอฟริกานส์
catalan = คาตาลัน
serbian-cyrillic = เซอร์เบีย ซีริลลิก
danish = เดนมาร์ก
finnish = ฟินแลนด์
greek = กรีก
norwegian-bokmal = นอร์เวย์บุคมอล
summary-proxy-problem = เชื่อมต่อแล้ว แต่แอปของคุณไม่ได้ใช้การเชื่อมต่อนี้
hero-proxy-taken = เบราว์เซอร์จะไม่เปิดที่อยู่ของ tailnet เหล่านี้: การตั้งค่าพร็อกซีของระบบใช้สคริปต์การตั้งค่าอื่นอยู่ ({ $script })
hero-proxy-other-copy = เบราว์เซอร์จะไม่เปิดที่อยู่ของ tailnet เหล่านี้: { -app-name } อีกตัวหนึ่งครองการตั้งค่าพร็อกซีของระบบอยู่ ปิดตัวนั้นแล้วตัวนี้จะทำหน้าที่แทน
hero-proxy-changed = เบราว์เซอร์จะไม่เปิดที่อยู่ของ tailnet เหล่านี้: มีสิ่งอื่นเปลี่ยนการตั้งค่าพร็อกซีของระบบ
hero-proxy-failed = เบราว์เซอร์จะไม่เปิดที่อยู่ของ tailnet เหล่านี้: เปลี่ยนการตั้งค่าพร็อกซีของระบบไม่ได้ ({ $error })
hero-proxy-manual = การตั้งค่าพร็อกซีของระบบปิดอยู่ จึงมีเพียงแอปที่คุณตั้งค่าเองเท่านั้นที่เข้าถึง tailnet เหล่านี้ได้ ให้ชี้แอปเหล่านั้นไปที่ { $pac }
proxy-replace = แทนที่
proxy-replace-tooltip = ใช้สคริปต์การตั้งค่าของ { -app-name } ขณะที่แอปทำงาน และคืนสคริปต์เดิมหลังจากนั้น
proxy-retry = ลองอีกครั้ง
proxy-retry-tooltip = ชี้การตั้งค่าพร็อกซีของระบบไปที่ { -app-name } อีกครั้ง
system-setting = การตั้งค่าพร็อกซีของระบบตอนนี้: { $value }
system-setting-none = ไม่มี
check-updates = ตรวจหาเวอร์ชันใหม่
tray-update = ดาวน์โหลด { -app-name } { $version }…
update-available = เวอร์ชัน { $version } ออกแล้ว
update-available-tooltip = คุณใช้เวอร์ชัน { $current } อยู่ เปิดหน้าดาวน์โหลด
update-notify-title = { -app-name } { $version } พร้อมให้ใช้งานแล้ว
update-notify-text = เปิด { -app-name } เพื่อดาวน์โหลด
migrate-failed = ย้ายการลงชื่อเข้าใช้ของคุณจาก tailnet-proxy ซึ่งเป็นแอปนี้เวอร์ชันก่อนหน้าไม่ได้ ({ $error }) อาจเป็นเพราะ tailnet-proxy ยังทำงานอยู่ ให้ออกจาก tailnet-proxy แล้วเริ่ม { -app-name } ใหม่ก่อนลงชื่อเข้าใช้ที่นี่ เพราะการลงชื่อเข้าใช้อีกครั้งจะเพิ่มคอมพิวเตอร์เครื่องนี้ลงในแต่ละ tailnet เป็นครั้งที่สอง
