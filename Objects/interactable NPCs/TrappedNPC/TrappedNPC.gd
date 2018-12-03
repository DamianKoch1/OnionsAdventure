extends Node2D

#delete self and increase counter if player presses button in area
func _on_Area2D_body_entered(body):
	if body == global.player:
		if Input.is_action_just_pressed("push"):
			global.player.NPCsavedCount += 1
			global.player.emit_signal("NPCsaved")
			queue_free()
