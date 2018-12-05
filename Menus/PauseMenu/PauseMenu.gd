extends Container

onready var paused = false

onready var mainMenu = preload("res://Menus/MainMenu/MainMenu.tscn")


func _ready():
	print(global.newGame)
	$YesNoOverlayMainMenu.connect("yesPressed", self, "loadMainMenu")
	$YesNoOverlayRestart.connect("yesPressed", self, "restart")
	if global.newGame == false:
		hide()
		get_tree().paused = true
	else:
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
	get_tree().change_scene_to(mainMenu)

func restart():
	var path = "Levels/Level " + str(global.currLevelId) + ".tscn"
	get_tree().change_scene(path)

