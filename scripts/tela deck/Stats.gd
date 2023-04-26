extends Control

var n0 := 0
var n1 := 0
var n2 := 0
var n3 := 0

var total := 0.0

func _ready():
	pass

func _process(delta):
	atualizar()
	total = float(DeckController.total)
	
	if DeckController.total > 0:
		$TextureProgress0.value = (n0/total)*100
		$TextureProgress1.value = (n1/total)*100
		$TextureProgress2.value = (n2/total)*100
		$TextureProgress3.value = (n3/total)*100
	else:
		$TextureProgress0.value = n0
		$TextureProgress1.value = n1
		$TextureProgress2.value = n2
		$TextureProgress3.value = n3
	
func atualizar():
	if DeckController.deck.size() < 1:
		n0 = 0
		n1 = 0
		n2 = 0
		n3 = 0
		return
		
	var tempN0 = 0
	var tempN1 = 0
	var tempN2 = 0
	var tempN3 = 0
	for card in DeckController.deck:
		if card.card.CustoNivel == 0:
			tempN0 += card.quantidade
		elif card.card.CustoNivel == 1:
			tempN1 += card.quantidade
		elif card.card.CustoNivel == 2:
			tempN2 += card.quantidade
		else:
			tempN3 += card.quantidade
	
	n0 = tempN0
	n1 = tempN1
	n2 = tempN2
	n3 = tempN3
