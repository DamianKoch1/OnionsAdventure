extends Node2D

onready var pathfollow = $EnemyPath/PathFollow2D
onready var enemy = $EnemyPath/Enemy
onready var i = 0
export (float) var movespeed = 2
export (bool) var pathLooped = true
onready var damageCD = 0
onready var hidden = false
onready var hideTimer = 0

func _ready():
	add_to_group("Enemies")

func _process(delta):
	damageCD = max(damageCD-delta, 0)
	hideTimer = max(hideTimer-delta, 0)
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
	$EnemyPath/Enemy.hide()

func _on_Area2D_body_entered(body):
	if body.name == "Onion" && damageCD == 0:
		body.health -= 1
		damageCD = 1
