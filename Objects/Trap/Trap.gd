extends Area2D

var triggered = false
onready var triggeredBody = $triggeredTrap/CollisionShape2D
onready var player = get_parent().find_node("Onion")

func _ready():
	triggeredBody.disabled = true
	player.connect("loseHp", self, "open")

func _on_Trap_body_entered(body):
	if triggered == false:
		if body.name != "StaticBody2D" && body.name != "TileMap":
			triggered = true
			triggeredBody.disabled = false
			$AnimationPlayer.play("Snap")
			if body.name == "Onion":
				body.health -= 1

func open():
	$AnimationPlayer.play("Open")