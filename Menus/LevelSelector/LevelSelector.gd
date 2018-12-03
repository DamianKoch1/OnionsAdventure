extends Container


func _on_MainMenuButton_pressed():
	#hardcoded path because godot crashes when 2 scenes reference each other via exported packed scenes...
	get_tree().change_scene("Menus/MainMenu/MainMenu.tscn")


func _on_QuitButton_pressed():
	get_tree().quit()


func _on_OptionsButton_pressed():
	pass # replace with function body


func _on_Level0Button_pressed():
	global.currLevelId = 0
	get_tree().change_scene("Levels/Prototype 0.tscn")
