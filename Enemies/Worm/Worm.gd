extends Node2D


export var diggedOut = false
onready var anim = $AnimationPlayer

#dig in or out at start depending on diggedOut
func _ready():
	_on_Timer_timeout()

func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		body.loseHp()

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


func _on_AnimationPlayer_animation_finished(anim_name):
	if diggedOut:
		if anim_name == "digOut":
			anim.play("idle")
