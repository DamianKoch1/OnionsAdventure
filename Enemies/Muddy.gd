extends "res://Enemies/Enemy/Enemy.gd"

onready var muddySound = $EnemyPath/Enemy/muddySound

func _unique_process(delta):
	if $EnemyPath/Enemy/muddySound.playing == false:
		$EnemyPath/Enemy/muddySound.playRandomPitch()
	i += delta*movespeed
	if i >= 20*PI:
		i = 0
	#graph alternates between 0 and 1 every pi steps
	pathfollow.unit_offset = acos(cos(i)) / acos(cos(PI))
	#graph jumps fron 1 to -1 and back every PI steps
	$EnemyPath/Enemy/Muddy.scale.x = sin(i)/(sqrt(1-(cos(i)*cos(i))))
	enemy.global_position = pathfollow.global_position