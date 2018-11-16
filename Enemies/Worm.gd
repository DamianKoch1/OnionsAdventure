extends "res://Enemies/Enemy.gd"

onready var diggedOut = false
var startpos
var diggedOutPos

func _ready():
	startpos = global_position
	diggedOutPos = $diggedOutPos.global_position
	i = 0

func _unique_process(delta):
	if diggedOut == true && i < 1:
		i = min(i + delta, 1)
		global_position.y = lerp(global_position.y, diggedOutPos.y, i)
	elif diggedOut == false && i < 1:
		i = min(i + delta, 1)
		global_position.y = lerp(global_position.y, startpos.y, i)



func _on_Area2D_body_entered(body):
	if body.name == "Onion":
		body.health -= 1


func _on_detectRange_body_entered(body):
	if body.name == "Onion" && diggedOut == false:
		diggedOut = true
		i = 0


func _on_visionRange_body_entered(body):
	if body.name == "Onion" && diggedOut == true:
		diggedOut = false
		i = 0
