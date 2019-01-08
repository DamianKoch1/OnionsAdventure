extends Area2D

func _ready():
	add_to_group("Checkpoints")

#move spawnpoint to checkpoint position if player enters checkpoint
func _on_Checkpoint_body_entered(body):
	if body == global.player:
		global.spawnpoint.global_position = global_position
		global.spawnpoint.playActivationSound()
		if global.diff == global.hard:
			body.health = body.hardHealth
		else:
			body.health = body.normalHealth
		SaveGame.latestCheckpoint = self
		SaveGame.saveGame()
		queue_free()