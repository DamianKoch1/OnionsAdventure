extends Sprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
onready var spawnpoint = get_parent().find_node("Spawnpoint")
var damageCD = 0
	

func _process(delta):
	if damageCD > 0:
		damageCD = max(damageCD-delta, 0)

func _on_Area2D_body_entered(body):
	if body.name == "Onion":
		if damageCD == 0:
			damageCD = 1
			body.health = max(body.health-1, 0)
			print(body.health)
			
