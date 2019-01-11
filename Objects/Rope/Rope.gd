extends Node2D

export var swingDegrees = 30
export var swingSpeed = 0.03
onready var swingAmount = 0
onready var playerAttached = false
var attachCD = 0

func _physics_process(delta):
	attachCD = max(attachCD - delta, 0)
	#pendulum rotation
	swingAmount += swingSpeed
	if swingAmount >= 20*PI:
		swingAmount = 0
	rotation_degrees = swingDegrees*sin(swingAmount)
	if abs(rotation_degrees) <= 3 && $ropeSwing.playing == false:
		$ropeSwing.playRandomPitch()
	if Input.is_action_just_pressed("jump") && playerAttached == true:
		global.player.state = global.player.jump
		global.player.bounce(min(abs(rotation_degrees)*660*swingSpeed, 600))
		attachCD = 1
		playerAttached = false
	

#give player ladder to attach to and make him climb on contact
func _on_Area2D_body_entered(body):
	if body == global.player && attachCD == 0:
		body.state = body.climb
		body.rope = self
		playerAttached = true

#bounce when player leaves rope
func _on_Area2D_body_exited(body):
	if body == global.player:
		body.state = body.jump
		playerAttached = false
