extends KinematicBody2D

var motion = Vector2()
var player
export var brakeSpeed = 0.04
onready var isPushed = false
export var gravity = 12

func _physics_process(delta):
	if isPushed == true:
		motion.x = player.motion.x
	else:
		motion.x = lerp(motion.x, 0, brakeSpeed)
	motion.y += gravity
	motion = move_and_slide(motion)

func _on_Area2D_body_entered(body):
	if body.name == "Onion":
		player = body
		isPushed = true

func _on_Area2D_body_exited(body):
	if body.name == "Onion":
		isPushed = false
