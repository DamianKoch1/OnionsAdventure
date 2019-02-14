extends Node2D

#text that spiderbuddy will "say" for this trigger
export var text = "insert text"
export var spiderCooldown = 15
export var spiderDelay = 0
onready var timer = $Timer

onready var cd = 0

signal triggered
signal exited

var player

func _process(delta):
	cd = max(cd-delta, 0)
	#on body exit triggers each frame due to onion changing parents
	if player != null:
		checkForPlayer()

func _on_Area2D_body_entered(body):
	if body.is_in_group("Player") && cd == 0:
		player = body
		cd = spiderCooldown
		timer.wait_time = spiderDelay
		timer.start()


func checkForPlayer():
	for body in $Area2D.get_overlapping_bodies():
		if body.is_in_group("Player"):
			return
	player = null
	timer.stop()


func _on_Timer_timeout():
	emit_signal("triggered", text, spiderDelay)
	timer.stop()
	
