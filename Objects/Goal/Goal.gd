extends Area2D

func _on_Goal_body_entered(body):
	if body == global.player:
			loadNextLevel()

func loadNextLevel():
	global.currLevelId += 1
	var path = "Levels/Level " + str(global.currLevelId) + ".tscn"
	global.player = null
	get_tree().change_scene(path)