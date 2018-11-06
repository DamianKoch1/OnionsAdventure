extends Node2D

export var swingDegrees = 30
export var swingSpeed = 0.03
onready var swingAmount = 0

func _physics_process(delta):
	swingAmount += swingSpeed
	if swingAmount >= 20*PI:
		swingAmount = 0
	rotation_degrees = swingDegrees*sin(swingAmount)

func _on_Area2D_body_entered(body):
	if body.name == "Onion":
		body.state = body.climb
		body.rope = self


func _on_Area2D_body_exited(body):
	if body.name == "Onion":
		body.state = body.jump
		body.bounce(abs(rotation_degrees)*20)

