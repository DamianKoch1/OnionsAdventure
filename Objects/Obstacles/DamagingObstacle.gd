extends Sprite

func _on_Trigger_body_entered(body):
	if body == global.player:
		body.health -= 1

