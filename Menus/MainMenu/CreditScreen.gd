extends Container

onready var mainMenu = preload("res://Menus/MainMenu/MainMenu.tscn")
onready var keyboardButtonFocus = false

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		_on_BackButton_pressed()
	if Input.is_action_just_pressed("ui_up") || Input.is_action_just_pressed("ui_down"):
		if keyboardButtonFocus == false:
				$BackButton.grab_focus()
				keyboardButtonFocus = true


func _on_BackButton_pressed():
	UISelect.playing = true
	get_tree().change_scene_to(mainMenu)

