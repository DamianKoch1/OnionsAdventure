extends "res://Enemies/Enemy.gd"

func flee(duration):
	stop = true
	hideTimer = duration
	#$EnemyPath/Enemy.hide()
	$EnemyPath/Enemy/Area2D/CollisionShape2D.disabled = true

func reappear():
	stop = false
	#$EnemyPath/Enemy.show()
	$EnemyPath/Enemy/Area2D/CollisionShape2D.disabled = false
