extends Node2D

onready var pathfollow = $EnemyPath/PathFollow2D
var enemy
onready var i = 0
export (float) var movespeed = 2
export (bool) var pathLooped = true
onready var stop = false
onready var colliding = false
onready var hideTimer = 0

func _ready():
	enemy = $EnemyPath/Enemy
	add_to_group("Enemies")

func _unique_process(delta):
	#stop when hitting box etc
	if $EnemyPath/Enemy/Area2D.get_overlapping_bodies().size() == 1 && colliding == true:
		colliding = false
	
	#reappear when hid by biewe
	hideTimer = max(hideTimer-delta, 0)
	if stop == true && hideTimer == 0:
		reappear()
	
	#move enemy
	if stop == false && colliding == false:
		i += delta*movespeed
		#move from a to b and then b to a if path isnt a loop
		if pathLooped == false:
			if i >= 20*PI:
				i = 0
			pathfollow.unit_offset = acos(cos(i)) / acos(cos(PI))
		#move from a to a on a path
		elif pathLooped == true:
			if i >= 20:
				i = 0
			pathfollow.unit_offset = i
		enemy.global_position = pathfollow.global_position

func _process(delta):
	_unique_process(delta)
	
func flee(duration):
	stop = true
	hideTimer = duration
	#$EnemyPath/Enemy.hide()
	$EnemyPath/Enemy/StaticBody2D/CollisionShape2D.disabled = true
	$EnemyPath/Enemy/Area2D/CollisionShape2D.disabled = true

func reappear():
	stop = false
	#$EnemyPath/Enemy.show()
	$EnemyPath/Enemy/StaticBody2D/CollisionShape2D.disabled = false
	$EnemyPath/Enemy/Area2D/CollisionShape2D.disabled = false
	
func _on_Area2D_body_entered(body):
	colliding = true
	if body.name == "Onion":
		body.health -= 1


