extends Container


onready var mainMenu = preload("res://Menus/MainMenu/MainMenu.tscn")

onready var fade = $Fade

#remove level button if player hasnt unlocked (entered) corresponding level
func _ready():
	fade.fadeIn()
	$removeLater/Label2.text = "highest level id: " + str(SaveGame.highestLevelId)
	for button in $LevelButtons.get_children():
		if int(button.name) > SaveGame.highestLevelId:
			button.queue_free()
	$LevelButtons/Level1Button.grab_focus()

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		_on_BackButton_pressed()



func _on_BackButton_pressed():
	fade.oneshot(self, "mainMenu", 2)

func mainMenu():
	get_tree().change_scene_to(mainMenu)
