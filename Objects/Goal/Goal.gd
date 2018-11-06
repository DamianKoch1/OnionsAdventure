extends Area2D

func _on_Goal_body_entered(body):
	if body.name == "Onion":
			loadNextLevel()

func loadNextLevel():
	global.nextLevelId += 1
	var path = "Levels/Level " + str(global.nextLevelId) + ".tscn"
	get_tree().change_scene(path)