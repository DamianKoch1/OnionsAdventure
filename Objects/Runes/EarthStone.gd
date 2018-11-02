extends Node2D

onready var platform = $TileMap
onready var pos1 = $State1.global_position
onready var pos2 = $State2.global_position

export var platformSpeed = 0.01

var moveDistance = 0
var player
var worldNode

enum {movingTo1, movingTo2, idle}
onready var state = idle

func _physics_process(delta):
	if state == movingTo1:
		moveDistance += platformSpeed
		platform.global_position.x = lerp(pos2.x, pos1.x, moveDistance)
		platform.global_position.y = lerp(pos2.y, pos1.y, moveDistance)
	elif state == movingTo2:
		moveDistance += platformSpeed
		platform.global_position.x = lerp(pos1.x, pos2.x, moveDistance)
		platform.global_position.y = lerp(pos1.y, pos2.y, moveDistance)
	if moveDistance >= 1:
		state = idle
		moveDistance = 0

func _on_EarthStoneTrigger_body_entered(body):
	if body.name == "Onion" && player == null:
		player = body
		worldNode = player.get_parent()
	if body == player && state == idle && player.motion.y > player.gravity*15:
		if platform.global_position == pos1:
			state = movingTo2
			moveDistance = 0
		elif platform.global_position == pos2:
			state = movingTo1
			moveDistance = 0