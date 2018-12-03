extends Area2D

#move spawnpoint to checkpoint position if player enters checkpoint
func _on_Checkpoint_body_entered(body):
	if body == global.player:
		global.spawnpoint.global_position = global_position
		body.health = global.maxHealth
		queue_free()