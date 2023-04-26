extends Node2D

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
		
func _process(delta):
	$VBoxContainerPagina/HBoxContainerPagina/LabelPagAtual.text = str(self.pagina + 1)
	
	var total = DeckController.total
	if str(total) != $HBoxContainerDeck/LabelTotal.text:
		$HBoxContainerDeck/LabelTotal.text = str(total)
		if total >= 30 and total <= 40:
			$HBoxContainerDeck/LabelTotal.modulate = VERDE
		else:
			$HBoxContainerDeck/LabelTotal.modulate = VERMELHO
	
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
	$Container.add_child(novoAction)
	atualizarCards()
	
func retirar(card : Card):
	var filhos = $Container.get_children()
	#buscar nos filhos do container que mostra o deck atual
	for filho in filhos:
		if filho.ID == card.ID:
			#se achar o card já adicionado, acrescenta o número de copias no deck
			DeckController.retirar(card)
			#adiconando no próprio actionButtons
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
				
	$VBoxContainerPagina/HBoxContainerPagina/LabelPagFinal.text = str(cards.size())
	novaPagina()
	
func inicializarDeckCarregado():
	inicializarNovo()
	
	var containerCards := $Container
	for item in DeckController.deck:
		#action button referente as cartas adicionadas do deck
		var actionButton = preActionButton.instance()
		actionButton.inicializar(item.card,item.quantidade)
		actionButton.connect("destaque", self, "on_clicado")
		containerCards.add_child(actionButton)
	
	atualizarCards()

func novaPagina(mode = 1):
	pagina += mode
	var cardNodes = $Cards.get_children()
	#diferenca do total de cards por pagina pelo tamanho da pagina a ser carregada
	var dif = 6 - cards[pagina].size()
		
	for k in range(cards[pagina].size()):
		cardNodes[k].connect("clicado", self, "on_clicado")
		cardNodes[k].carta = cards[pagina][k]
		
		cardNodes[k].atualizar()
	
	var contador = cards[pagina].size()
	while contador < 6:
		cardNodes[contador].atualizar(0)

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
	descricao += str(carta.Nome)+" | "
	#formatar a primeira linha com nome e atributos
	var desc = "V:%d AT:%d E:%d CA:%d AL:%d\n\n" % [carta.Vida,carta.Ataque,carta.Escudo,carta.ContraAtaque,carta.Alcance]
	descricao += desc
	for k in range(carta.Efeitos.size()):
		if carta.CustoEnergia[k] < 0:
			descricao += "[b]"+"X"+"[/b] "
		else:
			descricao += "[b]"+str(carta.CustoEnergia[k])+"[/b] | "
		descricao += carta.TipoEfeitos[k]
		descricao += "\n"
		descricao += carta.Efeitos[k]
		descricao += "\n"
	descricao += "[/fill]"
	
	$DescricaoLabel.bbcode_text = descricao
	
func salvar():
	$FileDialog.popup()


func _on_FileDialog_dir_selected(dir):
	print(dir)
	DeckController.salvar(dir+"/")
