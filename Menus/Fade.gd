extends Panel

signal finished

func fadeIn(speed=1):
	show()
	$AnimationPlayer.play("fadeIn", -1, speed)
	
func fadeOut(speed=1):
	speed *= (-1)
	$AnimationPlayer.play("fadeIn", -1, speed, true)

func _on_AnimationPlayer_animation_finished(anim_name):
	emit_signal("finished")

func oneshot(target, function, speed=1):
	connect("finished", target, function, [], 4)
	fadeOut(speed)