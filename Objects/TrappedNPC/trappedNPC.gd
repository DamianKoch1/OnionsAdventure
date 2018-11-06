extends Node2D

var player

func _on_Area2D_body_entered(body):
	if body.name == "Onion":
		player = body
		if Input.is_action_just_pressed("push"):
			player.NPCsavedCount += 1
			player.emit_signal("NPCsaved")
			queue_free()
