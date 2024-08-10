+++ Sobre +++
Bot de pescaria/runa/treino para tibia orientado a coordenadas x,y e hotkeys secundárias, aproveitando-se do xautomation para disparo de eventos no sistema operacional.

+++ Configurações +++
O arquivo de configuração se encontra em ~/.config/fitos/fitos.conf, seguindo a syntax:

min_x=550	# Inicio das coordenadas X
max_x=1000 # Fim das coordenadas X
min_y=100 # Inicio das coordenadas Y
max_y=150 # Fim das coordenadas Y
segue_x=1 # Se a orientação deve ser feita com base no eixo X
pixels=50 # Quantidade de pixels a ser somada ou subtraida
vara='F7' # Hotkey para uso da vara de pesca
keys=('F8' 'F4') # Hotkeys secundarias que vão ser acionadas a cada fim de pesca (Quando chegar no max_x e max_y)
tempo_key=1 # Tempo de espera em segundos para cada hotkey secundária

(Acaso não exista configuração ao executar o script o mesmo sera criado com as configurações padrões.)

+++ Observações +++
O script utiliza o comando `xte` (obtém-se ao instalar o `xautomation`) para realizar movimento do mouse e teclar, por isso confirme se a KEY a ser utilizada possui no mesmo.
(Após inicio do script, o mesmo só irá parar através do Ctrl + C.)

- Pescando
A forma de pescar se da através de incremento do eixo X ou Y (Com base na variável `segue_x` ) para mover o mouse e realizar um click utilizando a hotkey determinada na variavel `vara`.

- Hotkeys secundárias
As hotkeys secundárias são determinadas pela variável `keys` sendo realizado um loop nas mesmas, utilizando seu respectivo tempo de sleep (Configurado na variável `tempo_key`.
