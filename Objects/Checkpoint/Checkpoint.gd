extends Area2D

var spawnpoint

func _ready():
	add_to_group("Checkpoints")
	spawnpoint = get_tree().get_nodes_in_group("Spawnpoint").front()

#move spawnpoint to checkpoint position if player enters checkpoint
func _on_Checkpoint_body_entered(body):
	if body.is_in_group("Player"):
		spawnpoint.global_position = global_position
		spawnpoint.playActivationSound()
		SaveGame.saveGame()
		queue_free()