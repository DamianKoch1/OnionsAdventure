extends Sprite

onready var spawnpoint = get_parent().find_node("Spawnpoint")


func _on_Trigger_body_entered(body):
	if body.name == "Onion":
		body.health -= 1

