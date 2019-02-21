extends Node2D

func _ready():
	match SaveGame.currLevelId:
		1:
			$one.show()
		2:
			$two.show()
		3:
			$three.show()

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

func fadeOut():
	$Fade.oneshot(self, "loadNextLevel")

func loadNextLevel():
	SaveGame.currLevelId += 1
	var path = "Levels/Level " + str(SaveGame.currLevelId) + ".tscn"
	get_tree().change_scene(path)

func _on_SkipButton_pressed():
	loadNextLevel()
