extends Area2D

onready var playerAttached = false
var attachCD = 0

var player

func _physics_process(delta):
	attachCD = max(attachCD - delta, 0)
	if Input.is_action_just_pressed("jump") && playerAttached == true:
		player.state = player.jump
		player.bounce(player.jumpheight)
		attachCD = 1
		playerAttached = false
		player = null

#give player ladder to attach to and make him climb on contact
func _on_Ladder_body_entered(body):
	if body.is_in_group("Player") && attachCD == 0:
		body.rope = self
		body.state = body.climb
		playerAttached = true
		player = body

func _on_Ladder_body_exited(body):
	if body.is_in_group("Player"):
		body.state = body.jump
		playerAttached = false
		player = null
