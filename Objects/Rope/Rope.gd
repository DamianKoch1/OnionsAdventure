extends Node2D

#max degrees the rope will swing to
export var swingDegrees = 30

export var swingSpeed = 0.03
onready var swingAmount = 0
onready var playerAttached = false

#short reattach delay if player jumps off
var attachCD = 0

var player

export var mirrorSwing = false

func _physics_process(delta):
	attachCD = max(attachCD - delta, 0)
	#pendulum rotation
	swingAmount += swingSpeed
	if swingAmount >= 20*PI:
		swingAmount = 0
	if mirrorSwing != true:
		rotation_degrees = swingDegrees*sin(swingAmount)
	else:
		rotation_degrees = -swingDegrees*sin(swingAmount)
	if abs(rotation_degrees) <= 3 && $ropeSwing.playing == false:
		$ropeSwing.playRandomPitch()
	#player can jump off, bounce gets stronger depending on current rotation degrees
	if Input.is_action_just_pressed("jump") && playerAttached == true:
		player.jump(min(abs(rotation_degrees)*660*swingSpeed, 600))
		attachCD = 1
		playerAttached = false
		player = null
	

#give player ladder to attach to and make him climb on contact
func _on_Area2D_body_entered(body):
	if attachCD > 0:
		return
	if !body.is_in_group("Player"):
		return
	body.state = body.climb
	body.rope = self
	playerAttached = true
	player = body

#detach player when exiting body
func _on_Area2D_body_exited(body):
	if !body.is_in_group("Player"):
		return
	body.state = body.jump
	playerAttached = false
	player = null
