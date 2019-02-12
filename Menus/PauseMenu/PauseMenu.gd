extends Container

onready var paused = false
onready var keyboardButtonFocus = false

onready var mainMenu = preload("res://Menus/MainMenu/MainMenu.tscn")

func _ready():
	$YesNoOverlayMainMenu.connect("yesPressed", self, "loadMainMenu")
	$YesNoOverlayMainMenu.connect("noPressed", self, "cancel")
	$YesNoOverlayRestart.connect("yesPressed", self, "restart")
	$YesNoOverlayRestart.connect("noPressed", self, "cancel")
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	

#cursor/pause menu on pressing escape, hide cursor ingame
func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		if $YesNoOverlayMainMenu.visible == false && $YesNoOverlayRestart.visible == false:
			if $OptionsOverlay.visible == false:
				if paused == false:
					paused = true
					show()
					Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
					get_tree().paused = true
				else:
					paused = false
					hide()
					get_tree().paused = false
					Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
					keyboardButtonFocus = false
			else:
				$OptionsOverlay.hide()
				keyboardButtonFocus = false
		else:
			cancel()
			keyboardButtonFocus = false
			
	if Input.is_action_just_pressed("ui_up") || Input.is_action_just_pressed("ui_down"):
		if paused == true && keyboardButtonFocus == false:
			keyboardButtonFocus = true
			if $YesNoOverlayMainMenu.visible == true:
				$YesNoOverlayMainMenu/NoButton.grab_focus()
			elif $YesNoOverlayRestart.visible == true:
				$YesNoOverlayRestart/NoButton.grab_focus()
			elif $OptionsOverlay.visible == true:
				$OptionsOverlay/BackButton.grab_focus()
				keyboardButtonFocus = false
			else:
				$ResumeButton.grab_focus()
			

func _on_ResumeButton_pressed():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	keyboardButtonFocus = false
	UISelect.playing = true
	paused = false
	get_tree().paused = false
	hide()
	
func _on_RestartButton_pressed():
	UISelect.playing = true
	$YesNoOverlayRestart.show()
	keyboardButtonFocus = false

func _on_OptionsButton_pressed():
	UISelect.playing = true
	$OptionsOverlay.show()
	keyboardButtonFocus = false

func _on_MainMenuButton_pressed():
	UISelect.playing = true
	$YesNoOverlayMainMenu.show()
	keyboardButtonFocus = false

func loadMainMenu():
	get_tree().paused = false
	get_tree().change_scene_to(mainMenu)

func restart():
	get_tree().paused = false
	get_tree().reload_current_scene()
	
func cancel():
	$YesNoOverlayMainMenu.hide()
	$YesNoOverlayRestart.hide()
	keyboardButtonFocus = false