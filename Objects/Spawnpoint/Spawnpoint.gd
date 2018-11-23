extends Node2D



func _ready():
	global.spawnpoint = self
	#make player respawn at own position when taking damage
	global.player.connect("loseHp", self, "respawn")

func respawn():
	if global.player.health > 0:
		global.player.global_transform = global_transform
		global.player.rotation_degrees = 0
		global.player.global_scale.x = 0.5
		global.player.global_scale.y = 0.5
