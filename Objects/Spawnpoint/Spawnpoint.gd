extends Node2D

var foundPlayer = false

#setup player respawn at this objects position when taking damage
func _ready():
	global.spawnpoint = self
	if global.player != null:
		foundPlayer = true
		global.player.connect("loseHp", self, "respawn")

func _physics_process(delta):
	if foundPlayer == false:
		_ready()

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