extends Area2D


func _on_Ladder_body_entered(body):
	if body.name == "Onion":
		body.setState(body.climb)


func _on_Ladder_body_exited(body):
	if body.name == "Onion":
		body.setState(body.fall)
