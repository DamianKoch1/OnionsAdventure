extends Sprite

onready var spawnpoint = get_parent().find_node("Spawnpoint")
onready var damageCD = 0

func _process(delta):
	if damageCD > 0:
		damageCD = max(damageCD-delta, 0)

func _on_Trigger_body_entered(body):
	if body.name == "Onion" && damageCD == 0:
		damageCD = 1
		body.health -= 1
		print(self)
