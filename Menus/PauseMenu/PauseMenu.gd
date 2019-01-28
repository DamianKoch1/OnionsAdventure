extends Container

onready var paused = false

onready var mainMenu = preload("res://Menus/MainMenu/MainMenu.tscn")


func _ready():
	$YesNoOverlayMainMenu.connect("yesPressed", self, "loadMainMenu")
	$YesNoOverlayRestart.connect("yesPressed", self, "restart")
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)


func _process(delta):
	if Input.is_action_just_pressed("pause"):
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
		else:
			$OptionsOverlay.hide()

func _on_ResumeButton_pressed():
	UISelect.playing = true
	paused = false
	get_tree().paused = false
	hide()
	


func _on_RestartButton_pressed():
	UISelect.playing = true
	$YesNoOverlayRestart.show()


func _on_OptionsButton_pressed():
	UISelect.playing = true
	$OptionsOverlay.show()


func _on_MainMenuButton_pressed():
	UISelect.playing = true
	$YesNoOverlayMainMenu.show()


func loadMainMenu():
	get_tree().paused = false
	get_tree().change_scene_to(mainMenu)

func restart():
	get_tree().paused = false
	get_tree().reload_current_scene()

