extends Container

#hardcoded all scene paths because godot crashes if two scenes reference each other using exported packedscenes
onready var playMenu = preload("res://Menus/PlayMenu/PlayMenu.tscn")
onready var creditscreen = preload("res://Menus/MainMenu/CreditScreen.tscn")
onready var extrasMenu = preload("res://Menus/ExtrasMenu/ExtrasMenu.tscn")

func _ready():
	$YesNoOverlayQuit.connect("yesPressed", self, "quit")
	$YesNoOverlayQuit.connect("noPressed", self, "cancel")
	$YesNoOverlayQuit.hide()
	$PlayButton.grab_focus()
	if MenuMusic.playing == false:
		MenuMusic.fadeIn()
	

func _on_CreditsButton_pressed():
	UISelect.playing = true
	get_tree().change_scene_to(creditscreen)


func _on_QuitButton_pressed():
	if $YesNoOverlayQuit.visible == false:
		UISelect.playing = true
		$YesNoOverlayQuit.show()


func _on_OptionsButton_pressed():
	UISelect.playing = true
	$OptionsOverlay.show()

func quit():
	get_tree().quit()

func cancel():
	$YesNoOverlayQuit.hide()
	$PlayButton.grab_focus()

func _on_PlayButton_pressed():
	UISelect.playing = true
	get_tree().change_scene_to(playMenu)



func _on_ExtrasButton_pressed():
	UISelect.playing = true
	get_tree().change_scene_to(extrasMenu)
	
func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		if $YesNoOverlayQuit.visible == false:
			_on_QuitButton_pressed()
		else:
			cancel()