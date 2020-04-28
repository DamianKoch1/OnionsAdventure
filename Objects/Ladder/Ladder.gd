extends Area2D

onready var playerAttached = false

var player

#player can jump off if attached
func _physics_process(delta):
	if !playerAttached:
		return
	if Input.is_action_just_pressed("jump"):
		player.jump(player.jumpheight)
		player.attachCD = 0.3
		playerAttached = false
		player = null

#give player ladder to attach to and make him climb on contact
func _on_Ladder_body_entered(body):
	if !body.is_in_group("Player"):
		return
	if body.attachCD > 0:
		return
	body.rope = self
	body.state = body.climb
	playerAttached = true
	player = body

#detach player if he exits body
func _on_Ladder_body_exited(body):
	if !body.is_in_group("Player"):
		return
	body.state = body.jump
	playerAttached = false
	player = null
