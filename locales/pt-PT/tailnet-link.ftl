### Tailnet Link: catálogo em português europeu.
### Mantenha os nomes Tailnet Link e Tailscale e a palavra "tailnet" (uma rede do Tailscale).

-app-name = Tailnet Link

## Cabeçalho da janela

tab-tailnets = Tailnets
tab-settings = Definições

## Barra de alterações por guardar no fundo das Definições

unsaved-changes = Tem alterações por guardar.
save = Guardar
revert = Reverter
revert-tooltip = Anular as alterações
settings-saved = Definições guardadas

## Avisos curtos no fundo da janela

copied-address = { $address } copiado
copied-sign-in-link = Ligação de início de sessão copiada

## Erros mostrados na caixa "Algo correu mal"

start-failed =
    Não é possível iniciar o { -app-name }:
    { $error }
add-tailnet-failed =
    Não foi possível adicionar uma tailnet:
    { $error }
add-forward-failed =
    Não foi possível adicionar o reencaminhamento de porta:
    { $error }
remote-desktop-failed = Não foi possível iniciar o Ambiente de Trabalho Remoto: { $error }
remote-desktop-windows-only = O Ambiente de Trabalho Remoto só vem integrado no Windows.
no-free-port = Não foi possível encontrar uma porta local livre.

## Caixa apresentada depois de "Adicionar tailnet"

sign-in-dialog-title = Iniciar sessão na nova tailnet
sign-in-dialog-text =
    O seu browser está a abrir a página de início de sessão do Tailscale. Pode abrir por trás desta janela.
    
    Inicie sessão com a sua conta dessa tailnet e depois volte aqui. O domínio é detetado automaticamente.

## Estado de uma tailnet, numa etiqueta colorida ao lado do nome

state-waiting-sign-in = A aguardar início de sessão
state-signed-out = Sessão terminada
state-problem = Problema
state-connecting = A ligar
state-paused = Suspensa
state-no-domain = Ainda sem domínio
state-not-routing = Sem encaminhamento
state-routing = A encaminhar

## Estado geral da aplicação, no cartão de estado e no menu da área de notificação

summary-no-tailnets = Ainda não há tailnets
summary-paused = Suspenso
summary-routing-one = A encaminhar através de { $tailnet }
summary-routing-all =
    { $count ->
        [one] A encaminhar através de { $count } tailnet
       *[other] A encaminhar através de { $count } tailnets
    }
summary-routing-some =
    { $count ->
        [one] A encaminhar através de { $routing } de { $count } tailnet
       *[other] A encaminhar através de { $routing } de { $count } tailnets
    }
summary-signed-out = Sessão não iniciada
summary-problem = Problema: { $problem }
summary-connecting = A ligar…
new-tailnet = Nova tailnet

## Cartão de estado no topo do separador Tailnets

hero-starting = A iniciar…
hero-connecting = A ligar às suas tailnets.
hero-paused = Neste momento, nada passa pelas outras tailnets. A sua rede e a sua tailnet funcionam como habitualmente.
hero-finish-sign-in = Conclua o início de sessão em { $tailnet } no seu browser.
hero-sign-in = Inicie sessão em { $tailnet } para aceder às respetivas máquinas.
hero-routing-example = Abra { $address } ou qualquer outro endereço destas tailnets. Tudo o resto segue diretamente.
hero-routing = Os endereços destas tailnets abrem no seu browser. Tudo o resto segue diretamente.
add-tailnet = Adicionar tailnet
pause-all = Suspender tudo
pause-all-tooltip = Deixar de encaminhar através das outras tailnets por agora
resume = Retomar
resume-tooltip = Voltar a encaminhar através das outras tailnets

## Primeira execução, antes de adicionar qualquer tailnet

welcome-title = Aceda a máquinas noutras tailnets
welcome-text = Mantenha-se na sua tailnet e abra máquinas de outras ao mesmo tempo. A sua aplicação Tailscale continua a funcionar como habitualmente.
welcome-sign-in = Inicie sessão noutra tailnet
welcome-sign-in-detail = A página de início de sessão do Tailscale abre no seu browser.
welcome-open = Abra as respetivas máquinas pelo nome
welcome-open-detail = Endereços como { $example } funcionam no seu browser.
welcome-forward = Reencaminhe uma porta quando uma aplicação precisar
welcome-forward-detail = O Ambiente de Trabalho Remoto, o SSH e as aplicações de bases de dados recebem uma porta local que leva a uma máquina.

## Cartão de uma tailnet

machine-search-hint = Procurar máquina por nome, sistema ou endereço
clear-search = Limpar a pesquisa
more-actions = Mais ações
edit-tailnet-menu = Mudar o nome ou adicionar domínios…
log-out-menu = Terminar sessão…
remove-menu = Remover…
sign-in = Iniciar sessão
pause-tailnet = Suspender esta tailnet
resume-tailnet = Retomar esta tailnet
detail-tailnet = Tailnet
detail-routes = Rotas
detail-this-computer = Este computador
detail-problem = Problema
routes-after-sign-in = Detetadas depois de iniciar sessão
hostname-after-sign-in = { $hostname } (depois de iniciar sessão)
sign-in-help = O browser não abriu, ou abriu o perfil errado?
sign-in-open-again = Abrir novamente a página de início de sessão
sign-in-copy-link = Copiar a ligação
sign-in-copy-link-tooltip = Cole-a no browser, ou perfil do browser, que utiliza para esta tailnet

## Lista de máquinas no cartão de uma tailnet

machines-online = Máquinas · { $online } de { $total } online
machines-matching = Máquinas · { $shown } de { $total } correspondem
no-machines = Não há outras máquinas visíveis nesta tailnet.
no-machine-matches = Nenhuma máquina corresponde à pesquisa.
machine-offline = { $name } (offline)
forward-port-tooltip = Reencaminhar uma porta: para aplicações que ignoram a definição de proxy, como o Ambiente de Trabalho Remoto ou um cliente de bases de dados
copy-address = Copiar { $address }
open-in-browser = Abrir { $url } no browser
not-routing-tooltip = Esta tailnet não está a encaminhar neste momento. Estará suspensa?

## Definições: reencaminhamentos de portas

forwards-heading = Reencaminhamentos de portas
forwards-help = Para aplicações que ignoram a definição de proxy, como o Ambiente de Trabalho Remoto, SSH e clientes de bases de dados. Cada reencaminhamento é uma porta neste computador que leva a uma máquina numa tailnet.
edit-forwards = Editar reencaminhamentos
# Mantenha LOCALPORT, auto e host:port: é o que se escreve.
forwards-format-help = Um por linha: LOCALPORT = host:port, ou auto = host:port para escolher uma porta livre. O nome do anfitrião determina que tailnet o transporta. Para adicionar um rapidamente, use o botão de ficha de uma máquina no separador Tailnets.
forward-cant-listen = Não é possível escutar: { $error }
forward-port-on-save = A porta é escolhida ao guardar
forward-no-tailnet = Nenhuma tailnet a encaminhar tem este nome
forward-via = através de { $tailnet }
open-remote-desktop-to = Abrir o Ambiente de Trabalho Remoto para { $address }

## Definições: proxy do sistema

proxy-heading = Definição de proxy do sistema
proxy-on = Ativada (recomendado)
proxy-force = Ativada, e substituir um script de proxy definido pela sua empresa enquanto estiver em execução
proxy-off = Desativada: eu próprio configuro as minhas aplicações
proxy-help-windows = "Ativada" aponta o Windows para as regras desta aplicação apenas enquanto está em execução e a encaminhar, e repõe tudo quando para, é suspensa, perde a ligação ou falha.
proxy-help-macos = "Ativada" define o proxy dos seus serviços de rede enquanto a aplicação está em execução e repõe-no depois. Se o seu Mac precisar de uma palavra-passe de administrador para isso, ser-lhe-á pedida quando o encaminhamento começar e quando sair.
proxy-help-linux = "Ativada" altera a definição de proxy do GNOME ou do KDE enquanto a aplicação está em execução e a encaminhar, e repõe-na depois. No Firefox, ative Definições > Definições de rede > "Utilizar definições de proxy do sistema".

## Definições: geral

general-heading = Geral
start-at-login = Iniciar o { -app-name } quando eu iniciar sessão
language = Língua
system-default = Predefinição do sistema

## Definições: resolução de problemas

troubleshooting-heading = Resolução de problemas
troubleshooting-help = Teste um endereço web ou nome:porta para ver que tailnet o transporta e se a ligação funciona.
test = Testar
testing = A testar…
open-log = Abrir registo
open-settings-folder = Abrir pasta de definições
about-line = { -app-name } { $version } · proxy local { $proxy } · PAC { $pac }
settings-location = Definições em { $path }

## Resultados de "Testar" em Resolução de problemas

check-empty = Escreva o nome de uma máquina ou um endereço web.
check-bad-port = { $input }: essa porta não é válida.
check-not-routed = { $host } não é encaminhado pelo { -app-name }: não termina no domínio de nenhuma tailnet que esteja a encaminhar neste momento, por isso segue diretamente (pela sua rede normal e pelo seu próprio Tailscale).
check-gone = Essa tailnet acabou de desaparecer.
check-not-running = { $tailnet } não está em execução.
check-ok = { $address } funciona: ligado através de { $tailnet } em { $ms } ms.
check-failed =
    { $host } é encaminhado através de { $tailnet }, mas a ligação à porta { $port } falhou: { $error }
    Verifique se a máquina está online e se há algo à escuta nessa porta.
check-timeout = { $host } é encaminhado através de { $tailnet }, mas a porta { $port } não respondeu em 10 segundos.
domain-conflict = { $domain } também é encaminhado por { $tailnet }; essa tem prioridade.

## Erros nas definições escritas

forwards-line-format = Linha { $line }: escreva LOCALPORT = host:port.
forwards-line-port = Linha { $line }: “{ $value }” não é um número de porta (nem auto).
forwards-line-target = Linha { $line }: “{ $value }” deve ser host:port.
forwards-line-duplicate = Linha { $line }: a porta local { $port } está a ser usada duas vezes.
domain-invalid = “{ $domain }” não é um domínio; use algo como example.ts.net.
domain-characters = “{ $domain }” contém carateres que um domínio não pode ter.
autostart-unsupported = Iniciar ao iniciar sessão não é suportado neste sistema.

## Caixas de diálogo

ok = OK
cancel = Cancelar
done = Concluído
copy = Copiar
error-title = Algo correu mal
error-details = Os detalhes estão em { $path }
edit-title = Editar { $tailnet }
tailnet-name = Nome
tailnet-name-hint = Apresentado nesta aplicação e no menu da área de notificação
extra-domains = Domínios adicionais (opcional)
extra-domains-help = O domínio da própria tailnet é encaminhado automaticamente. Adicione um por linha.
forward-dialog-title = Reencaminhar uma porta
forward-dialog-text = Obtenha uma porta neste computador que leva a { $host }. Que porta dessa máquina?
port-preset-remote-desktop = Ambiente de Trabalho Remoto
port-tooltip = Porta { $port }
port = Porta
port-hint = p. ex. 8080
add-forward = Adicionar reencaminhamento
not-a-port = “{ $value }” não é um número de porta (1-65535).
forward-ready-title = Reencaminhamento de porta pronto
forward-ready-text = Aponte a sua aplicação para este endereço para aceder a { $target }:
forward-ready-note = A porta mantém-se. Encontra-a nas Definições.
open-remote-desktop = Abrir Ambiente de Trabalho Remoto
remove-title = Remover esta tailnet?
remove-text = O { -app-name } termina a sessão em { $tailnet } e esquece-a neste computador. Pode voltar a adicioná-la mais tarde.
remove = Remover
log-out-title = Terminar sessão?
log-out-text = Terminar sessão em { $tailnet }? Os respetivos endereços deixam de funcionar aqui até voltar a iniciar sessão.
log-out = Terminar sessão

## Menu da área de notificação (Windows, Linux) ou da barra de menus (macOS)

tray-sign-in = { $tailnet }: iniciar sessão…
tray-tailnet = { $tailnet }: { $state }
tray-add-tailnet = Adicionar tailnet…
tray-route = Encaminhar através das outras tailnets
tray-open = Abrir o { -app-name }…
tray-quit = Sair
tray-tooltip = { -app-name }: { $summary }

## Notificação na primeira vez que a janela é fechada

still-running-title = O { -app-name } continua em execução
still-running-windows = Continua a encaminhar em segundo plano. Encontra-o na área de notificação; o Windows pode escondê-lo sob a seta ^ junto ao relógio.
still-running-macos = Continua a encaminhar em segundo plano. Encontra-o na barra de menus.
still-running-linux = Continua a encaminhar em segundo plano. Encontra-o na área de notificação.

## Nomes das línguas nas Definições, depois do nome nativo de cada língua

english = Inglês
french = Francês
german = Alemão
spanish-latin-america = Espanhol latino-americano
spanish-spain = Espanhol de Espanha
chinese-simplified = Chinês simplificado
chinese-traditional = Chinês tradicional
korean = Coreano
japanese = Japonês
polish = Polaco
russian = Russo
portuguese-brazil = Português do Brasil
italian = Italiano
turkish = Turco
ukrainian = Ucraniano
czech = Checo
portuguese-portugal = Português de Portugal
dutch = Neerlandês
indonesian = Indonésio
vietnamese = Vietnamita
thai = Tailandês
swedish = Sueco
romanian = Romeno
hungarian = Húngaro
afrikaans = Africânder
catalan = Catalão
serbian-cyrillic = Sérvio, cirílico
danish = Dinamarquês
finnish = Finlandês
greek = Grego
norwegian-bokmal = Norueguês bokmål
summary-proxy-problem = Ligado, mas as suas aplicações não estão a utilizar a ligação
hero-proxy-taken = O seu browser não vai abrir os endereços destas tailnets: a definição de proxy do sistema utiliza outro script de configuração ({ $script }).
hero-proxy-other-copy = O seu browser não vai abrir os endereços destas tailnets: outra cópia do { -app-name } tem a definição de proxy do sistema. Feche essa cópia e esta assume o controlo.
hero-proxy-changed = O seu browser não vai abrir os endereços destas tailnets: outra coisa alterou a definição de proxy do sistema.
hero-proxy-failed = O seu browser não vai abrir os endereços destas tailnets: não foi possível alterar a definição de proxy do sistema ({ $error }).
hero-proxy-manual = A definição de proxy do sistema está desativada, por isso só as aplicações que configurar manualmente chegam a estas tailnets. Aponte-as para { $pac }
proxy-replace = Substituir
proxy-replace-tooltip = Utilizar o script de configuração do { -app-name } enquanto estiver em execução e repor o outro depois
proxy-retry = Tentar novamente
proxy-retry-tooltip = Apontar novamente a definição de proxy do sistema para o { -app-name }
system-setting = Definição de proxy do sistema atual: { $value }
system-setting-none = nenhum
check-updates = Procurar novas versões
tray-update = Transferir o { -app-name } { $version }…
update-available = Versão { $version } disponível
update-available-tooltip = Tem a versão { $current }. Abre a página de transferência.
update-notify-title = O { -app-name } { $version } está disponível
update-notify-text = Abra o { -app-name } para o transferir.
migrate-failed = Não foi possível mover as suas sessões iniciadas do tailnet-proxy, a versão anterior desta aplicação ({ $error }). Provavelmente ainda está em execução. Feche o tailnet-proxy e inicie novamente o { -app-name } antes de iniciar sessão aqui: iniciar sessão novamente adicionaria este computador a cada tailnet uma segunda vez.
