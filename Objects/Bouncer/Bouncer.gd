extends Area2D

export var maxBounceStr = 900

func _on_Bouncer_body_entered(body):
	if body == global.player:
		if body.motion.y > 0:
			body.bounce(min(body.motion.y+5*body.gravity, maxBounceStr))