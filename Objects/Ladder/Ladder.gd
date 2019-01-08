extends Area2D

#give player ladder to attach to and make him climb on contact
func _on_Ladder_body_entered(body):
	if body == global.player:
		body.rope = self
		body.state = body.climb

func _on_Ladder_body_exited(body):
	if body == global.player:
		body.state = body.fall
