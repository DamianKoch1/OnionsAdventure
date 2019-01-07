extends Node

onready var anim = $AnimationPlayer

onready var lv1 = preload("res://Levels/Level 1.tscn")

func loadLv1():
	get_tree().change_scene_to(lv1)


func _on_PanelButton1_pressed():
	anim.play("1to2")


func _on_PanelButton2_pressed():
	anim.play("2to3")


func _on_PanelButton3_pressed():
	anim.play("3")
	$BGMPlayer.fadeOut()
