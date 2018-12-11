extends Node2D
#has all functions and variables from enemy class if not overwritten

onready var diggedOut = false
onready var anim = $AnimationPlayer

func _on_Area2D_body_entered(body):
	if body == global.player:
		body.health -= 1



func digDown():
	diggedOut = false
	anim.play_backwards("digOut")

func digOut():
	diggedOut = true
	anim.play("digOut")

func _on_Timer_timeout():
	if diggedOut == false:
		digOut()
	else:
		digDown()
