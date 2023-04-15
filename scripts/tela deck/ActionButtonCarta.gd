extends TextureButton

var card : Card
var quantidade : int
var ID : int

func _ready():
	pass

func inicializar(carta : Card):
	card = carta
	quantidade = 1
	ID = card.ID
	$HBoxContainer/LabelNome.text = card.Nome
	$HBoxContainer/LabelQuantidade.text = str(quantidade)
	
func adicionar():
	quantidade += 1
	$HBoxContainer/LabelQuantidade.text = str(quantidade)
	
	
func _on_ActionButtonCarta_pressed():
	print("pressed")


func _on_ActionButtonCarta_mouse_entered():
	print("Mouse dentro")


func _on_ActionButtonCarta_mouse_exited():
	print("Mouse fora")
