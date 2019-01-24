extends Container

onready var mainMenu = preload("res://Menus/MainMenu/MainMenu.tscn")
onready var dandelionCounter = $Dandelions/Label
onready var NPCCounter = $TrappedNPCs/Label


func _ready():
	dandelionCounter.text = str(SaveGame.dandelions) + "/150"
	NPCCounter.text = str(SaveGame.trappedNPCs) + "/9"

func _on_BackButton_pressed():
	UISelect.playing = true
	get_tree().change_scene_to(mainMenu)
