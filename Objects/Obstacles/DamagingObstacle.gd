extends Sprite


func _on_Trigger_body_entered(body):
	if !body.is_in_group("Player"):
		return
	body.loseHp()

