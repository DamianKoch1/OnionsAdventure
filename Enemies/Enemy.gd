extends Node2D

onready var pathfollow = $EnemyPath/PathFollow2D
onready var enemy = $EnemyPath/Enemy
onready var i = 0
export (float) var movespeed = 2
export (bool) var pathLooped = true
onready var hidden = false
onready var hideTimer = 0

func _ready():
	add_to_group("Enemies")

func _process(delta):
	hideTimer = max(hideTimer-delta, 0)
	if hidden == true && hideTimer == 0:
		reappear()
	if hidden == false:
		i += delta*movespeed
		if pathLooped == false:
			if i >= 20*PI:
				i = 0
			pathfollow.unit_offset = acos(cos(i)) / acos(cos(PI))
		elif pathLooped == true:
			if i >= 20:
				i = 0
			pathfollow.unit_offset = i
		enemy.global_position = pathfollow.global_position

func flee(duration):
	hidden = true
	hideTimer = duration
	#$EnemyPath/Enemy.hide()
	$EnemyPath/Enemy/StaticBody2D/CollisionShape2D.disabled = true
	$EnemyPath/Enemy/Area2D/CollisionShape2D.disabled = true

func reappear():
	hidden = false
	#$EnemyPath/Enemy.show()
	$EnemyPath/Enemy/StaticBody2D/CollisionShape2D.disabled = false
	$EnemyPath/Enemy/Area2D/CollisionShape2D.disabled = false
	
func _on_Area2D_body_entered(body):
	if body.name == "Onion":
		body.health -= 1
