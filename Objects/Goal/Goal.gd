extends Area2D

var worldPath = ""

func _on_Goal_body_entered(body):
	if body.name == "Onion":
			loadNextWorld(worldPath)

func loadNextWorld(worldPath):
	global.nextWorldId += 1
	worldPath = "Worlds/World" + str(global.nextWorldId) + ".tscn"
	get_tree().change_scene(worldPath)