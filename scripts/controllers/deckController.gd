extends Node

var galaxia : String
var deck := []
var nome := ""

func _ready():
	pass
	
func setGalaxia(galaxy : String):
	galaxia = galaxy
	
func adicionar(card : Card, mode = 0):
	#mode diferente de 0 quer dizer que é um card novo
	if mode != 0:
		var novaCarta = Carta.new(card)
		deck.append(novaCarta)
		return 1
		
	for item in deck:
		if card.ID == item.ID:
			item.adicionar()
			return 0
			
func retirar(card : Card):
	var cont = 0
	print("deck antes: ",deck.size())
	for item in deck:
		if card.ID == item.ID:
			var ret = item.retirar()
			if ret == 0:
				deck.remove(cont)
				print("deck depois: ",deck.size())
				return 0
			else:
				return 1
				
		cont += 1

func quantidade(card: Card):
	for carta in deck:
		if carta.card == card:
			return carta.quantidade
			
	return 0
