extends CanvasLayer

const VERMELHO = Color(255,0,0,1)
const VERDE = Color(0,255,0,1)

var nomeDeckRegex := RegEx.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	# Regex que define que um nome precisa ter cadeia de qualquer tamnho caracteres
	# unicode ou número, podendo ser separados por um espaço em branco
	nomeDeckRegex.compile("^[\\p{L}0-9]+(\\s[\\p{L}0-9]+)*$")
	
	#Se o deck atual na memória não estiver vazio, há opção de continuar de onde parou
	if DeckController.deck.size() > 0:
		$Botoes/ContinuarButton.visible = true
		

func validarNome():
	#Checar se já tem um deck salvo com o mesmo nome
	for save in AppController.saves:
		if save == ($NovoDeckContainer/LineEdit.text + ".deck"):
			$NovoDeckContainer/LabelNomeValido.modulate = VERMELHO
			$NovoDeckContainer/LabelNomeValido.text = "Nome Inválido"
			return false
		
	#checar se não é vazio e se é válida pela "Regex" definida no início (ready)
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
		DeckController.fortaleza = CardsController.buscarFortalezaID("F2")
		get_tree().change_scene("res://scenes/TelaDeck.tscn")


func _on_ButtonStroj_pressed():
	#Depois que possivel salvar, checar se o nome é válido
	if validarNome():
		DeckController.novo()
		DeckController.nome = $NovoDeckContainer/LineEdit.text
		DeckController.galaxia = "Stroj"
		DeckController.fortaleza = CardsController.buscarFortalezaID("F1")
		get_tree().change_scene("res://scenes/TelaDeck.tscn")


func _on_LineEdit_text_changed(new_text):
	validarNome()


func _on_ContinuarButton_pressed():
	get_tree().change_scene("res://scenes/TelaDeck.tscn")


func _on_CarregarButton_pressed():
	$FileDialog.popup()


func _on_FileDialog_file_selected(path):
	print("Arquivo: ",path)
	DeckController.carregar(path)
	get_tree().change_scene("res://scenes/TelaDeck.tscn")


func _on_FullScreenButton_pressed():
	OS.window_fullscreen = not OS.window_fullscreen


func _on_Pagina7GButton_pressed():
	OS.shell_open("https://sevengalaxiestcg.com")


func _on_AnuButton_pressed():
	OS.shell_open("https://www.instagram.com/anugamestudio/")


func _on_GitButton_pressed():
	OS.shell_open("https://github.com/lfmaster780/DeckBuilder7G")


func _on_SairButton_pressed():
	get_tree().quit()


func _on_CreditosButton_pressed():
	get_tree().change_scene("res://scenes/TelaCreditos.tscn")
