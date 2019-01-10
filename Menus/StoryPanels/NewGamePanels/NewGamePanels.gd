extends Node

onready var anim = $AnimationPlayer

onready var lv1 = preload("res://Levels/Level 1.tscn")

func _ready():
	MenuMusic.fadeOut(2)
	$BGMPlayer.fadeIn(2)
	
	
func loadLv1():
	get_tree().change_scene_to(lv1)


func _on_PanelButton1_pressed():
	$pageTurn.playRandomPitch()
	anim.play("1to2")


func _on_PanelButton2_pressed():
	$pageTurn.playRandomPitch()
	anim.play("2to3")


func _on_PanelButton3_pressed():
	$pageTurn.playRandomPitch()
	anim.play("3")
	$BGMPlayer.fadeOut()


func _on_SkipButton_pressed():
	if has_node("PanelButton1"):
		$PanelButton1.disabled = true
		$PanelButton1.hide()
	if has_node("PanelButton2"):
		$PanelButton2.disabled = true
		$PanelButton2.hide()
	UISelect.playing = true
	anim.play("3")
	$BGMPlayer.fadeOut()
	
