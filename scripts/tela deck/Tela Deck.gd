extends Node2D
#GALAXIA DEPENDENTE
const VERMELHO = Color(255,0,0)
const VERDE = Color(0,255,0)

#CARD EM DESTAQUE
var cardDestaque : Card

var cards = []
var pagina = -1
var galaxia : String
onready var preActionButton = preload("res://scenes/adicionais tela deck/ActionButtonCarta.tscn")

func _ready():
	
	if DeckController.deck.size() < 1:
		inicializarNovo()
	else:
		inicializarDeckCarregado()
		
	iniciarFortaleza()
		
func _process(delta):
	#Process mantendo atualizado as informações na tela sobre total de cartas
	$VBoxContainerPagina/HBoxContainerPagina/LabelPagAtual.text = str(self.pagina + 1)
	
	var total = DeckController.total
	if str(total) != $HBoxContainerDeck/LabelTotal.text:
		$HBoxContainerDeck/LabelTotal.text = str(total)
		if total >= 30 and total <= 40:
			$HBoxContainerDeck/LabelTotal.modulate = VERDE
			#Quando segue as regras de pelo menos 30 e no maximo 40, pode testar mao inicial
			$ButtonMao.visible = true
		else:
			$HBoxContainerDeck/LabelTotal.modulate = VERMELHO
			$ButtonMao.visible = false
	
func adicao(card : Card):
	var filhos = $Container.get_children()
	#buscar nos filhos do container que mostra o deck atual
	for filho in filhos:
		if filho.ID == card.ID:
			#se achar o card já adicionado, acrescenta o número de copias no deck
			DeckController.adicionar(card)
			#adiconando no próprio actionButtons
			filho.adicionar()
			atualizarCards()
			return
			
	#se nao achar
	var novoAction = preActionButton.instance()
	DeckController.adicionar(card,1)
	novoAction.inicializar(card)
	novoAction.connect("destaque", self, "on_clicado")
	#VERIFICAR QUAL POSICAO O NOVO NO FILHO DEVE SER ADICIONADO (ORDEM ALFABETICA)
	var indexNo = compararListagem(novoAction.card)
	#Significa que deve ser colocado no final
	if indexNo == -2:
		$Container.add_child(novoAction)
	elif indexNo == -1:
		#Deve ser colocado na primeira posicao
		var filhoPos = $Container.get_child(0)
		$Container.add_child_below_node($Container.get_child(0),novoAction)
		$Container.remove_child(filhoPos)
		$Container.add_child_below_node(novoAction, filhoPos)
	else:
		#E colocado apos o no que o antecede na ordem alfabetica
		$Container.add_child_below_node($Container.get_child(indexNo),novoAction)
	atualizarCards()
	
func retirar(card : Card):
	var filhos = $Container.get_children()
	#buscar nos filhos do container que mostra o deck atual
	for filho in filhos:
		if filho.ID == card.ID:
			#se achar o card já adicionado, retira o número de copias no deck
			DeckController.retirar(card)
			#retirando no próprio actionButtons
			filho.retirar()
			atualizarCards()
			return
	
func atualizarCards():
	for card in $Cards.get_children():
		card.atualizar()

func inicializarNovo():
	pagina = -1
	galaxia = DeckController.galaxia
	$TituloJanelaStatus/LabelNomeGalaxia.text = galaxia
	$VBoxContainerNome/LabelNomeDeck.text = DeckController.nome
	#Checa a galaxia, e separa os cards em paginas de ate 6 cards
	if galaxia.to_lower() == "stroj":
		var lista = CardsController.listaStroj
		var contador = 0
		var pagina = []
		for k in range(lista.size()):
			if contador <= 5:
				pagina.append(lista[k])
				contador += 1
			else:
				
				cards.append(pagina)
				contador = 1
				pagina = []
				pagina.append(lista[k])
		cards.append(pagina)
				
	elif galaxia.to_lower() == "gaia":
		var lista = CardsController.listaGaia
		var contador = 0
		var pagina = []
		for k in range(lista.size()):
			if contador <= 5:
				
				pagina.append(lista[k])
				contador += 1
			else:
				
				cards.append(pagina)
				contador = 1
				pagina = []
				pagina.append(lista[k])
		
		cards.append(pagina)
	
	elif galaxia.to_lower() == "majik":
		var lista = CardsController.listaMajik
		var contador = 0
		var pagina = []
		for k in range(lista.size()):
			if contador <= 5:
				
				pagina.append(lista[k])
				contador += 1
			else:
				
				cards.append(pagina)
				contador = 1
				pagina = []
				pagina.append(lista[k])
		
		cards.append(pagina)
	
	elif galaxia.to_lower() == "adroit":
		var lista = CardsController.listaAdroit
		var contador = 0
		var pagina = []
		for k in range(lista.size()):
			if contador <= 5:
				
				pagina.append(lista[k])
				contador += 1
			else:
				
				cards.append(pagina)
				contador = 1
				pagina = []
				pagina.append(lista[k])
		
		cards.append(pagina)
	
	$VBoxContainerPagina/HBoxContainerPagina/LabelPagFinal.text = str(cards.size())
	novaPagina()
	
func inicializarDeckCarregado():
	inicializarNovo()
	
	for item in DeckController.deck:
		#action button referente as cartas adicionadas do deck
		var actionButton = preActionButton.instance()
		actionButton.inicializar(item.card,item.quantidade)
		actionButton.connect("destaque", self, "on_clicado")
		#VERIFICAR QUAL POSICAO O NOVO NO FILHO DEVE SER ADICIONADO (ORDEM ALFABETICA)
		var indexNo = compararListagem(actionButton.card)
		if indexNo == -2:
			$Container.add_child(actionButton)
		elif indexNo == -1:
			var filhoPos = $Container.get_child(0)
			$Container.add_child_below_node($Container.get_child(0),actionButton)
			$Container.remove_child(filhoPos)
			$Container.add_child_below_node(actionButton, filhoPos)
		else:
			$Container.add_child_below_node($Container.get_child(indexNo),actionButton)
	
	atualizarCards()

func novaPagina(mudanca = 1):
	#Parametro mudanca serve para saber com o que se vai somar
	#Se for 1 vai para proxima pagina, -1 para anterior, e outros casos para ir ao fim ou inicio da lista de paginas
	pagina += mudanca
	var cardNodes = $Cards.get_children()
	#diferenca do total de cards por pagina pelo tamanho da pagina a ser carregada
	var dif = 6 - cards[pagina].size()
		
	for k in range(cards[pagina].size()):
		cardNodes[k].connect("clicado", self, "on_clicado")
		cardNodes[k].carta = cards[pagina][k]
		
		cardNodes[k].atualizar()
		#Quando mudar pagina retirar a selecao de carta especial
		cardNodes[k].deselecionarEspecial()
	
	if dif == 0:
		return
		
	for j in range(cards[pagina].size(),6):
		cardNodes[j].atualizar(0)
	

func _on_ButtonNext_pressed():
	if pagina < (cards.size()-1):
		novaPagina()
	else:
		novaPagina(pagina*-1)
		
func on_clicado(carta):
	destacar(carta)

func _on_ButtonPrevious_pressed():
	if pagina > 0:
		novaPagina(-1)
	else:
		novaPagina(cards.size()-1)


func _on_ButtonMenu_pressed():
	get_tree().change_scene("res://scenes/Menu.tscn")
	
func destacar(carta : Card):
	cardDestaque = carta
	
	$CardDestaque.texture = carta.textura
	var descricao := "[fill]"
	descricao += "[b]"+str(carta.Nome)+"[/b] | "
	#formatar a primeira linha com nome e atributos
	var desc = "Vida:%d Ataque:%d Escudo:%d Contra-Ataque:%d Alcance:%d\n" % [carta.Vida,carta.Ataque,carta.Escudo,carta.ContraAtaque,carta.Alcance]
	#So mostrar se for do tipo criatura ou equipamento
	if carta.Tipo == "Criatura" or carta.Tipo == "Equipamento":
		descricao += desc
		descricao += descreverAtributos(carta)
	descricao += "\n\n"
	for k in range(carta.Efeitos.size()):
		if carta.CustoEnergia[k] < 0:
			descricao += "[b]"+"X"+"[/b] | "
		else:
			descricao += "[b]"+str(carta.CustoEnergia[k])+"[/b] | "
		descricao += carta.TipoEfeitos[k]
		descricao += "\n"
		descricao += carta.Efeitos[k]
		descricao += "\n"
	descricao += "[/fill]"
	
	$DescricaoLabel.bbcode_text = descricao
	
func descreverAtributos(carta : Card) -> String:
	var desc = ""
	if carta.Intuicao:
		desc +="-Intuição- "
	if carta.Agilidade >= 0:
		desc +="-Agilidade %d- " % [carta.Agilidade]
	if carta.Multiataque >= 0:
		desc +="-Multiataque- "
	if carta.Oculto:
		desc +="-Oculto- "
	if carta.AlvoPrimario:
		desc +="-Alvo Primário- "
	if carta.Voador:
		desc +="-Voador- "
	if carta.SuperVelocidade:
		desc +="-Super Velocidade- "
	if carta.Teletransporte:
		desc +="-Teletransporte- "
	return desc

func salvar():
	$FileDialog.popup()


func _on_FileDialog_dir_selected(dir):
	print(dir)
	DeckController.salvar(dir+"/")


func _on_FullScreenButton_pressed():
	OS.window_fullscreen = not OS.window_fullscreen


func _on_ButtonFortaleza_pressed():
	get_tree().change_scene("res://scenes/TelaFortaleza.tscn")

func iniciarFortaleza():
	$Fortaleza/Sprite.texture = DeckController.fortaleza.textura
	
	var texto = "[b]"+DeckController.fortaleza.Nome+"[/b]\n"
	for k in range(len(DeckController.fortaleza.Efeitos)):
		texto += "[b]"+str(DeckController.fortaleza.CustoEnergia[k])+" | "
		texto += DeckController.fortaleza.TipoEfeitos[k]+"[/b] \n"
		texto += DeckController.fortaleza.Efeitos[k]
		texto += "\n"
		
	$PopupFortaleza/Descricao.bbcode_text = "[fill]"+texto+"[/fill]"


func _on_Area2D_mouse_entered():
	$PopupFortaleza.visible = true

func _on_AreaFortaleza_mouse_exited():
	$PopupFortaleza.visible = false


func _on_ButtonMao_pressed():
	get_tree().change_scene("res://scenes/TelaMaoInicial.tscn")
	
func compararListagem(carta : Card) -> int:
	#Checar a posicao correta que uma nova carta deve ser adicionada (apos qual no)
	var filhos = $Container.get_children()
	if filhos.size() < 1:
		return -2
	else:
		var cont = -1
		for filho in filhos:
			var chave = filho.card.Nome
			if carta.Nome < chave:
				return cont
			cont += 1
	
	return -2
