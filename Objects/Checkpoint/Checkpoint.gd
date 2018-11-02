extends Area2D

onready var spawnpoint = get_parent().find_node("Spawnpoint")

func _on_Checkpoint_body_entered(body):
	if body.name == "Onion":
		spawnpoint.global_position = global_position
		queue_free()