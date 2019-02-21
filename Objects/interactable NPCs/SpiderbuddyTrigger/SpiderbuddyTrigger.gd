extends Node2D

#text that spiderbuddy will "say" for this trigger
export var text = "insert text"

export var spiderCooldown = 15
export var spiderDelay = 0
onready var timer = $Timer

export var waitForKey = false
export var key = ""
export var keyWaitTime = 5

onready var cd = 0

signal triggered
signal exited

var player

func _process(delta):
	cd = max(cd-delta, 0)
	#on body exit triggers each frame due to onion changing parents
	if player != null:
		checkForPlayer()
	if waitForKey == true && Input.is_action_just_pressed(key):
		timer.stop()
		

func _on_Area2D_body_entered(body):
	if body.is_in_group("Player") && cd == 0:
		player = body
		cd = spiderCooldown
		if waitForKey == false:
			timer.wait_time = spiderDelay
		else:
			timer.wait_time = keyWaitTime
		timer.start()

#stops timer if no player is in area
func checkForPlayer():
	for body in $Area2D.get_overlapping_bodies():
		if body.is_in_group("Player"):
			return
	player = null
	timer.stop()


func _on_Timer_timeout():
	emit_signal("triggered", text, spiderDelay)
	timer.stop()
	
