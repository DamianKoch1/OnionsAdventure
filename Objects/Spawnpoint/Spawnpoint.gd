extends Node2D


func _ready():
	SaveGame.spawnpoint = self
	for p in get_tree().get_nodes_in_group("Player"):
		p.connect("loseHp", self, "respawn")


func respawn(player):
	$respawn.playing = true
	player.global_transform = global_transform
	$SpawnParticles.emitting = true

func playActivationSound():
	$activate.playing = true