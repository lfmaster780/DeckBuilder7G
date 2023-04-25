extends TextureButton

var card : Card
var quantidade : int
var ID : int

signal destaque(carta)

func _ready():
	pass

func inicializar(carta : Card,qtd := 1):
	card = carta
	quantidade = qtd
	ID = card.ID
	$HBoxContainer/LabelNome.text = card.Nome
	$HBoxContainer/LabelQuantidade.text = str(quantidade)
	
func adicionar():
	quantidade += 1
	$HBoxContainer/LabelQuantidade.text = str(quantidade)

func retirar():
	quantidade -= 1
	if quantidade < 1:
		queue_free()
	$HBoxContainer/LabelQuantidade.text = str(quantidade)
	
func _on_ActionButtonCarta_pressed():
	get_parent().get_parent().retirar(card)


func _on_ActionButtonCarta_mouse_entered():
	emit_signal("destaque",card)


func _on_ActionButtonCarta_mouse_exited():
	#por enquanto sem uso
	pass
