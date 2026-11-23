### Tailnet Link: catálogo en español latinoamericano.
### Mantén los nombres Tailnet Link y Tailscale, y la palabra “tailnet” (una red de Tailscale).

-app-name = Tailnet Link

## Cabecera de la ventana

tab-tailnets = Tailnets
tab-settings = Configuración

## Barra de cambios sin guardar, al pie de Configuración

unsaved-changes = Tienes cambios sin guardar.
save = Guardar
revert = Descartar
revert-tooltip = Deshacer los cambios
settings-saved = Configuración guardada

## Notas breves al pie de la ventana

# $address es un nombre de equipo o 127.0.0.1:puerto.
copied-address = { $address } copiado
copied-sign-in-link = Enlace de inicio de sesión copiado

## Errores mostrados en el diálogo “Algo salió mal”

start-failed =
    { -app-name } no puede iniciarse:
    { $error }
add-tailnet-failed =
    No se pudo agregar un tailnet:
    { $error }
add-forward-failed =
    No se pudo agregar la redirección de puerto:
    { $error }
remote-desktop-failed = No se pudo iniciar Escritorio remoto: { $error }
remote-desktop-windows-only = Escritorio remoto solo viene integrado en Windows.
no-free-port = No se encontró ningún puerto local libre.

## Diálogo tras “Agregar un tailnet”

sign-in-dialog-title = Inicia sesión en el nuevo tailnet
sign-in-dialog-text =
    Tu navegador está abriendo la página de inicio de sesión de Tailscale. Puede que se abra detrás de esta ventana.
    
    Inicia sesión con tu cuenta de ese tailnet y vuelve aquí. Su dominio se detecta automáticamente.

## Estado de un tailnet, mostrado como etiqueta de color junto a su nombre

state-waiting-sign-in = Esperando inicio de sesión
state-signed-out = Sesión cerrada
state-problem = Problema
state-connecting = Conectando
state-paused = En pausa
state-no-domain = Aún sin dominio
state-not-routing = Sin enrutar
state-routing = Enrutando

## Estado general de la aplicación, en la tarjeta de estado y el menú del área de notificación

summary-no-tailnets = Aún no hay tailnets
summary-paused = En pausa
# $tailnet es el nombre del único tailnet.
summary-routing-one = Enrutando a través de { $tailnet }
# Todos los tailnets enrutan; $count es al menos 2.
summary-routing-all =
    { $count ->
        [one] Enrutando a través de { $count } tailnet
       *[other] Enrutando a través de { $count } tailnets
    }
summary-routing-some =
    { $count ->
        [one] Enrutando a través de { $routing } de { $count } tailnet
       *[other] Enrutando a través de { $routing } de { $count } tailnets
    }
summary-signed-out = Sin sesión iniciada
summary-problem = Problema: { $problem }
summary-connecting = Conectando…
# Un tailnet antes de su primer inicio de sesión, cuando aún no tiene nombre.
new-tailnet = Nuevo tailnet

## Tarjeta de estado en la parte superior de la pestaña Tailnets

hero-starting = Iniciando…
hero-connecting = Conectando con tus tailnets.
hero-paused = En este momento no pasa nada por otros tailnets. Tu red y tu propio tailnet funcionan como siempre.
hero-finish-sign-in = Termina de iniciar sesión en { $tailnet } desde tu navegador.
hero-sign-in = Inicia sesión en { $tailnet } para acceder a sus equipos.
# $address es el nombre de un equipo, como build-pc.example.ts.net.
hero-routing-example = Abre { $address } o cualquier otra dirección de estos tailnets. Todo lo demás va directo.
hero-routing = Las direcciones de estos tailnets se abren en tu navegador. Todo lo demás va directo.
add-tailnet = Agregar un tailnet
pause-all = Pausar todo
pause-all-tooltip = Dejar de enrutar a través de otros tailnets por ahora
resume = Reanudar
resume-tooltip = Volver a enrutar a través de otros tailnets

## Primer uso, antes de agregar ningún tailnet

welcome-title = Accede a equipos de otros tailnets
welcome-text = Quédate en tu propio tailnet y abre equipos de otros al mismo tiempo. Tu aplicación de Tailscale sigue funcionando como siempre.
welcome-sign-in = Inicia sesión en otro tailnet
welcome-sign-in-detail = La página de inicio de sesión de Tailscale se abre en tu navegador.
welcome-open = Abre sus equipos por su nombre
# $example es una dirección de ejemplo, build-pc.example.ts.net.
welcome-open-detail = Direcciones como { $example } funcionan en tu navegador.
welcome-forward = Redirige un puerto cuando una aplicación lo necesite
welcome-forward-detail = Escritorio remoto, SSH y las aplicaciones de bases de datos obtienen un puerto local que lleva a un equipo.

## Tarjeta de un tailnet

machine-search-hint = Busca un equipo por nombre, sistema operativo o dirección
clear-search = Borrar la búsqueda
more-actions = Más acciones
edit-tailnet-menu = Cambiar nombre o agregar dominios…
log-out-menu = Cerrar sesión…
remove-menu = Quitar…
sign-in = Iniciar sesión
pause-tailnet = Pausar este tailnet
resume-tailnet = Reanudar este tailnet
detail-tailnet = Tailnet
detail-routes = Rutas
detail-this-computer = Esta computadora
detail-problem = Problema
routes-after-sign-in = Se detectan al iniciar sesión
# $hostname es el nombre de esta computadora en el tailnet.
hostname-after-sign-in = { $hostname } (al iniciar sesión)
sign-in-help = ¿El navegador no se abrió o se abrió con el perfil equivocado?
sign-in-open-again = Volver a abrir la página de inicio de sesión
sign-in-copy-link = Copiar el enlace
sign-in-copy-link-tooltip = Pégalo en el navegador, o en el perfil del navegador, que usas para este tailnet

## Lista de equipos en la tarjeta de un tailnet

machines-online = Equipos · { $online } de { $total } en línea
machines-matching = Equipos · { $shown } de { $total } coinciden
no-machines = No hay otros equipos visibles en este tailnet.
no-machine-matches = Ningún equipo coincide con tu búsqueda.
machine-offline = { $name } (sin conexión)
forward-port-tooltip = Redirigir un puerto: para aplicaciones que ignoran la configuración de proxy, como Escritorio remoto o un cliente de bases de datos
copy-address = Copiar { $address }
open-in-browser = Abrir { $url } en tu navegador
not-routing-tooltip = Este tailnet no está enrutando en este momento. ¿Está en pausa?

## Sitios web encontrados en los equipos

sites-heading = Sitios web
sites-help = Equipos de tus tailnets que sirven un sitio web por HTTPS. Cada equipo se revisa como máximo una vez al día.
# $done y $total cuentan equipos.
sites-checking = Revisando { $done } de { $total }…
sites-recheck-tooltip = Volver a revisar todos los equipos ahora
site-untrusted = Su certificado no es de confianza, así que tu navegador te mostrará una advertencia.

## Configuración: redirecciones de puertos

forwards-heading = Redirecciones de puertos
forwards-help = Para aplicaciones que ignoran la configuración de proxy, como Escritorio remoto, SSH y clientes de bases de datos. Cada redirección es un puerto de esta computadora que lleva a un equipo de un tailnet.
edit-forwards = Editar redirecciones
# Mantén LOCALPORT, auto y host:port tal cual: es lo que se escribe.
forwards-format-help = Una por línea: LOCALPORT = host:port, o auto = host:port para que se elija un puerto libre. El nombre del host decide qué tailnet la transporta. Para agregar una rápidamente, usa el botón del enchufe junto a un equipo en la pestaña Tailnets.
forward-cant-listen = No se puede escuchar: { $error }
forward-port-on-save = Se elige un puerto al guardar
forward-no-tailnet = Ningún tailnet activo tiene este nombre
# $tailnet es el tailnet que transporta la redirección.
forward-via = a través de { $tailnet }
open-remote-desktop-to = Abrir Escritorio remoto a { $address }

## Configuración: proxy del sistema

proxy-heading = Configuración de proxy del sistema
proxy-on = Activado (recomendado)
proxy-force = Activado, y sustituir el script de proxy de tu empresa mientras se ejecuta
proxy-off = Desactivado: configuro mis aplicaciones por mi cuenta
proxy-help-windows = “Activado” dirige Windows a las reglas de esta aplicación solo mientras se ejecuta y enruta, y lo restablece todo cuando se cierra, se pausa, se desconecta o falla.
proxy-help-macos = “Activado” configura el proxy de tus servicios de red mientras la aplicación se ejecuta y lo restablece después. Si tu Mac necesita una contraseña de administrador para ello, se te pedirá al empezar a enrutar y al salir.
proxy-help-linux = “Activado” configura el proxy de GNOME o KDE mientras la aplicación se ejecuta y enruta, y lo restablece después. En Firefox, activa Configuración > Configuración de red > “Usar configuración de proxy del sistema”.

## Configuración: general

general-heading = General
start-at-login = Abrir { -app-name } al iniciar sesión
language = Idioma
system-default = Idioma del sistema

## Configuración: solución de problemas

troubleshooting-heading = Solución de problemas
troubleshooting-help = Prueba una dirección web o nombre:puerto para ver qué tailnet la transporta y si se conecta.
test = Probar
testing = Probando…
open-log = Abrir registro
open-settings-folder = Abrir carpeta de configuración
about-line = { -app-name } { $version } · proxy local { $proxy } · PAC { $pac }
settings-location = Configuración en { $path }

## Resultados de “Probar” en Solución de problemas

check-empty = Escribe un nombre de equipo o una dirección web.
check-bad-port = { $input }: no es un puerto válido.
check-not-routed = { -app-name } no enruta { $host }: no termina en el dominio de ningún tailnet que esté enrutando en este momento, así que va directo (por tu red normal y tu propio Tailscale).
check-gone = Ese tailnet acaba de desaparecer.
check-not-running = { $tailnet } no se está ejecutando.
check-ok = { $address } funciona: conectado a través de { $tailnet } en { $ms } ms.
check-failed =
    { $host } se enruta a través de { $tailnet }, pero la conexión al puerto { $port } falló: { $error }
    Verifica que el equipo está en línea y que algo escucha en ese puerto.
check-timeout = { $host } se enruta a través de { $tailnet }, pero el puerto { $port } no respondió en 10 segundos.
# Dos tailnets reclaman el mismo dominio; $tailnet es aquel cuyas rutas se usan.
domain-conflict = { $tailnet } también enruta { $domain }; prevalece ese.

## Errores en la configuración escrita

forwards-line-format = Línea { $line }: escribe LOCALPORT = host:port.
forwards-line-port = Línea { $line }: “{ $value }” no es un número de puerto (ni auto).
forwards-line-target = Línea { $line }: “{ $value }” debería ser host:port.
forwards-line-duplicate = Línea { $line }: el puerto local { $port } se usa dos veces.
domain-invalid = “{ $domain }” no es un dominio; usa algo como example.ts.net.
domain-characters = “{ $domain }” contiene caracteres que un dominio no puede tener.
autostart-unsupported = Este sistema no permite abrir la aplicación al iniciar sesión.

## Diálogos

ok = Aceptar
cancel = Cancelar
done = Listo
copy = Copiar
error-title = Algo salió mal
error-details = Detalles en { $path }
# $tailnet es el nombre del tailnet.
edit-title = Editar { $tailnet }
tailnet-name = Nombre
tailnet-name-hint = Se muestra en esta aplicación y en el menú del área de notificación
extra-domains = Dominios adicionales (opcional)
extra-domains-help = El dominio propio del tailnet se enruta automáticamente. Agrega uno por línea.
forward-dialog-title = Redirigir un puerto
forward-dialog-text = Obtén un puerto en esta computadora que lleve a { $host }. ¿Qué puerto de ese equipo?
port-preset-remote-desktop = Escritorio remoto
port-tooltip = Puerto { $port }
port = Puerto
port-hint = p. ej., 8080
add-forward = Agregar redirección
not-a-port = “{ $value }” no es un número de puerto (1-65535).
forward-ready-title = Redirección de puerto lista
forward-ready-text = Apunta tu aplicación a esta dirección para llegar a { $target }:
forward-ready-note = El puerto no cambia. Lo encontrarás en Configuración.
open-remote-desktop = Abrir Escritorio remoto
remove-title = ¿Quitar este tailnet?
remove-text = { -app-name } cierra la sesión de { $tailnet } y lo olvida en esta computadora. Puedes volver a agregarlo más adelante.
remove = Quitar
log-out-title = ¿Cerrar sesión?
log-out-text = ¿Cerrar sesión en { $tailnet }? Sus direcciones dejarán de funcionar aquí hasta que vuelvas a iniciar sesión.
log-out = Cerrar sesión

## Menú del área de notificación (Windows, Linux) o de la barra de menús (macOS)

tray-sign-in = { $tailnet }: iniciar sesión…
# $state es una de las etiquetas state-* anteriores.
tray-tailnet = { $tailnet }: { $state }
tray-add-tailnet = Agregar un tailnet…
tray-route = Enrutar a través de otros tailnets
tray-open = Abrir { -app-name }…
tray-quit = Salir
tray-tooltip = { -app-name }: { $summary }

## Notificación la primera vez que se cierra la ventana

still-running-title = { -app-name } sigue en ejecución
still-running-windows = Sigue enrutando en segundo plano. Lo encontrarás en el área de notificación; Windows puede esconderlo bajo la flecha ^ junto al reloj.
still-running-macos = Sigue enrutando en segundo plano. Lo encontrarás en la barra de menús.
still-running-linux = Sigue enrutando en segundo plano. Lo encontrarás en el área de notificación.

## Nombres de idiomas en Configuración, después del nombre propio de cada idioma

english = Inglés
french = Francés
german = Alemán
spanish-latin-america = Español latinoamericano
spanish-spain = Español de España
chinese-simplified = Chino simplificado
chinese-traditional = Chino tradicional
korean = Coreano
japanese = Japonés
polish = Polaco
russian = Ruso
portuguese-brazil = Portugués de Brasil
italian = Italiano
turkish = Turco
ukrainian = Ucraniano
czech = Checo
portuguese-portugal = Portugués de Portugal
dutch = Neerlandés
indonesian = Indonesio
vietnamese = Vietnamita
thai = Tailandés
swedish = Sueco
romanian = Rumano
hungarian = Húngaro
afrikaans = Afrikáans
catalan = Catalán
serbian-cyrillic = Serbio, cirílico
danish = Danés
finnish = Finés
greek = Griego
norwegian-bokmal = Noruego bokmal
summary-proxy-problem = Conectado, pero tus aplicaciones no lo usan
hero-proxy-taken = Tu navegador no abrirá las direcciones de estos tailnets: la configuración de proxy del sistema usa otro script de configuración ({ $script }).
hero-proxy-other-copy = Tu navegador no abrirá las direcciones de estos tailnets: otra copia de { -app-name } tiene la configuración de proxy del sistema. Cierra esa copia y esta tomará el control.
hero-proxy-changed = Tu navegador no abrirá las direcciones de estos tailnets: otra cosa cambió la configuración de proxy del sistema.
hero-proxy-failed = Tu navegador no abrirá las direcciones de estos tailnets: no se pudo cambiar la configuración de proxy del sistema ({ $error }).
hero-proxy-manual = La configuración de proxy del sistema está desactivada, así que solo las aplicaciones que configures tú llegan a estos tailnets. Dirígelas a { $pac }
proxy-replace = Reemplazarlo
proxy-replace-tooltip = Usar el script de configuración de { -app-name } mientras se ejecuta y restaurar el otro después
proxy-retry = Reintentar
proxy-retry-tooltip = Volver a dirigir la configuración de proxy del sistema a { -app-name }
system-setting = Configuración de proxy del sistema actual: { $value }
system-setting-none = ninguno
check-updates = Buscar nuevas versiones
find-websites = Buscar sitios web en los equipos de tus tailnets
# $version is the version that's running, such as 0.6.0.
version-current = Versión { $version }
update-check-now = Buscar ahora
update-checking = Buscando…
update-up-to-date = Tienes la versión más reciente
update-check-failed = No se pudieron buscar actualizaciones
tray-update = Descargar { -app-name } { $version }…
update-available = Versión { $version } disponible
update-available-tooltip = Tienes la versión { $current }. Abre la página de descarga.
update-notify-title = { -app-name } { $version } está disponible
update-notify-text = Abre { -app-name } para descargarlo.
migrate-failed = No se pudieron transferir tus inicios de sesión de tailnet-proxy, la versión anterior de esta aplicación ({ $error }). Probablemente siga en ejecución. Cierra tailnet-proxy y vuelve a abrir { -app-name } antes de iniciar sesión aquí: iniciar sesión de nuevo agregaría esta computadora a cada tailnet por segunda vez.
