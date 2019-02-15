extends Container

onready var mainMenu = preload("res://Menus/MainMenu/MainMenu.tscn")
onready var fade = $Fade


func _ready():
	fade.fadeIn()
	$BackButton.grab_focus()

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		_on_BackButton_pressed()

func _on_BackButton_pressed():
	fade.oneshot(self, "mainMenu", 2)
	
func mainMenu():
	get_tree().change_scene_to(mainMenu)

