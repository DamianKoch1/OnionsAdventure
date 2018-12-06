extends Sprite

#make player lose 1hp if he touches this
func _on_Trigger_body_entered(body):
	if body == global.player:
		body.health -= 1

