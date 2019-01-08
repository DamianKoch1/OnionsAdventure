extends Node2D

#the visible enemy object with collider etc
var enemy

#variable for moving
onready var i = 0

export (bool)var mothsound = false

export (float) var movespeed = 2
export (bool) var pathLooped = true


onready var stop = false
onready var hideTimer = 0
onready var pathfollow = $EnemyPath/PathFollow2D

func _ready():
	enemy = $EnemyPath/Enemy
	add_to_group("Enemies")
	if mothsound == true:
		$EnemyPath/Enemy/AudioStreamPlayer2D.playing = true
	
#used this because godot doesn't allow overwriting _process()
func _process(delta):
	_unique_process(delta)

func _unique_process(delta):
	#reappear when hidden by biewe
	hideTimer = max(hideTimer-delta, 0)
	if stop == true && hideTimer == 0:
		reappear()
	#move enemy if not stopped by biewe
	if stop == false:
		i += delta*movespeed
		#move from a to b and then b to a if path isnt a loop
		if pathLooped == false:
			if i >= 20*PI:
				i = 0
			pathfollow.unit_offset = acos(cos(i)) / acos(cos(PI))
		#move from a to a if on a closed path
		elif pathLooped == true:
			if i >= 20:
				i = 0
			pathfollow.unit_offset = i
		enemy.global_position = pathfollow.global_position

#called by biewe
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
	if body == global.player:
		body.health -= 1


