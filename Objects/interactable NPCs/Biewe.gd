extends Node2D

export var bieweCooldown = 8
export var bieweRange = 600
export var hideDuration = 3
var cd = 0
var enemies

func _ready():
	enemies = get_tree().get_nodes_in_group("Enemies")

func _physics_process(delta):
	cd = max(cd - delta, 0)

func _on_Area2D_body_entered(body):
	if body.name == "Onion" && cd == 0:
		cd = bieweCooldown
		for i in range(0, enemies.size()):
			if enemies[i].global_position.distance_to(global_position) <= bieweRange:
				enemies[i].flee(hideDuration)
				