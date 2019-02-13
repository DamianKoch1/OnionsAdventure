extends Container

onready var mainMenu = preload("res://Menus/MainMenu/MainMenu.tscn")

func _ready():
	$BackButton.grab_focus()

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		_on_BackButton_pressed()

func _on_BackButton_pressed():
	UISelect.playing = true
	get_tree().change_scene_to(mainMenu)

