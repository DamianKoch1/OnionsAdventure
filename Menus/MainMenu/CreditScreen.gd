extends Container

onready var mainMenu = preload("res://Menus/MainMenu/MainMenu.tscn")

func _on_BackButton_pressed():
	$UISelect.playing = true
	get_tree().change_scene_to(mainMenu)

