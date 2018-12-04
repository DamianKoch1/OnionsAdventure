extends "res://Enemies/Enemy/Enemy.gd"
#has all functions and variables from enemy class if not overwritten

var startpos
onready var following = false

export var speed = 2
export var loseAggroDistance = 550
var motion = Vector2()
export var gravity = 12


func _ready():
	enemy = $Enemy
	startpos = enemy.global_position
	add_to_group("Enemies")

func _unique_process(delta):
	hideTimer = max(hideTimer-delta, 0)
	if stop == true && hideTimer == 0:
		reappear()
	if stop == false:
		motion.y += gravity
		#unfollow player if too far away
		if following == true:
			motion.x = (global.player.global_position.x - $Enemy.global_position.x)*speed
			if startpos.distance_to(global.player.global_position) > loseAggroDistance:
				following = false
		#move to original position
		else:
			motion.x = startpos.x - $Enemy.global_position.x
		motion = enemy.move_and_slide(motion)

func flee(duration):
	stop = true
	hideTimer = duration
	#$Enemy/Sprites.hide()
	$Enemy/CollisionShape2D.disabled = true
	$Enemy/Area2D/CollisionShape2D.disabled = true
	$VisionRange/CollisionShape2D.disabled = true

func reappear():
	stop = false
	#$Enemy/Sprites.show()
	$Enemy/CollisionShape2D.disabled = false
	$Enemy/Area2D/CollisionShape2D.disabled = false
	$VisionRange/CollisionShape2D.disabled = false
	
func _on_Area2D_body_entered(body):
	if body == global.player:
		body.health -= 1

#follow player if he enters area
func _on_VisionRange_body_entered(body):
	if body == global.player:
		if following == false:
			following = true