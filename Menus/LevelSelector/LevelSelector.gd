extends Container


onready var prototype = preload("res://Levels/Prototype 0.tscn")
onready var playMenu = preload("res://Menus/PlayMenu/PlayMenu.tscn")

func _on_QuitButton_pressed():
	UISelect.playing = true
	get_tree().quit()


func _on_OptionsButton_pressed():
	UISelect.playing = true
	$OptionsOverlay.show()


func _on_Level0Button_pressed():
	UISelect.playing = true
	global.currLevelId = 0
	get_tree().change_scene_to(prototype)


func _on_BackButton_pressed():
	UISelect.playing = true
	get_tree().change_scene_to(playMenu)
