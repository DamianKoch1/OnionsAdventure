extends Node2D

export var swingDegrees = 30
export var swingSpeed = 0.03
onready var swingAmount = 0


func _physics_process(delta):
	#pendulum rotation
	swingAmount += swingSpeed
	if swingAmount >= 20*PI:
		swingAmount = 0
	rotation_degrees = swingDegrees*sin(swingAmount)

func _on_Area2D_body_entered(body):
	if body == global.player:
		body.setState(body.climb)
		body.rope = self

func _on_Area2D_body_exited(body):
	if body == global.player:
		global.player.setState(global.player.jump)
		#bounce when player leaves rope
		global.player.bounce(min(abs(rotation_degrees)*660*swingSpeed, 600))