extends Node2D

onready var platform = $TileMap
onready var pos1 = $State1.global_position
onready var pos2 = $State2.global_position

export (float) var platformSpeed = 2

var moveDistance = 0
var offset = 0


func _physics_process(delta):
	global_position.x = lerp(pos1.x, pos2.x, offset)
	global_position.y = lerp(pos1.y, pos2.y, offset)
	moveDistance += delta
	#move between points using a zig zag function that alternates between 0 and 1
	offset = acos(cos(moveDistance*platformSpeed)) / acos(cos(PI))