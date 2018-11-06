extends Node2D

var player
var startpos
onready var damageCD = 0
onready var following = false
onready var enemy = $Enemy
export var speed = 2
export var loseAggroDistance = 550
var motion = Vector2()
export var gravity = 12

func _ready():
	startpos = enemy.global_position

func _process(delta):
	if damageCD != 0:
		damageCD = max(damageCD - delta, 0)
	motion.y += gravity
	if following == true:
		motion.x = (player.global_position.x - $Enemy.global_position.x)*speed
		if startpos.distance_to(player.global_position) > loseAggroDistance:
			following = false
	else:
		motion.x = startpos.x - $Enemy.global_position.x
	motion = $Enemy.move_and_slide(motion)
func _on_Area2D_body_entered(body):
	if body.name == "Onion" && damageCD == 0:
		body.health -= 1
		damageCD = 1


func _on_VisionRange_body_entered(body):
	if body.name == "Onion":
		player = body
		if following == false:
			following = true