extends Container

onready var paused = false

onready var mainMenu = preload("res://Menus/MainMenu/MainMenu.tscn")

onready var fade = $Fade

func _ready():
	$YesNoOverlayMainMenu.connect("yesPressed", self, "mainMenuFade")
	$YesNoOverlayMainMenu.connect("noPressed", self, "cancel")
	$YesNoOverlayRestart.connect("yesPressed", self, "restartFade")
	$YesNoOverlayRestart.connect("noPressed", self, "cancel")
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	

#cursor/pause menu on pressing escape, hide cursor ingame, always put focus on correct button
func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		if $YesNoOverlayMainMenu.visible == false && $YesNoOverlayRestart.visible == false:
			if $OptionsOverlay.visible == false:
				if paused == false:
					paused = true
					show()
					$ResumeButton.grab_focus()
					Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
					get_tree().paused = true
				else:
					paused = false
					hide()
					get_tree().paused = false
					Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
			else:
				$OptionsOverlay.hide()
				$ResumeButton.grab_focus()
		else:
			cancel()
			$ResumeButton.grab_focus()

func _on_ResumeButton_pressed():
	paused = false
	get_tree().paused = false
	hide()
	
func _on_RestartButton_pressed():
	$YesNoOverlayRestart.show()
	$YesNoOverlayRestart/NoButton.grab_focus()

func _on_OptionsButton_pressed():
	fade.oneshot(self, "options", 2)

func options():
	$OptionsOverlay.show()
	$OptionsOverlay/BackButton.grab_focus()
	fade.fadeIn(2)

func _on_MainMenuButton_pressed():
	$YesNoOverlayMainMenu.show()
	$YesNoOverlayMainMenu/NoButton.grab_focus()

func mainMenuFade():
	get_tree().paused = false
	fade.oneshot(self, "mainMenu")

func mainMenu():
	get_tree().change_scene_to(mainMenu)
	
func restartFade():
	get_tree().paused = false
	fade.oneshot(self, "restart")

func restart():
	get_tree().reload_current_scene()
	
func cancel():
	$YesNoOverlayMainMenu.hide()
	$YesNoOverlayRestart.hide()

#options menu back button
func _on_BackButton_pressed():
	fade.oneshot(self, "back", 2) 

func back():
	$OptionsOverlay.hide()
	fade.fadeIn(2)
	$ResumeButton.grab_focus()