extends Container

onready var mainMenu = preload("res://Menus/MainMenu/MainMenu.tscn")
onready var dandelionCounter = $Dandelions/Label
onready var NPCCounter = $TrappedNPCs/Label
onready var atPage = 1
onready var anim = $AnimationPlayer
onready var page = $Page
onready var fade = $Fade


func _ready():
	fade.fadeIn()
	dandelionCounter.text = str(SaveGame.dandelions) + "/200"
	NPCCounter.text = str(SaveGame.trappedNPCs) + "/12"
	$BackButton.hide()
	$NextButton.grab_focus()

	

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		_on_MainMenuButton_pressed()

func _on_BackButton_pressed():
	if anim.is_playing() == false:
		$NextButton.show()
		if atPage == 2:
			anim.play_backwards("1to2")
			atPage = 1
			$BackButton.hide()
			$NextButton.grab_focus()
		elif atPage == 3:
			anim.play_backwards("2to3")
			atPage = 2
		elif atPage == 4:
			anim.play_backwards("3to4")
			atPage = 3
		page.text = "Page " + str(atPage) + "/4"

func _on_NextButton_pressed():
	if anim.is_playing() == false:
		$BackButton.show()
		if atPage == 1:
			anim.play("1to2")
			atPage = 2
		elif atPage == 2:
			anim.play("2to3")
			atPage = 3
		elif atPage == 3:
			anim.play("3to4")
			atPage = 4
			$NextButton.hide()
			$BackButton.grab_focus()
		page.text = "Page " + str(atPage) + "/4"

func _on_MainMenuButton_pressed():
	fade.oneshot(self, "mainMenu", 2)

func mainMenu():
	get_tree().change_scene_to(mainMenu)
