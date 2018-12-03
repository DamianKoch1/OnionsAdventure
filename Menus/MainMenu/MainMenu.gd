extends Container

export(PackedScene) var levelSelector
var levelSelectorPath

func _ready():
	levelSelectorPath = levelSelector.resource_path 
	$YesNoOverlay/NoButton.connect("pressed", self, "noPressed")
	$YesNoOverlay/YesButton.connect("pressed", self, "yesPressed")
	$YesNoOverlay.hide()
	global.diff = global.normal


func _on_NewGameButton_pressed():
	pass # replace with function body


func _on_ContinueButton_pressed():
	pass # replace with function body


func _on_ConceptArtButton_pressed():
	pass # replace with function body


func _on_CreditsButton_pressed():
	pass # replace with function body


func _on_LevelSelectionButton_pressed():
	get_tree().change_scene(levelSelectorPath)


func _on_QuitButton_pressed():
	$YesNoOverlay.show()


func _on_OptionsButton_pressed():
	pass # replace with function body

func yesPressed():
	get_tree().quit()

func noPressed():
	$YesNoOverlay.hide()

