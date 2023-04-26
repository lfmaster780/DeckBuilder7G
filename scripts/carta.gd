extends Node2D


var carta : Card
var filiacao : String
var especial : Card
#
signal clicado(carta)

func _ready():
	#Especifico para teste
	
	#randomize()
	#var indice_aleatorio = randi() % CardsController.listaStroj.size()
	#indice_aleatorio = 3 #Especifico para teste
	#filiacao = "Stroj"
	#carta = CardsController.listaStroj[indice_aleatorio]
	#$CardSprite.texture = carta.textura
	
	#if carta.EspecialID > 0:
		#if filiacao.to_upper() == "STROJ":
			#especial = CardsController.buscarID(carta.EspecialID,CardsController.listaStrojEspecial)
		#else:
			#especial = CardsController.buscarID(carta.EspecialID,CardsController.listaGaiaEspecial)
		#$VerEspecialButton.visible = true
	pass

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
	get_parent().get_parent().retirar(carta)
	atualizar()


func _on_ButtonAdd_pressed():
	var result = int($LabelQuantidade.text) + 1
	get_parent().get_parent().adicao(carta)
	atualizar()
	
func atualizar(mode = 1):
	#mode 0 quer dizer card nulo e 1 card normal
	if mode == 0:
		self.visible = false
		self.carta = null
		return
	
	if self.carta == null:
		return
	self.visible = true
	
	$LabelQuantidade.text = str(DeckController.quantidade(carta))
	$CardSprite.texture = carta.textura
	filiacao = DeckController.galaxia
	
	if int($LabelQuantidade.text) == 0:
		$ButtonRetirar.visible = false
		$ButtonAdd.visible = true
	elif int($LabelQuantidade.text) == 1:
		$ButtonRetirar.visible = true
		$ButtonAdd.visible = true
	else:
		$ButtonRetirar.visible = true
		$ButtonAdd.visible = false
	
	if carta.EspecialID > 0:
		#Se tiver, é feita a checagem de filiacao | carrega os dados e torna botao de card especial visivel
		if filiacao.to_upper() == "STROJ":
			especial = CardsController.buscarID(carta.EspecialID,CardsController.listaStrojEspecial)
		elif filiacao.to_upper() == "GAIA":
			especial = CardsController.buscarID(carta.EspecialID,CardsController.listaGaiaEspecial)
		$VerEspecialButton.visible = true
	else:
		$VerEspecialButton.visible = false


func _on_Area2D_input_event(viewport, event, shape_idx):
	var i = 1
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		emit_signal("clicado",self.carta)
