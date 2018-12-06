extends Area2D

func _ready():
	add_to_group("Checkpoints")

#move spawnpoint to checkpoint position if player enters checkpoint
func _on_Checkpoint_body_entered(body):
	if body == global.player:
		global.spawnpoint.global_position = global_position
		if global.diff == global.hard:
			body.setHealth(body.hardHealth)
		else:
			body.setHealth(body.normalHealth)
		SaveGame.latestCheckpoint = self
		SaveGame.saveGame()
		queue_free()