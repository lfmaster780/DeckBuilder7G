extends Node2D


var carta : Card
var filiacao : String
var especial : Card

#

func _ready():
	#Especifico para teste
	
	randomize()
	var indice_aleatorio = randi() % CardsController.listaStroj.size()
	print(indice_aleatorio)
	indice_aleatorio = 3 #Especifico para teste
	filiacao = "Stroj"
	carta = CardsController.listaStroj[indice_aleatorio]
	$CardSprite.texture = carta.textura
	
	if carta.EspecialID > 0:
		if filiacao.to_upper() == "STROJ":
			especial = CardsController.buscarID(carta.EspecialID,CardsController.listaStrojEspecial)
		else:
			especial = CardsController.buscarID(carta.EspecialID,CardsController.listaGaiaEspecial)
		$VerEspecialButton.visible = true
		

func inicializar(index:int,filiacao:String):
	#Seta a filiação da carta
	self.filiacao = filiacao
	#Carrega a carta do Controlador
	carta = CardsController.listaStroj[index]
	$CardSprite.texture = carta.textura
	#Checa se tem carta especial relacionada e faz o tratamento
	if carta.EspecialID > 0:
		#Se tiver, é feita a checagem de filiacao | carrega os dados e torna botao de card especial visivel
		if filiacao.to_upper() == "STROJ":
			especial = CardsController.buscarID(carta.EspecialID,CardsController.listaStrojEspecial)
		else:
			especial = CardsController.buscarID(carta.EspecialID,CardsController.listaGaiaEspecial)
		$VerEspecialButton.visible = true

#Funcao ativada quando o botão de ver card especial é pressionado
func _on_VerEspecialButton_toggled(button_pressed):
	#Se estiver pressionado mostra a carta especial relacionada, se não mostra a carta normal
	if $VerEspecialButton.pressed:
		$CardSprite.texture = especial.textura
	else:
		$CardSprite.texture = carta.textura


func _on_ButtonRetirar_pressed():
	var result = int($LabelQuantidade.text) - 1
	$LabelQuantidade.text = str(result)


func _on_ButtonAdd_pressed():
	var result = int($LabelQuantidade.text) + 1
	$LabelQuantidade.text = str(result)
