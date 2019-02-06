extends Node

onready var lv1 = preload("res://Levels/Level 1.tscn")

onready var skipped = false

func _ready():
	MenuMusic.fadeOut(2)
	$BGMPlayer.fadeIn(2)

func _process(delta):
	print($BGMPlayer.volume_db)

func loadLv1():
	get_tree().change_scene_to(lv1)

func _on_SkipButton_pressed():
	if skipped != true:
		skipped = true
		UISelect.playing = true
		$BGMPlayer.fadeOut()
		loadLv1()
	
func _on_PanelButton3_animFinished():
	loadLv1()
