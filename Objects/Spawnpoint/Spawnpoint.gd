extends Node2D


var player

func _ready():
	#respawn()
	player = get_parent().find_node("Onion")
	player.connect("loseHp", self, "respawn")


func respawn():
	
	player.global_transform = global_transform
