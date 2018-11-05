extends KinematicBody2D

var motion = Vector2()
var player
export var brakeSpeed = 0.08
onready var isPushed = false
export var gravity = 12

func _physics_process(delta):
	if isPushed == true:
		motion.x = player.motion.x
		if abs(player.motion.y) >= 20 || abs(motion.y) >= 20:
			isPushed = false
	else:
		motion.x = lerp(motion.x, 0, brakeSpeed)
	motion.y += gravity
	motion = move_and_slide(motion)

func _on_Area2D_body_entered(body):
	if body.name == "Onion":
		player = body
		if Input.is_action_just_pressed("push"):
			if isPushed == true:
				isPushed = false
			elif isPushed == false:
				isPushed = true
				global_position.x = global_position.x + (global_position.x - player.global_position.x)/4.2