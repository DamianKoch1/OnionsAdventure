extends Node2D



func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		body.dandelions += 1
		queue_free()
