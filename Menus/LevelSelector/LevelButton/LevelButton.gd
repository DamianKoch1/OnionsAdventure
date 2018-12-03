extends Button

export var levelId = 1

func loadLevel(id):
	global.currLevelId = id
	var path = "Levels/Level " + str(global.currLevelId) + ".tscn"
	get_tree().change_scene(path)


func _on_LevelButton_pressed():
	loadLevel(levelId)
