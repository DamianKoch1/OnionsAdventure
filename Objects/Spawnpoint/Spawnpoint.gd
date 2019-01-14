extends Node2D

#setup player respawn at this objects position when taking damage
func _ready():
	for p in get_tree().get_nodes_in_group("Player"):
		p.connect("loseHp", self, "respawn")


#reset transform of player if he still has health left
func respawn(player):
	$respawn.playing = true
	player.global_transform = global_transform
	player.rotation_degrees = 0
	player.global_scale.x = 0.5
	player.global_scale.y = 0.5
	$SpawnParticles.emitting = true

func playActivationSound():
	$activate.playing = true