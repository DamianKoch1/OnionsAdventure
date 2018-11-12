extends Area2D

var triggered = false
onready var triggeredBody = $triggeredTrap/CollisionShape2D
onready var player = get_parent().find_node("Onion")
var triggerCD = 0

func _ready():
	triggeredBody.disabled = true
	player.connect("loseHp", self, "open")
	

func _physics_process(delta):
	triggerCD = max(triggerCD-delta, 0)

func _on_Trap_body_entered(body):
	if triggered == false && triggerCD == 0:
		if body.name != "StaticBody2D" && body.name != "TileMap":
			triggered = true
			triggeredBody.disabled = false
			$AnimationPlayer.play("Snap")
			if body.name == "Onion":
				body.health -= 1

func open():
	triggerCD = 1
	$AnimationPlayer.play("Open")
	triggeredBody.disabled = true
	triggered = false