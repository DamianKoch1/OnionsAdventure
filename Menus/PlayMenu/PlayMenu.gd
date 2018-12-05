extends Container

onready var levelSelector = preload("res://Menus/LevelSelector/LevelSelector.tscn")
onready var newGamePanels = load("res://Menus/StoryPanels/NewGamePanels/NewGamePanels.tscn")
onready var mainMenu = preload("res://Menus/MainMenu/MainMenu.tscn")

func _on_ContinueButton_pressed():
	SaveGame.loadGame()
	SaveGame.loadPlayerState = true

func _on_LevelSelectorButton_pressed():
	get_tree().change_scene_to(levelSelector)


func _on_OptionsButton_pressed():
		$OptionsOverlay.show()


func _on_BackButton_pressed():
	get_tree().change_scene_to(mainMenu)


func _on_NewGameButton_pressed():
	get_tree().change_scene_to(newGamePanels)

