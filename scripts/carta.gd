extends Node2D


var carta : Card


func _ready():
	randomize()
	var indice_aleatorio = randi() % CardsController.listaStroj.size()
	print(indice_aleatorio)
	carta = CardsController.listaStroj[indice_aleatorio]
	$CardSprite.texture = carta.textura
	
