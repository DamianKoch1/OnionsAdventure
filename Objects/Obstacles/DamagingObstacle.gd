extends Sprite

#make player lose 1hp if he touches this
func _on_Trigger_body_entered(body):
	if body.is_in_group("Player"):
		body.emit_signal("loseHp", body)

