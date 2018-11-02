extends Area2D

var triggered = false

func _on_Trap_body_entered(body):
	if triggered == false:
		if body.name != "StaticBody2D":
			triggered = true
			$AnimationPlayer.play("Snap")
			if body.name == "Onion":
				body.health = 0
