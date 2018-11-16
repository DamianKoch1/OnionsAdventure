extends Node2D

var player
var startpos
onready var following = false
onready var enemy = $Enemy
export var speed = 2
export var loseAggroDistance = 550
var motion = Vector2()
export var gravity = 12
onready var stop = false
onready var hideTimer = 0

func _ready():
	startpos = enemy.global_position
	add_to_group("Enemies")

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
	
func _process(delta):
	hideTimer = max(hideTimer-delta, 0)
	if stop == true && hideTimer == 0:
		reappear()
	if stop == false:
		motion.y += gravity
		if following == true:
			motion.x = (player.global_position.x - $Enemy.global_position.x)*speed
			if startpos.distance_to(player.global_position) > loseAggroDistance:
				following = false
		else:
			motion.x = startpos.x - $Enemy.global_position.x
		motion = $Enemy.move_and_slide(motion)
		
func _on_Area2D_body_entered(body):
	if body.name == "Onion":
		body.health -= 1


func _on_VisionRange_body_entered(body):
	if body.name == "Onion":
		player = body
		if following == false:
			following = true