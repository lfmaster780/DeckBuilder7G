extends Node2D

var fortalezas := []
onready var fortalezasButtons = get_node("Fortalezas")
var pagina = 0

func _ready():
	fortalezas = CardsController.buscarFortalezas(DeckController.galaxia)
	#colocando a textura correta nas cartas de fortaleza
	for f in range(fortalezas.size()):
		fortalezasButtons.get_child(f).texture_normal = fortalezas[f].textura
		
	#Garantir que se houver menos que 3 fortalezas, os nós não utilizados ficarem invisiveis
	if fortalezas.size() < 3:
		var dif = 3 - fortalezas.size()
		
		for d in range(dif):
			fortalezasButtons.get_child(2-d).visible = false
		
	updateFortaleza()

#Funcao de ajustar texto da descercao da carta
func ajustarTexto():
	var texto = ""
	for k in range(len(DeckController.fortaleza.Efeitos)):
		texto += "[b]"+str(DeckController.fortaleza.CustoEnergia[k])+" | "
		texto += DeckController.fortaleza.TipoEfeitos[k]+"[/b] \n"
		texto += DeckController.fortaleza.Efeitos[k]
		texto += "\n"
	$FortalezaAtiva/Descricao.bbcode_text = "[fill]"+texto+"[/fill]"

func updateFortaleza():
	$FortalezaAtiva/CardSprite.texture = DeckController.fortaleza.textura
	ajustarTexto()

func _on_ButtonFullScreen_pressed():
	OS.window_fullscreen = not OS.window_fullscreen


func _on_ButtonVoltar_pressed():
	get_tree().change_scene("res://scenes/Tela Deck.tscn")


func _on_ActionButtonFortaleza_pressed():
	DeckController.fortaleza = fortalezas[0+(pagina*3)]
	updateFortaleza()

func _on_ActionButtonFortaleza2_pressed():
	DeckController.fortaleza = fortalezas[1+(pagina*3)]
	updateFortaleza()

func _on_ActionButtonFortaleza3_pressed():
	DeckController.fortaleza = fortalezas[2+(pagina*3)]
	updateFortaleza()
