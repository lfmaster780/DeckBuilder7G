extends Node2D

var cards = []
var pagina = -1
var galaxia : String
onready var preActionButton = preload("res://scenes/adicionais tela deck/ActionButtonCarta.tscn")

func _ready():
	DeckController.galaxia = "Stroj"
	incializarNovo()
	
func adicao(card : Card):
	var filhos = $Container.get_children()
	#buscar nos filhos do container que mostra o deck atual
	for filho in filhos:
		if filho.ID == card.ID:
			#se achar o card já adicionado, acrescenta o número de copias no deck
			DeckController.adicionar(card)
			#adiconando no próprio actionButton
			filho.adicionar()
			atualizarCards()
			return
			
	#se nao achar
	var novoAction = preActionButton.instance()
	DeckController.adicionar(card,1)
	novoAction.inicializar(card)
	$Container.add_child(novoAction)
	atualizarCards()
	
func atualizarCards():
	for card in $Cards.get_children():
		card.atualizar()

func incializarNovo():
	pagina = -1
	galaxia = DeckController.galaxia
	if galaxia.to_lower() == "stroj":
		print("aqui")
		var lista = CardsController.listaStroj
		var contador = 0
		var pagina = []
		for k in range(lista.size()):
			print(k," ",contador)
			if contador <= 5:
				pagina.append(lista[k])
				contador += 1
			else:
				print(pagina.size())
				cards.append(pagina)
				contador = 1
				pagina = []
				pagina.append(lista[k])
				
	novaPagina()

func novaPagina(mode = 1):
	pagina += mode
	var cardNodes = $Cards.get_children()
	for k in range(cards[pagina].size()):
		cardNodes[k].carta = cards[pagina][k]
		
		cardNodes[k].atualizar()


func _on_ButtonNext_pressed():
	if pagina < (cards.size()-1):
		novaPagina()


func _on_ButtonPrevious_pressed():
	if pagina > 0:
		novaPagina(-1)
