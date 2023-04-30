extends Node2D

onready var logo7g = load("res://sprites/gui/sevenLogo.png")

func _ready():
	$AnimationPlayer.play("EsmaecerLogo")


func _on_AnimationPlayer_animation_finished(anim_name):
	get_tree().change_scene("res://scenes/Menu.tscn")
