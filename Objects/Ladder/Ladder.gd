extends Area2D

onready var playerAttached = false
var attachCD = 0

func _physics_process(delta):
	attachCD = max(attachCD - delta, 0)
	if Input.is_action_just_pressed("jump") && playerAttached == true:
		global.player.state = global.player.jump
		global.player.bounce(global.player.jumpheight)
		attachCD = 1
		playerAttached = false

#give player ladder to attach to and make him climb on contact
func _on_Ladder_body_entered(body):
	if body == global.player && attachCD == 0:
		body.rope = self
		body.state = body.climb
		playerAttached = true

func _on_Ladder_body_exited(body):
	if body == global.player:
		body.state = body.jump
		playerAttached = false
