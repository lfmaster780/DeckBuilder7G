extends Node

var galaxia : String
var deck := []
var nome : String
var total : int

func _ready():
	novo()
	
func novo():
	deck = []
	total = 0
	nome = ""
	galaxia = ""
	
func adicionar(card : Card, mode = 0):
	#mode diferente de 0 quer dizer que é um card novo
	if mode != 0:
		var novaCarta = Carta.new(card)
		deck.append(novaCarta)
		total += 1
		return 1
		
	for item in deck:
		if card.ID == item.ID:
			item.adicionar()
			total += 1
			return 0
			
func retirar(card : Card):
	var cont = 0
	
	for item in deck:
		if card.ID == item.ID:
			var ret = item.retirar()
			#Diminuindo o total de cartas do deck
			total -= 1
			if ret == 0:
				deck.remove(cont)
				return 0
			else:
				return 1
				
		cont += 1

func quantidade(card: Card):
	for carta in deck:
		if carta.card == card:
			return carta.quantidade
			
	return 0
