extends Container

export(PackedScene) var levelSelector
var levelSelectorPath

func _ready():
	levelSelectorPath = levelSelector.resource_path 
	$YesNoOverlayQuit.connect("yesPressed", self, "quit")
	$YesNoOverlayQuit.hide()
	global.diff = global.normal


func _on_NewGameButton_pressed():
	pass # replace with function body


func _on_ContinueButton_pressed():
	SaveGame.loadGame()
	SaveGame.loadPlayerState = true


func _on_ConceptArtButton_pressed():
	pass # replace with function body


func _on_CreditsButton_pressed():
	pass # replace with function body


func _on_LevelSelectionButton_pressed():
	get_tree().change_scene(levelSelectorPath)


func _on_QuitButton_pressed():
	$YesNoOverlay.show()


func _on_OptionsButton_pressed():
	$OptionsOverlay.show()

func quit():
	get_tree().quit()


