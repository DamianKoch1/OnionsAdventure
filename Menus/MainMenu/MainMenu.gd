extends Container


onready var playMenu = preload("res://Menus/PlayMenu/PlayMenu.tscn")

func _ready():
	$YesNoOverlayQuit.connect("yesPressed", self, "quit")
	$YesNoOverlayQuit.hide()
	global.diff = global.normal


func _on_ConceptArtButton_pressed():
	pass # replace with function body


func _on_CreditsButton_pressed():
	pass # replace with function body



func _on_QuitButton_pressed():
	$YesNoOverlayQuit.show()


func _on_OptionsButton_pressed():
	$OptionsOverlay.show()

func quit():
	get_tree().quit()


func _on_PlayButton_pressed():
	get_tree().change_scene_to(playMenu)

