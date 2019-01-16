extends TextureButton

export var levelId = 1

func loadLevel(id):
	SaveGame.currLevelId = id
	var path = "Levels/Level " + str(SaveGame.currLevelId) + ".tscn"
	get_tree().change_scene(path)


func _on_LevelButton_pressed():
	loadLevel(levelId)
