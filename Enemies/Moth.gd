extends "res://Enemies/Enemy/Enemy.gd"


func _unique_process(delta):
	i += delta*movespeed
	if i >= 1:
		i = 0
	pathfollow.unit_offset = i
	if pathfollow.unit_offset <= 0.5:
		$EnemyPath/Enemy/Bitchy.scale.x = -1
	else:
		$EnemyPath/Enemy/Bitchy.scale.x = 1
	enemy.global_position = pathfollow.global_position
	