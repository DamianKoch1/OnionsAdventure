extends Node2D

var player

func _ready():
	player = get_parent().find_node("Onion")
	player.connect("loseHp", self, "respawn")

func respawn():
	if player.health > 0:
		player.global_transform = global_transform
