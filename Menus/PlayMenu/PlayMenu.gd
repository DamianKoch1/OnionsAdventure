extends Container


export(PackedScene) var levelSelector
var levelSelectorPath




func _ready():
	levelSelectorPath = levelSelector.resource_path 



func _on_ContinueButton_pressed():
	SaveGame.loadGame()
	SaveGame.loadPlayerState = true

func _on_LevelSelectionButton_pressed():
	get_tree().change_scene(levelSelectorPath)


func _on_OptionsButton_pressed():
		$OptionsOverlay.show()


func _on_BackButton_pressed():
	#hardcoded path because godot crashes when 2 scenes reference each other via exported packed scenes
	get_tree().change_scene("res://Menus/MainMenu/MainMenu.tscn")

func _on_NewGameButton_pressed():
	pass # replace with function body
