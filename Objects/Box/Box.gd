extends KinematicBody2D

var motion = Vector2()
onready var player = get_parent().find_node("Onion")
onready var worldNode = player.get_parent()
export var brakeSpeed = 0.04


func _physics_process(delta):
	if player != null:
		print(str(global_position.y)+"a")
		print(player.global_position.y)
		motion.y += player.gravity /1.3
		motion = move_and_slide(motion)
		if abs(global_position.x - player.global_position.x) < 65 && player.is_on_floor():
			motion.x = player.motion.x
		else:
			motion.x = lerp(motion.x, 0, brakeSpeed)

