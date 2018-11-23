extends Area2D

func _on_Ladder_body_entered(body):
	if body == global.player:
		body.rope = self
		body.setState(body.climb)

func _on_Ladder_body_exited(body):
	if body == global.player:
		body.setState(body.fall)
