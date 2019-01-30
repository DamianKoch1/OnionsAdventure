extends Node2D

#the visible enemy object with collider etc
onready var enemy = $EnemyPath/Enemy

#variable for moving
onready var i = 0

export (float) var movespeed = 2

onready var pathfollow = $EnemyPath/PathFollow2D

	
#used this because godot doesn't allow overwriting _process()
func _physics_process(delta):
	_unique_process(delta)

func _unique_process(delta):
	pass

func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		body.loseHp()


