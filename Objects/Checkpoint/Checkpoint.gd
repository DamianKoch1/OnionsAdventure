extends Area2D


func _on_Checkpoint_body_entered(body):
	if body == global.player:
		#move spawnpoint to checkpoint position
		global.spawnpoint.global_position = global_position
		body.health = global.maxHealth
		queue_free()