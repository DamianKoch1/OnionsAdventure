extends Container


onready var prototype = preload("res://Levels/Prototype 0.tscn")
onready var playMenu = preload("res://Menus/PlayMenu/PlayMenu.tscn")

#remove level button if player hasnt unlocked (entered) corresponding level
func _ready():
	$removeLater/Label2.text = "highest level id: " + str(SaveGame.highestLevelId)
	for button in $LevelButtons.get_children():
		if int(button.name) > SaveGame.highestLevelId:
			button.queue_free()
	$LevelButtons/Level1Button.grab_focus()

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		_on_BackButton_pressed()

func _on_OptionsButton_pressed():
	UISelect.playing = true
	$OptionsOverlay.show()


func _on_Level0Button_pressed():
	UISelect.playing = true
	SaveGame.currLevelId = 0
	get_tree().change_scene_to(prototype)


func _on_BackButton_pressed():
	UISelect.playing = true
	get_tree().change_scene_to(playMenu)
