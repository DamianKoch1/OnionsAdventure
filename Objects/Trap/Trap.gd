extends Area2D

var triggered = false
onready var triggeredBody = $triggeredTrap/CollisionShape2D

func _ready():
	triggeredBody.disabled = true

func _on_Trap_body_entered(body):
	if triggered == false:
		if body.name != "StaticBody2D":
			triggered = true
			triggeredBody.disabled = false
			$AnimationPlayer.play("Snap")
			if body.name == "Onion":
				body.health = 0
