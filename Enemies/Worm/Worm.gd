extends Node2D


onready var diggedOut = false
onready var anim = $AnimationPlayer

func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		body.emit_signal("loseHp", body)



func digDown():
	diggedOut = false
	anim.play_backwards("digOut")

func digOut():
	diggedOut = true
	anim.play("digOut")

#play correct animation each time the timer runs out
func _on_Timer_timeout():
	if diggedOut == false:
		digOut()
	else:
		digDown()
