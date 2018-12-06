extends "res://Enemies/Enemy/Enemy.gd"
#has all functions and variables from enemy class if not overwritten

onready var diggedOut = false
var startpos
var diggedOutPos

#set startposition for digging back in
func _ready():
	startpos = global_position
	diggedOutPos = $diggedOutPos.global_position
	i = 0


#dig in/out of ground depending on boolean
func _unique_process(delta):
	if diggedOut == true && i < 1:
		i = min(i + delta, 1)
		global_position.y = lerp(global_position.y, diggedOutPos.y, i)
	elif diggedOut == false && i < 1:
		i = min(i + delta, 1)
		global_position.y = lerp(global_position.y, startpos.y, i)

	

func _on_Area2D_body_entered(body):
	if body == global.player:
		body.health -= 1
		#digDown()

func digDown():
	diggedOut = false
	i = 0

func digOut():
	diggedOut = true
	i = 0

func _on_Timer_timeout():
	if diggedOut == false:
		digOut()
	else:
		digDown()
