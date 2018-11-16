extends Container

func loadLevel():
	var path = "Levels/Level " + str(global.currLevelId) + ".tscn"
	get_tree().change_scene(path)


func _on_MainMenuButton_pressed():
	pass # replace with function body


func _on_Level1Button_pressed():
	global.currLevelId = 1
	loadLevel()


func _on_Level2Button_pressed():
	global.currLevelId = 2
	loadLevel()


func _on_QuitButton_pressed():
	get_tree().quit()


func _on_OptionsButton_pressed():
	pass # replace with function body


func _on_Level0Button_pressed():
	global.currLevelId = 0
	get_tree().change_scene("Levels/Prototype 0.tscn")
