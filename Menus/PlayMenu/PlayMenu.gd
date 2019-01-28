extends Container

onready var levelSelector = preload("res://Menus/LevelSelector/LevelSelector.tscn")
onready var mainMenu = preload("res://Menus/MainMenu/MainMenu.tscn")

func _on_ContinueButton_pressed():
	UISelect.playing = true
	SaveGame.loadGame()
	SaveGame.loadPlayerState = true

func _on_LevelSelectorButton_pressed():
	SaveGame.checkLevelProgress()
	UISelect.playing = true
	SaveGame.loadPlayerState = false
	get_tree().change_scene_to(levelSelector)


func _on_BackButton_pressed():
	UISelect.playing = true
	get_tree().change_scene_to(mainMenu)


func _on_NewGameButton_pressed():
	SaveGame.deleteSave()
	SaveGame.loadPlayerState = false
	UISelect.playing = true
	get_tree().change_scene("res://Menus/StoryPanels/NewGamePanels/NewGamePanels.tscn")

