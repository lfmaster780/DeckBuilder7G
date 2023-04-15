class_name Carta

extends Resource

var card : Card
var quantidade : int
var ID : int

func _init(carta: Card):
	card = carta
	ID = card.ID
	quantidade = 1

func adicionar():
	quantidade += 1
	
func retirar():
	quantidade -= 1
	if quantidade <= 0:
		emit_signal("Zerado")
