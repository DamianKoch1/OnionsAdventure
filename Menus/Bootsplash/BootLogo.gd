extends Sprite

onready var mainmenu = preload("res://Menus/MainMenu/MainMenu.tscn")

func mainMenu():
	get_tree().change_scene_to(mainmenu)