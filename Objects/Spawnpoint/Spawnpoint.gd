extends Node2D

#setup player respawn at this objects position when taking damage
func _ready():
	global.spawnpoint = self
	if global.player != null:
		global.player.connect("loseHp", self, "respawn")

#reset transform of player if he still has health left
func respawn():
	if global.player.health > 0:
		$respawn.playing = true
		global.player.global_transform = global_transform
		global.player.rotation_degrees = 0
		global.player.global_scale.x = 0.5
		global.player.global_scale.y = 0.5
		$SpawnParticles.emitting = true

func playActivationSound():
	$activate.playing = true