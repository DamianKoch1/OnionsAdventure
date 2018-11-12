extends Area2D

func _on_Goal_body_entered(body):
	if body.name == "Onion":
			loadNextLevel()

func loadNextLevel():
	var path = "Levels/Level " + str(global.currLevelId) + ".tscn"
	global.currLevelId += 1
	get_tree().change_scene(path)