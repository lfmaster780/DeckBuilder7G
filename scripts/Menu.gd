extends CanvasLayer

const VERMELHO = Color(255,0,0,1)
const VERDE = Color(0,255,0,1)

var nomeDeckRegex := RegEx.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	nomeDeckRegex.compile("^[\\p{L}]+(\\s[\\p{L}]+)*$")
	
	if DeckController.deck.size() > 0:
		$Botoes/ContinuarButton.visible = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func validarNome():
	if (nomeDeckRegex.search($NovoDeckContainer/LineEdit.text) != null) and ($NovoDeckContainer/LineEdit.text != ""):
		$NovoDeckContainer/LabelNomeValido.modulate = VERDE
		$NovoDeckContainer/LabelNomeValido.text = "Nome Válido"
		return true
	else:
		$NovoDeckContainer/LabelNomeValido.modulate = VERMELHO
		$NovoDeckContainer/LabelNomeValido.text = "Nome Inválido"
		return false

func _on_NovoDeckButton_pressed():
	$NovoDeckContainer.visible = not $NovoDeckContainer.visible


func _on_ButtonGaia_pressed():
	#Depois que possivel salvar, checar se o nome é válido
	if validarNome():
		DeckController.novo()
		DeckController.nome = $NovoDeckContainer/LineEdit.text
		DeckController.galaxia = "Gaia"
		get_tree().change_scene("res://scenes/Tela Deck.tscn")


func _on_ButtonStroj_pressed():
	#Depois que possivel salvar, checar se o nome é válido
	if validarNome():
		DeckController.novo()
		DeckController.nome = $NovoDeckContainer/LineEdit.text
		DeckController.galaxia = "Stroj"
		get_tree().change_scene("res://scenes/Tela Deck.tscn")


func _on_LineEdit_text_changed(new_text):
	validarNome()


func _on_ContinuarButton_pressed():
	get_tree().change_scene("res://scenes/Tela Deck.tscn")
