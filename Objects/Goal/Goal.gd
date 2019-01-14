extends Area2D

func _on_Goal_body_entered(body):
	if body.is_in_group("Player"):
			loadNextLevel()

func loadNextLevel():
	global.currLevelId += 1
	var path = "Levels/Level " + str(global.currLevelId) + ".tscn"
	get_tree().change_scene(path)