extends Node2D

var player

func _ready():
	player = get_parent().find_node("Onion")
	player.connect("loseHp", self, "respawn")

func respawn():
	if player.health > 0:
		player.global_transform = global_transform
		player.rotation_degrees = 0
		player.global_scale.x = 0.5
		player.global_scale.y = 0.5
