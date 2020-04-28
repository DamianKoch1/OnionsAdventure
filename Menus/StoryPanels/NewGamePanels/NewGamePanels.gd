extends Node

onready var lv1 = preload("res://Levels/Level 1.tscn")

onready var skipped = false

func _ready():
	$BGMPlayer.fadeIn(2)
	$Fade.fadeIn(2)

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

func loadLv1():
	get_tree().change_scene_to(lv1)

func _on_SkipButton_pressed():
	if skipped:
		return
	skipped = true
	$BGMPlayer.fadeOut()
	loadLv1()



func _on_PanelButton6_animFinished():
	loadLv1()
