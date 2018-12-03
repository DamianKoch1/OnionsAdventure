extends Container

onready var paused = false

export(PackedScene) var mainMenu
var mainMenuPath

func _ready():
	mainMenuPath = mainMenu.resource_path
	$YesNoOverlayMainMenu.connect("yesPressed", self, "loadMainMenu")
	$YesNoOverlayRestart.connect("yesPressed", self, "restart")
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
	$YesNoOverlayRestart.show()


func _on_OptionsButton_pressed():
	$OptionsOverlay.show()


func _on_MainMenuButton_pressed():
	$YesNoOverlayMainMenu.show()


func loadMainMenu():
	get_tree().change_scene(mainMenuPath)

func restart():
	get_tree().reload_current_scene()