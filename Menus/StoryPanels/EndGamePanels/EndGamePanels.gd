extends Node

onready var mainMenu = preload("res://Menus/MainMenu/MainMenu.tscn")

onready var skipped = false

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	MenuMusic.fadeOut(2)
	$BGMPlayerIntro.fadeIn(2)

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		simulateClick()
	if Input.is_action_just_pressed("ui_cancel"):
		_on_SkipButton_pressed()

#simulating a click using space/enter so coding panel order logic isnt necessary
func simulateClick():
	var ev = InputEventMouseButton.new()
	ev.set_button_index(BUTTON_LEFT)
	ev.set_pressed(true)
	get_tree().input_event(ev)
	ev.set_pressed(false)
	get_tree().input_event(ev)
	Input.parse_input_event(ev)

func loadMainMenu():
	get_tree().change_scene_to(mainMenu)

func _on_SkipButton_pressed():
	if skipped != true:
		skipped = true
		UISelect.playing = true
		$BGMPlayerIntro.fadeOut()
		loadMainMenu()
	
func _on_PanelButton2_animFinished():
	loadMainMenu()
