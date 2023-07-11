extends Node2D
#GALAXIA DEPENDENTE

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

func _process(delta):
	if DeckController.total >= 40:
		$ButtonAdd.visible = false
	

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
		elif filiacao.to_upper() == "GAIA":
			especial = CardsController.buscarID(carta.EspecialID,CardsController.listaGaiaEspecial)
		elif filiacao.to_upper() == "MAJIK":
			especial = CardsController.buscarID(carta.EspecialID,CardsController.listaMajikEspecial)
		elif filiacao.to_upper() == "ADROIT":
			especial = CardsController.buscarID(carta.EspecialID,CardsController.listaAdroitEspecial)
		$VerEspecialButton.visible = true

#Funcao ativada quando o botão de ver card especial é pressionado
func _on_VerEspecialButton_toggled(button_pressed):
	#Se estiver pressionado mostra a carta especial relacionada, se não mostra a carta normal
	if $VerEspecialButton.pressed:
		$CardSprite.texture = especial.textura
	else:
		$CardSprite.texture = carta.textura


func _on_ButtonRetirar_pressed():
	#Faz a retirada chamando o pai do no pai que sera o Node2D "Tela Deck"
	get_parent().get_parent().retirar(carta)
	atualizar()


func _on_ButtonAdd_pressed():
	#Faz a adicao chamando o metodo do pai do no pai que sera o Node2D "Tela Deck"
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
	#Atualizacao das informacoes
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
		#Se tiver, é feita a checagem de filiacao (galaxia) | carrega os dados e torna botao de card especial visivel
		if filiacao.to_upper() == "STROJ":
			especial = CardsController.buscarID(carta.EspecialID,CardsController.listaStrojEspecial)
		elif filiacao.to_upper() == "GAIA":
			especial = CardsController.buscarID(carta.EspecialID,CardsController.listaGaiaEspecial)
		elif filiacao.to_upper() == "MAJIK":
			especial = CardsController.buscarID(carta.EspecialID,CardsController.listaMajikEspecial)
		elif filiacao.to_upper() == "ADROIT":
			especial = CardsController.buscarID(carta.EspecialID,CardsController.listaAdroitEspecial)
		$VerEspecialButton.visible = true
	else:
		$VerEspecialButton.visible = false

func deselecionarEspecial():
	$VerEspecialButton.pressed = false

func _on_Area2D_input_event(viewport, event, shape_idx):
	#Quando uma carta for clicada era emitira o sinal para ser destacada na lateral da tela
	var i = 1
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		#Se a carta estiver mostrando a carta especial relacionada, destaca a especial
		if $VerEspecialButton.pressed:
			emit_signal("clicado",self.especial)
		#Caso contrario destaca a carta normal
		else:
			emit_signal("clicado",self.carta)
