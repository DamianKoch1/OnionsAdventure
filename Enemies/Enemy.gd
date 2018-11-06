extends Path2D

onready var pathfollow = $PathFollow2D
onready var i = 0

func _process(delta):
	i += delta*2
	if i >= 20*PI:
		i = 0
	pathfollow.unit_offset = acos(cos(i)) / acos(cos(PI))

func _on_Area2D_body_entered(body):
	if body.name == "player":
		body.health -= 1
