extends Node

onready var mainMenu = preload("res://Menus/MainMenu/MainMenu.tscn")

onready var skipped = false

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	MenuMusic.fadeOut(2)
	$BGMPlayer.fadeIn(2)

func loadMainMenu():
	get_tree().change_scene_to(mainMenu)

func _on_SkipButton_pressed():
	if skipped != true:
		skipped = true
		UISelect.playing = true
		$BGMPlayer.fadeOut()
		loadMainMenu()
	
func _on_PanelButton2_animFinished():
	loadMainMenu()
