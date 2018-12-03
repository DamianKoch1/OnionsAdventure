extends Container

onready var paused = false

export(PackedScene) var mainMenu
var mainMenuPath

func _ready():
	mainMenuPath = mainMenu.resource_path
	$YesNoOverlay/NoButton.connect("pressed", self, "noPressed")
	$YesNoOverlay/YesButton.connect("pressed", self, "yesPressed")
	$YesNoOverlay.hide()
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


func _on_RestartButton_pressed():
	get_tree().reload_current_scene()


func _on_OptionsButton_pressed():
	
	pass


func _on_MainMenuButton_pressed():
	$YesNoOverlay.show()
	pass

func noPressed():
	$YesNoOverlay.hide()

func yesPressed():
	get_tree().change_scene(mainMenuPath)