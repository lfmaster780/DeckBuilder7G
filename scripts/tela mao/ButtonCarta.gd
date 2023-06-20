extends TextureButton

var card : Card
#MODO 0 = NAO SELECIONADO | MODO 1 = SELECIONADO
var modo := 0

signal mouseON(carta)

func _ready():
	pass

func setCard(carta : Card):
	self.card = carta
	$Sprite.texture = card.textura
	self.modo = 0
	$Animacoes.play("Normalizar")

func _on_ButtonCarta_pressed():
	if modo == 0:
		modo = 1
		$Animacoes.play("Esmaecer")
	
	else:
		modo = 0
		$Animacoes.play("Normalizar")


func _on_ButtonCarta_mouse_entered():
	#Enviar sinal de destacado
	emit_signal("mouseON",card)
