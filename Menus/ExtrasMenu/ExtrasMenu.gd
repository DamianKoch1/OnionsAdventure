extends Container

onready var mainMenu = preload("res://Menus/MainMenu/MainMenu.tscn")
onready var dandelionCounter = $Dandelions/Label
onready var NPCCounter = $TrappedNPCs/Label
onready var atPage = 1


func _ready():
	dandelionCounter.text = str(SaveGame.dandelions) + "/150"
	NPCCounter.text = str(SaveGame.trappedNPCs) + "/9"
	$Page1.show()
	$Page2.hide()
	$Page3.hide()

func _on_BackButton_pressed():
	if atPage == 2:
		$Page1.show()
		$Page2.hide()
		atPage = 1
	elif atPage == 3:
		$Page2.show()
		$Page3.hide()
		atPage = 2

func _on_NextButton_pressed():
	if atPage == 1:
		$Page1.hide()
		$Page2.show()
		atPage = 2
	elif atPage == 2:
		$Page2.hide()
		$Page3.show()
		atPage = 3

func _on_MainMenuButton_pressed():
	UISelect.playing = true
	get_tree().change_scene_to(mainMenu)
