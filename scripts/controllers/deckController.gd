extends Node

var galaxia : String
var deck := []

func _ready():
	pass
	
func setGalaxia(galaxy : String):
	galaxia = galaxy
	
func adicionar(card : Card, mode = 0):
	if mode != 0:
		var novaCarta = Carta.new(card)
		deck.append(novaCarta)
		return 1
		
	for item in deck:
		if card.ID == item.ID:
			item.adicionar()
			return 0
		
func quantidade(card: Card):
	for carta in deck:
		if carta.card == card:
			return carta.quantidade
			
	return 0
