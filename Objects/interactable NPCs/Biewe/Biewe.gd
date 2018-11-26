extends Node2D

export var bieweCooldown = 8
export var bieweRange = 600
export var hideDuration = 3
var cd = 0
var enemies


func _physics_process(delta):
	cd = max(cd - delta, 0)

func _on_Area2D_body_entered(body):
	#call flee function in enemies in range if triggered by player while cooldown is 0
	if body == global.player && cd == 0:
		cd = bieweCooldown
		enemies = get_tree().get_nodes_in_group("Enemies")
		for i in range(0, enemies.size()):
			if enemies[i].global_position.distance_to(global_position) <= bieweRange:
				enemies[i].flee(hideDuration)