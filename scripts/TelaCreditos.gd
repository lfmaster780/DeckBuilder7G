extends CanvasLayer


func _ready():
	pass


func _on_VoltarButton_pressed():
	get_tree().change_scene("res://scenes/Menu.tscn")
