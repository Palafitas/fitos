#!/bin/bash

# Variaveis globais
min_x=100
max_x=300

min_y=100
max_y=300

segue_x=1

pixels=50
vara='F1'
keys=('F2' 'F3' 'F4')
tempo_key=1

# Funções
obter_configuracoes() {
	diretorio=~/.config/fitos
	config="$diretorio/fitos.conf"

	if [ ! -d $diretorio ]; then
		mkdir $diretorio
	fi
			
	if [ ! -f $config ]; then
		touch $config
		echo "min_x=$min_x # Inicio das coordenadas X" >> $config
		echo "max_x=$max_x # Fim das coordenadas X" >> $config
		echo "min_y=$min_y # Inicio das coordenadas Y" >> $config
		echo "max_y=$max_y # Fim das coordenadas Y" >> $config
		echo "segue_x=$segue_x # Se a orientação deve ser feita com base no eixo X" >> $config
		echo "pixels=$pixels # Quantidade de pixels a ser somada ou subtraida" >> $config
		echo "vara='$vara' # Hotkey para uso da vara de pesca" >> $config
		echo "keys=('F2' 'F3' 'F4') # Hotkeys secundarias que vão ser acionadas a cada fim de pesca (Quando chegar no max_x e max_y)" >> $config
		echo "tempo_key=$tempo_key # Tempo de espera em segundos para cada hotkey secundária" >> $config
	fi

	. $config

	if [ -z "$vara" ]; then
		echo "Problemas com a configuração, favor verificar arquivo ~/.config/fitos/fitos.conf"
		exit
	fi	
}

# Execução
obter_configuracoes
clear
echo
echo '███████╗██╗████████╗ ██████╗ ███████╗'
echo '██╔════╝██║╚══██╔══╝██╔═══██╗██╔════╝'
echo '█████╗  ██║   ██║   ██║   ██║███████╗'
echo '██╔══╝  ██║   ██║   ██║   ██║╚════██║'
echo '██║     ██║   ██║   ╚██████╔╝███████║'
echo '╚═╝     ╚═╝   ╚═╝    ╚═════╝ ╚══════╝'
echo '             By ST3LZ3R'
echo

echo "Soma por quadrado: $soma"
echo "Eixo X: $min_x - $max_x"
echo "Eixo Y: $min_y - $max_y"
echo "Vara: $vara"
echo "Keys: ${keys[@]}"
echo "Tempo entre keys: $tempo_key"
echo
echo 'Pressione uma tecla para continuar...' 
read

x=$min_x
y=$min_y

trata_x() {
	if [ $min_x -lt $max_x ]; then
		((x=$x+$pixels))
		if [ $x -gt $max_x ]; then
			x=$max_x
		fi
	else
		((x=$x-$pixels))
		if [ $x -lt $max_x ]; then
			x=$max_x		
		fi
	fi
}

trata_y() {
	if [ $min_y -lt $max_y ]; then
		((y=$y+$pixels))
		if [ $y -gt $max_y ]; then
			y=$max_y
		fi
	else
		((y=$y-$pixels))
		if [ $y -lt $max_y ]; then
			y=$max_y
		fi
	fi
}

pescar() {
	xte "mousemove $x $y" "key $vara" 'mouseclick 1' "sleep 1"
	echo "Pescou em X: $x  Y: $y"		
}

chamar_keys() {
	if [[ $x -eq $max_x && $y -eq $max_y ]]; then 
		for key in ${keys[@]} ;
		do
			xte "key $key" "sleep $tempo_key" 
			echo "Lançou key $key e esperou $tempo_key segundo(s)"  
		done	

		x=$min_x
		y=$min_y
	fi


}

while :
do
	if [ $segue_x -eq 1 ]; then
		trata_x
		pescar
		chamar_keys
		if [ $x -eq $max_x ]; then
			x=$min_x
			trata_y
		fi
	else
		trata_y
		pescar
		chamar_keys
		if [ $y -eq $max_y ]; then
			y=$min_y
			trata_x
		fi
	fi
done
