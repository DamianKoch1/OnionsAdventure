extends Container


func _on_MainMenuButton_pressed():
	#hardcoded path because godot crashes when 2 scenes reference each other via exported packed scenes...
	get_tree().change_scene("Menus/MainMenu/MainMenu.tscn")