extends Area2D

var spawnpoint

func _ready():
	#find the spawnpoint node, works if spawnpoint is child of 1st or 2nd parent of self
	if spawnpoint == null:
		spawnpoint = get_parent().find_node("Spawnpoint")
		if spawnpoint == null:
			spawnpoint = get_parent().get_parent().find_node("Spawnpoint")

func _on_Checkpoint_body_entered(body):
	if body.name == "Onion":
		#move spawnpoint to checkpoint position
		spawnpoint.global_position = global_position
		body.health = global.maxHealth
		queue_free()