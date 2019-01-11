extends Area2D

export var maxBounceStr = 900
export var bounceIncrease = 5

onready var anim = $AnimationPlayer

#make player bounce depending on current down motion, caps at maxBounceStrength
func _on_Bouncer_body_entered(body):
	if body.is_in_group("Player"):
		if body.motion.y > 0:
			body.bounce(min(body.motion.y+bounceIncrease*body.gravity, maxBounceStr))
			anim.play("bounce")
			$bounceSound.playRandomPitch()