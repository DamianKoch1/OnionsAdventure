extends Container


onready var mainMenu = preload("res://Menus/MainMenu/MainMenu.tscn")

onready var anim = $AnimationPlayer
onready var fade = $Fade

onready var atLevel = 1

#remove level button if player hasnt unlocked (entered) corresponding level
func _ready():
	fade.fadeIn()
	$LevelButtons/Level1Button.grab_focus()
	$PrevButton.hide()
	if SaveGame.highestLevelId == 1:
		$NextButton.disabled = true

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		_on_BackButton_pressed()



func _on_BackButton_pressed():
	fade.oneshot(self, "mainMenu", 2)

func mainMenu():
	get_tree().change_scene_to(mainMenu)


func _on_NextButton_pressed():
	if anim.is_playing() == false:
		$PrevButton.show()
		if atLevel == 1:
			anim.play("1to2")
			atLevel = 2
		elif atLevel == 2:
			anim.play("2to3")
			atLevel = 3
		elif atLevel == 3:
			anim.play("3to4")
			atLevel = 4
			$NextButton.hide()
			$PrevButton.grab_focus()
		if atLevel == SaveGame.highestLevelId:
			$NextButton.disabled = true
		


func _on_PrevButton_pressed():
	if anim.is_playing() == false:
		$NextButton.show()
		if atLevel == 2:
			anim.play_backwards("1to2")
			atLevel = 1
			$PrevButton.hide()
			$NextButton.grab_focus()
		elif atLevel == 3:
			anim.play_backwards("2to3")
			atLevel = 2
		elif atLevel == 4:
			anim.play_backwards("3to4")
			atLevel = 3
		$NextButton.disabled = false


