extends TextureButton

export var levelId = 1

func loadLevel(id):
	SaveGame.currLevelId = id
	var path = "Levels/Level " + str(SaveGame.currLevelId) + ".tscn"
	get_tree().change_scene(path)


func _on_LevelButton_pressed():
	$UISelect.playing = true
	loadLevel(levelId)


func _on_LevelButton_mouse_entered():
	grab_focus()
