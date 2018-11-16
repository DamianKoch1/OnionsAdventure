extends Area2D

onready var spawnpoint = get_parent().find_node("Spawnpoint")

func _on_Checkpoint_body_entered(body):
	if body.name == "Onion":
		#move spawnpoint to checkpoint position
		spawnpoint.global_position = global_position
		body.health = global.maxHealth
		queue_free()