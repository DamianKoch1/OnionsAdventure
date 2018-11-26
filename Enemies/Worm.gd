extends "res://Enemies/Enemy.gd"

onready var diggedOut = false
var startpos
var diggedOutPos

#set startposition for digging back in, set up digging out if player in range
func _ready():
	startpos = global_position
	diggedOutPos = $diggedOutPos.global_position
	i = 0
	if global.player != null:
		global.player.connect("loseHp", self, "digDown")

func _unique_process(delta):
	#dig in/out of ground depending on player entering different areas
	if diggedOut == true && i < 1:
		i = min(i + delta, 1)
		global_position.y = lerp(global_position.y, diggedOutPos.y, i)
	elif diggedOut == false && i < 1:
		i = min(i + delta, 1)
		global_position.y = lerp(global_position.y, startpos.y, i)

func _on_Area2D_body_entered(body):
	if body == global.player:
		body.health -= 1
		digDown()

func _on_detectRange_body_entered(body):
	if body == global.player && diggedOut == false:
		diggedOut = true
		i = 0

func _on_visionRange_body_entered(body):
	if body == global.player && diggedOut == true:
		digDown()

func digDown():
	diggedOut = false
	i = 0