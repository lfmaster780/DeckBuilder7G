extends TextureButton

var card : Card
#MODO 0 = NAO SELECIONADO | MODO 1 = SELECIONADO
var modo := 0

signal mouseON(carta)

func _ready():
	pass

func setCard(carta : Card):
	#Inicializacao definindo a carta representada pelo botao
	self.card = carta
	$Sprite.texture = card.textura
	self.modo = 0
	$Animacoes.play("Normalizar")

func _on_ButtonCarta_pressed():
	#Quando clicado, se nao selecionado é selecionado, e vice-versa
	if modo == 0:
		modo = 1
		$Animacoes.play("Esmaecer")
	
	else:
		modo = 0
		$Animacoes.play("Normalizar")


func _on_ButtonCarta_mouse_entered():
	#Enviar sinal de destacado quando o mouse entrar na area da carta
	emit_signal("mouseON",card)
