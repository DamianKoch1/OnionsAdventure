extends Container

#hardcoded all scene paths because godot crashes if scenes reference each other using exported packedscenes
onready var playMenu = preload("res://Menus/PlayMenu/PlayMenu.tscn")
onready var creditscreen = preload("res://Menus/MainMenu/CreditScreen.tscn")

func _ready():
	$YesNoOverlayQuit.connect("yesPressed", self, "quit")
	$YesNoOverlayQuit.hide()
	global.diff = global.normal
	if MenuMusic.playing == false:
		MenuMusic.playing = true


func _on_CreditsButton_pressed():
	UISelect.playing = true
	get_tree().change_scene_to(creditscreen)


func _on_QuitButton_pressed():
	UISelect.playing = true
	$YesNoOverlayQuit.show()


func _on_OptionsButton_pressed():
	UISelect.playing = true
	$OptionsOverlay.show()

func quit():
	UISelect.playing = true
	get_tree().quit()


func _on_PlayButton_pressed():
	UISelect.playing = true
	get_tree().change_scene_to(playMenu)



func _on_ExtrasButton_pressed():
	UISelect.playing = true
	
