extends "res://Enemies/Enemy/Enemy.gd"

onready var muddySound = $EnemyPath/Enemy/muddySound

func _unique_process(delta):
	if $EnemyPath/Enemy/footsteps.playing == false:
		$EnemyPath/Enemy/footsteps.playRandomPitch()
	i += delta*movespeed
	if i >= 20*PI:
		i = 0
	#graph alternates between 0 and 1 every pi steps
	pathfollow.unit_offset = acos(cos(i)) / acos(cos(PI))
	#preventing division by 0
	if sqrt(1-(cos(i)*cos(i))) != 0:
		#flip body using graph that jumps from 1 to -1 and back every pi steps
		$EnemyPath/Enemy/Muddy.scale.x = sin(i)/(sqrt(1-(cos(i)*cos(i))))
	enemy.global_position = pathfollow.global_position