extends Container

#hardcoded all scene paths because godot crashes if two scenes reference each other using exported packedscenes
onready var playMenu = preload("res://Menus/PlayMenu/PlayMenu.tscn")
onready var creditscreen = preload("res://Menus/MainMenu/CreditScreen.tscn")
onready var extrasMenu = preload("res://Menus/ExtrasMenu/ExtrasMenu.tscn")
onready var keyboardButtonFocus = false

func _ready():
	$YesNoOverlayQuit.connect("yesPressed", self, "quit")
	$YesNoOverlayQuit.connect("noPressed", self, "cancel")
	$YesNoOverlayQuit.hide()
	if MenuMusic.playing == false:
		MenuMusic.fadeIn()
	
func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		if $OptionsOverlay.visible == false:
			if $YesNoOverlayQuit.visible == false:
				_on_QuitButton_pressed()
			else:
				cancel()
		keyboardButtonFocus = false
	if Input.is_action_just_pressed("ui_up") || Input.is_action_just_pressed("ui_down") || Input.is_action_just_pressed("ui_right"):
		if keyboardButtonFocus == false:
			if $OptionsOverlay.visible == true:
				$OptionsOverlay/BackButton.grab_focus()
			elif $YesNoOverlayQuit.visible == true:
				$YesNoOverlayQuit/NoButton.grab_focus()
				keyboardButtonFocus = true
			else:
				$PlayButton.grab_focus()
				keyboardButtonFocus = true


func _on_CreditsButton_pressed():
	UISelect.playing = true
	get_tree().change_scene_to(creditscreen)


func _on_QuitButton_pressed():
	if $YesNoOverlayQuit.visible == false:
		UISelect.playing = true
		$YesNoOverlayQuit.show()
		keyboardButtonFocus = false


func _on_OptionsButton_pressed():
	UISelect.playing = true
	$YesNoOverlayQuit.hide()
	$OptionsOverlay.show()
	keyboardButtonFocus = false
	

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
