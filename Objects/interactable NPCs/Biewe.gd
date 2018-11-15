extends Node2D


func _on_Area2D_body_entered(body):
	if body.name == "Onion":
		#make nodes in enemy group disappear/flee for t s
		pass