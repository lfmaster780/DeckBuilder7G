extends Node2D

onready var buttons := $MaoInicial.get_children()
var decklist := []
var shuffledDeck := []

var mulligan = true
#PRIMEIRO JOGADOR = 0 | SEGUNDO JOGADOR = 1
var jogador := 0

func _ready():
	$LabelDeck.text = DeckController.nome
	randomize()
	#Carregar listagem do Deck
	for item in DeckController.deck:
		if item.quantidade == 2:
			decklist.append(item.card)
			decklist.append(item.card)
		else:
			decklist.append(item.card)
	
	shuffledDeck = decklist.duplicate()
	shuffledDeck.shuffle()
		
	#Coneta o sinal de quando se passa o mouse pela carta em cada carta (ButtonCarta)
	for button in buttons:
		button.connect("mouseON",self,"destacar")
		
	gerarMao()
		
func _process(delta):
	$ButtonMulligan.visible = mulligan
	$LabelMulligan.visible = mulligan

func destacar(carta):
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
	
	$CardDestaque.bbcode_text = descricao
	
func resetar():
	$CardDestaque.bbcode_text = ""
	randomize()
	shuffledDeck = decklist.duplicate()
	shuffledDeck.shuffle()
	mulligan = true
	
func gerarMao():
	$MaoInicial.visible = false
	if jogador == 0:
		for button in buttons.slice(0,5):
			button.setCard(shuffledDeck.pop_front())
			button.visible = true
		
		buttons[6].visible = false
	
	else:
		for button in buttons:
			button.setCard(shuffledDeck.pop_front())
			button.visible = true
	
	$MaoInicial.visible = true

func mulligar():
	for button in buttons:
		if button.modo == 1:
			button.setCard(shuffledDeck.pop_front())
		
	self.mulligan = false


func _on_ButtonVoltar_pressed():
	get_tree().change_scene("res://scenes/TelaDeck.tscn")


func _on_ButtonNovaMao_pressed():
	self.resetar()
	self.gerarMao()


func _on_OptionButtonJogador_item_selected(index):
	var selecionada = $OptionButtonJogador.get_index()
	jogador = selecionada
	resetar()
	gerarMao()
