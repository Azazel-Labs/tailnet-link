### Tailnet Link: catálogo em português do Brasil.
### Mantenha os nomes Tailnet Link e Tailscale e a palavra "tailnet" (uma rede do Tailscale).

-app-name = Tailnet Link

## Cabeçalho da janela

tab-tailnets = Tailnets
tab-settings = Configurações

## Barra de alterações não salvas no rodapé de Configurações

unsaved-changes = Você tem alterações não salvas.
save = Salvar
revert = Reverter
revert-tooltip = Desfazer as alterações
settings-saved = Configurações salvas

## Avisos curtos no rodapé da janela

copied-address = { $address } copiado
copied-sign-in-link = Link de login copiado

## Erros mostrados na caixa "Algo deu errado"

start-failed =
    O { -app-name } não conseguiu iniciar:
    { $error }
add-tailnet-failed =
    Não foi possível adicionar uma tailnet:
    { $error }
add-forward-failed =
    Não foi possível adicionar o encaminhamento de porta:
    { $error }
remote-desktop-failed = Não foi possível iniciar a Área de Trabalho Remota: { $error }
remote-desktop-windows-only = A Área de Trabalho Remota só vem integrada no Windows.
no-free-port = Não foi possível encontrar uma porta local livre.

## Caixa exibida após "Adicionar tailnet"

sign-in-dialog-title = Faça login na nova tailnet
sign-in-dialog-text =
    Seu navegador está abrindo a página de login do Tailscale. Ela pode aparecer atrás desta janela.
    
    Faça login com a sua conta dessa tailnet e depois volte aqui. O domínio dela é detectado automaticamente.

## Estado de uma tailnet, como etiqueta colorida ao lado do nome

state-waiting-sign-in = Aguardando login
state-signed-out = Sessão encerrada
state-problem = Problema
state-connecting = Conectando
state-paused = Em pausa
state-no-domain = Ainda sem domínio
state-not-routing = Sem roteamento
state-routing = Roteando

## Estado geral do aplicativo, no cartão de status e no menu da bandeja

summary-no-tailnets = Nenhuma tailnet ainda
summary-paused = Em pausa
summary-routing-one = Roteando via { $tailnet }
summary-routing-all =
    { $count ->
        [one] Roteando via { $count } tailnet
       *[other] Roteando via { $count } tailnets
    }
summary-routing-some =
    { $count ->
        [one] Roteando via { $routing } de { $count } tailnet
       *[other] Roteando via { $routing } de { $count } tailnets
    }
summary-signed-out = Sem login
summary-problem = Problema: { $problem }
summary-connecting = Conectando…
new-tailnet = Nova tailnet

## Cartão de status no topo da aba Tailnets

hero-starting = Iniciando…
hero-connecting = Conectando às suas tailnets.
hero-paused = Nada passa pelas outras tailnets agora. Sua rede e a sua tailnet funcionam normalmente.
hero-finish-sign-in = Conclua o login em { $tailnet } no seu navegador.
hero-sign-in = Faça login em { $tailnet } para acessar as máquinas dela.
hero-routing-example = Abra { $address } ou qualquer outro endereço dessas tailnets. Todo o resto vai direto.
hero-routing = Os endereços dessas tailnets abrem no seu navegador. Todo o resto vai direto.
add-tailnet = Adicionar tailnet
pause-all = Pausar tudo
pause-all-tooltip = Parar de rotear pelas outras tailnets por enquanto
resume = Retomar
resume-tooltip = Voltar a rotear pelas outras tailnets

## Primeira execução, antes de adicionar qualquer tailnet

welcome-title = Acesse máquinas em outras tailnets
welcome-text = Continue na sua tailnet e abra máquinas de outras ao mesmo tempo. Seu aplicativo do Tailscale continua funcionando normalmente.
welcome-sign-in = Faça login em outra tailnet
welcome-sign-in-detail = A página de login do Tailscale abre no seu navegador.
welcome-open = Abra as máquinas dela pelo nome
welcome-open-detail = Endereços como { $example } funcionam no seu navegador.
welcome-forward = Encaminhe uma porta quando um aplicativo precisar
welcome-forward-detail = Área de Trabalho Remota, SSH e aplicativos de banco de dados recebem uma porta local que leva a uma máquina.

## Cartão de uma tailnet

machine-search-hint = Buscar máquina por nome, sistema ou endereço
clear-search = Limpar a busca
more-actions = Mais ações
edit-tailnet-menu = Renomear ou adicionar domínios…
log-out-menu = Sair da conta…
remove-menu = Remover…
sign-in = Fazer login
pause-tailnet = Pausar esta tailnet
resume-tailnet = Retomar esta tailnet
detail-tailnet = Tailnet
detail-routes = Rotas
detail-this-computer = Este computador
detail-problem = Problema
routes-after-sign-in = Detectadas após o login
hostname-after-sign-in = { $hostname } (após o login)
sign-in-help = O navegador não abriu ou abriu no perfil errado?
sign-in-open-again = Abrir a página de login novamente
sign-in-copy-link = Copiar o link
sign-in-copy-link-tooltip = Cole no navegador, ou no perfil do navegador, que você usa para esta tailnet

## Lista de máquinas no cartão de uma tailnet

machines-online = Máquinas · { $online } de { $total } online
machines-matching = Máquinas · { $shown } de { $total } correspondem
no-machines = Nenhuma outra máquina está visível nesta tailnet.
no-machine-matches = Nenhuma máquina corresponde à sua busca.
machine-offline = { $name } (offline)
forward-port-tooltip = Encaminhar uma porta: para aplicativos que ignoram a configuração de proxy, como a Área de Trabalho Remota ou um cliente de banco de dados
copy-address = Copiar { $address }
open-in-browser = Abrir { $url } no navegador
not-routing-tooltip = Esta tailnet não está roteando agora. Será que está em pausa?

## Sites encontrados nas máquinas

sites-heading = Sites
sites-help = Máquinas das suas tailnets que servem um site por HTTPS. Cada máquina é verificada no máximo uma vez por dia.
# $done e $total contam máquinas.
sites-checking = Verificando { $done } de { $total }…
sites-recheck-tooltip = Verificar todas as máquinas de novo agora
site-untrusted = O certificado dele não é confiável, então o navegador vai mostrar um aviso.

## Configurações: encaminhamentos de porta

forwards-heading = Encaminhamentos de porta
forwards-help = Para aplicativos que ignoram a configuração de proxy, como Área de Trabalho Remota, SSH e clientes de banco de dados. Cada encaminhamento é uma porta neste computador que leva a uma máquina em uma tailnet.
edit-forwards = Editar encaminhamentos
# Mantenha LOCALPORT, auto e host:port: é o que se digita.
forwards-format-help = Um por linha: LOCALPORT = host:port, ou auto = host:port para escolher uma porta livre. O nome do host define qual tailnet o transporta. Para adicionar um rapidamente, use o botão de plugue de uma máquina na aba Tailnets.
forward-cant-listen = Não é possível escutar: { $error }
forward-port-on-save = A porta é escolhida ao salvar
forward-no-tailnet = Nenhuma tailnet roteando tem esse nome
forward-via = via { $tailnet }
open-remote-desktop-to = Abrir a Área de Trabalho Remota em { $address }

## Configurações: proxy do sistema

proxy-heading = Configuração de proxy do sistema
proxy-on = Ativado (recomendado)
proxy-force = Ativado, substituindo o script de proxy definido pela sua empresa enquanto estiver em execução
proxy-off = Desativado: eu mesmo configuro meus aplicativos
proxy-help-windows = "Ativado" aponta o Windows para as regras deste aplicativo só enquanto ele está em execução e roteando, e restaura tudo quando ele para, pausa, desconecta ou trava.
proxy-help-macos = "Ativado" define o proxy dos seus serviços de rede enquanto o aplicativo está em execução e o restaura depois. Se o seu Mac exigir uma senha de administrador para isso, ela será pedida quando o roteamento começar e quando você sair.
proxy-help-linux = "Ativado" define a configuração de proxy do GNOME ou do KDE enquanto o aplicativo está em execução e roteando, e a restaura depois. No Firefox, ative Configurações > Configurações de rede > "Usar configurações de proxy do sistema".

## Configurações: geral

general-heading = Geral
start-at-login = Iniciar o { -app-name } quando eu fizer login
language = Idioma
system-default = Padrão do sistema

## Configurações: solução de problemas

troubleshooting-heading = Solução de problemas
troubleshooting-help = Teste um endereço web ou nome:porta para ver qual tailnet o transporta e se a conexão funciona.
test = Testar
testing = Testando…
open-log = Abrir log
open-settings-folder = Abrir pasta de configurações
about-line = { -app-name } { $version } · proxy local { $proxy } · PAC { $pac }
settings-location = Configurações em { $path }

## Resultados de "Testar" em Solução de problemas

check-empty = Digite o nome de uma máquina ou um endereço web.
check-bad-port = { $input }: essa não é uma porta válida.
check-not-routed = { $host } não é roteado pelo { -app-name }: não termina no domínio de nenhuma tailnet que esteja roteando agora, então vai direto (pela sua rede normal e pelo seu próprio Tailscale).
check-gone = Essa tailnet acabou de desaparecer.
check-not-running = { $tailnet } não está em execução.
check-ok = { $address } funciona: conectado via { $tailnet } em { $ms } ms.
check-failed =
    { $host } é roteado via { $tailnet }, mas a conexão com a porta { $port } falhou: { $error }
    Verifique se a máquina está online e se há algo escutando nessa porta.
check-timeout = { $host } é roteado via { $tailnet }, mas a porta { $port } não respondeu em 10 segundos.
domain-conflict = { $domain } também é roteado por { $tailnet }; essa tem prioridade.

## Erros nas configurações digitadas

forwards-line-format = Linha { $line }: escreva LOCALPORT = host:port.
forwards-line-port = Linha { $line }: “{ $value }” não é um número de porta (nem auto).
forwards-line-target = Linha { $line }: “{ $value }” deve ser host:port.
forwards-line-duplicate = Linha { $line }: a porta local { $port } está sendo usada duas vezes.
domain-invalid = “{ $domain }” não é um domínio; use algo como example.ts.net.
domain-characters = “{ $domain }” contém caracteres que um domínio não pode ter.
autostart-unsupported = Iniciar ao fazer login não é compatível com este sistema.

## Caixas de diálogo

ok = OK
cancel = Cancelar
done = Concluído
copy = Copiar
error-title = Algo deu errado
error-details = Os detalhes estão em { $path }
edit-title = Editar { $tailnet }
tailnet-name = Nome
tailnet-name-hint = Exibido neste aplicativo e no menu da bandeja
extra-domains = Domínios extras (opcional)
extra-domains-help = O domínio da própria tailnet é roteado automaticamente. Adicione um por linha.
forward-dialog-title = Encaminhar uma porta
forward-dialog-text = Receba uma porta neste computador que leva a { $host }. Qual porta dessa máquina?
port-preset-remote-desktop = Área de Trabalho Remota
port-tooltip = Porta { $port }
port = Porta
port-hint = ex.: 8080
add-forward = Adicionar encaminhamento
not-a-port = “{ $value }” não é um número de porta (1-65535).
forward-ready-title = Encaminhamento de porta pronto
forward-ready-text = Aponte seu aplicativo para este endereço para acessar { $target }:
forward-ready-note = A porta não muda. Você a encontra em Configurações.
open-remote-desktop = Abrir Área de Trabalho Remota
remove-title = Remover esta tailnet?
remove-text = O { -app-name } sai da conta de { $tailnet } e a esquece neste computador. Você pode adicioná-la de novo depois.
remove = Remover
log-out-title = Sair da conta?
log-out-text = Sair da conta de { $tailnet }? Os endereços dela param de funcionar aqui até você fazer login novamente.
log-out = Sair da conta

## Menu da bandeja (Windows, Linux) ou da barra de menus (macOS)

tray-sign-in = { $tailnet }: fazer login…
tray-tailnet = { $tailnet }: { $state }
tray-add-tailnet = Adicionar tailnet…
tray-route = Rotear pelas outras tailnets
tray-open = Abrir o { -app-name }…
tray-quit = Sair
tray-tooltip = { -app-name }: { $summary }

## Notificação na primeira vez que a janela é fechada

still-running-title = O { -app-name } continua em execução
still-running-windows = Ele continua roteando em segundo plano. Procure-o na bandeja do sistema; o Windows pode escondê-lo sob a seta ^ perto do relógio.
still-running-macos = Ele continua roteando em segundo plano. Procure-o na barra de menus.
still-running-linux = Ele continua roteando em segundo plano. Procure-o na bandeja do sistema.

## Nomes de idiomas em Configurações, após o nome nativo de cada idioma

english = Inglês
french = Francês
german = Alemão
spanish-latin-america = Espanhol latino-americano
spanish-spain = Espanhol da Espanha
chinese-simplified = Chinês simplificado
chinese-traditional = Chinês tradicional
korean = Coreano
japanese = Japonês
polish = Polonês
russian = Russo
portuguese-brazil = Português do Brasil
italian = Italiano
turkish = Turco
ukrainian = Ucraniano
czech = Tcheco
portuguese-portugal = Português de Portugal
dutch = Neerlandês
indonesian = Indonésio
vietnamese = Vietnamita
thai = Tailandês
swedish = Sueco
romanian = Romeno
hungarian = Húngaro
afrikaans = Africâner
catalan = Catalão
serbian-cyrillic = Sérvio, cirílico
danish = Dinamarquês
finnish = Finlandês
greek = Grego
norwegian-bokmal = Bokmål norueguês
summary-proxy-problem = Conectado, mas seus aplicativos não estão usando a conexão
hero-proxy-taken = Seu navegador não vai abrir os endereços dessas tailnets: a configuração de proxy do sistema usa outro script de configuração ({ $script }).
hero-proxy-other-copy = Seu navegador não vai abrir os endereços dessas tailnets: outra cópia do { -app-name } está com a configuração de proxy do sistema. Feche essa cópia e esta assume.
hero-proxy-changed = Seu navegador não vai abrir os endereços dessas tailnets: outra coisa alterou a configuração de proxy do sistema.
hero-proxy-failed = Seu navegador não vai abrir os endereços dessas tailnets: não foi possível alterar a configuração de proxy do sistema ({ $error }).
hero-proxy-manual = A configuração de proxy do sistema está desativada, então só os aplicativos que você mesmo configurar chegam a essas tailnets. Aponte-os para { $pac }
proxy-replace = Substituir
proxy-replace-tooltip = Usar o script de configuração do { -app-name } enquanto ele estiver em execução e restaurar o outro depois
proxy-retry = Tentar novamente
proxy-retry-tooltip = Apontar a configuração de proxy do sistema para o { -app-name } novamente
system-setting = Configuração de proxy do sistema atual: { $value }
system-setting-none = nenhum
check-updates = Verificar novas versões
find-websites = Procurar sites nas máquinas das suas tailnets
# $version is the version that's running, such as 0.6.0.
version-current = Versão { $version }
update-check-now = Verificar agora
update-checking = Verificando…
update-up-to-date = Você tem a versão mais recente
update-check-failed = Não foi possível verificar atualizações
tray-update = Baixar o { -app-name } { $version }…
update-available = Versão { $version } disponível
update-available-tooltip = Você está com a versão { $current }. Abre a página de download.
update-notify-title = O { -app-name } { $version } está disponível
update-notify-text = Abra o { -app-name } para baixá-lo.
migrate-failed = Não foi possível transferir seus logins do tailnet-proxy, a versão anterior deste aplicativo ({ $error }). Ele provavelmente ainda está em execução. Feche o tailnet-proxy e inicie o { -app-name } novamente antes de fazer login aqui: fazer login de novo adicionaria este computador a cada tailnet uma segunda vez.
