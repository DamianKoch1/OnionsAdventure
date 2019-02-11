extends Container

onready var mainMenu = preload("res://Menus/MainMenu/MainMenu.tscn")
onready var dandelionCounter = $Dandelions/Label
onready var NPCCounter = $TrappedNPCs/Label
onready var atPage = 1


func _ready():
	dandelionCounter.text = str(SaveGame.dandelions) + "/200"
	NPCCounter.text = str(SaveGame.trappedNPCs) + "/12"
	$Page1.show()
	$Page2.hide()
	$Page3.hide()
	$Page4.hide()
	$BackButton.hide()
	$NextButton.grab_focus()

func _on_BackButton_pressed():
	$NextButton.show()
	if atPage == 2:
		$Page1.show()
		$Page2.hide()
		atPage = 1
		$BackButton.hide()
		$NextButton.grab_focus()
	elif atPage == 3:
		$Page2.show()
		$Page3.hide()
		atPage = 2
	elif atPage == 4:
		$Page3.show()
		$Page4.hide()
		atPage = 3

func _on_NextButton_pressed():
	$BackButton.show()
	if atPage == 1:
		$Page1.hide()
		$Page2.show()
		atPage = 2
	elif atPage == 2:
		$Page2.hide()
		$Page3.show()
		atPage = 3
	elif atPage == 3:
		$Page3.hide()
		$Page4.show()
		atPage = 4
		$NextButton.hide()
		$BackButton.grab_focus()

func _on_MainMenuButton_pressed():
	UISelect.playing = true
	get_tree().change_scene_to(mainMenu)
