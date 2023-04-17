extends CanvasLayer

const VERMELHO = Color(255,0,51,1)
const VERDE = Color(0,255,0,1)
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func validarNome():
	$NovoDeckContainer/LabelNomeValido.modulate = VERDE
	$NovoDeckContainer/LabelNomeValido.text = "Nome Válido"
	return true

func _on_NovoDeckButton_pressed():
	$NovoDeckContainer.visible = not $NovoDeckContainer.visible


func _on_ButtonGaia_pressed():
	#Depois que possivel salvar, checar se o nome é válido
	if validarNome():
		DeckController.nome = $NovoDeckContainer/LineEdit.text
		DeckController.galaxia = "Gaia"
		get_tree().change_scene("res://scenes/Tela Deck.tscn")


func _on_ButtonStroj_pressed():
	#Depois que possivel salvar, checar se o nome é válido
	if validarNome():
		DeckController.nome = $NovoDeckContainer/LineEdit.text
		DeckController.galaxia = "Stroj"
		get_tree().change_scene("res://scenes/Tela Deck.tscn")
