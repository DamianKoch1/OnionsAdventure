extends Container

onready var paused = false

func _ready():
	hide()
	get_tree().paused = false

func _process(delta):
	if Input.is_action_just_pressed("pause"):
		if paused == false:
			paused = true
			show()
			get_tree().paused = true
		else:
			paused = false
			hide()
			get_tree().paused = false

func _on_ResumeButton_pressed():
	paused = false
	hide()
	get_tree().paused = false



func _on_MainMenu_Button_pressed():
	pass # replace with function body


func _on_QuitButton_pressed():
	get_tree().quit()


func _on_RestartButton_pressed():
	get_tree().reload_current_scene()
