extends Area2D

var triggered = false
onready var snappedBody = $triggeredTrap/CollisionShape2D
onready var player = get_parent().find_node("Onion")
var triggerCD = 0
onready var boxPacked = preload("res://Objects/Box/Box.tscn")
var triggerStartpos




func _ready():
	snappedBody.disabled = true
	player.connect("loseHp", self, "open")
	

func _physics_process(delta):
	triggerCD = max(triggerCD-delta, 0)

func _on_Trap_body_entered(body):
	if triggered == false && triggerCD == 0:
		if body.name != "StaticBody2D" && body.name != "TileMap":
			if body.name == "Onion":
				body.health -= 1
			else:
				if body.get_filename() == boxPacked.get_path():
					triggerStartpos = body.startpos
				body.get_parent().remove_child(body)
				triggered = true
				snappedBody.disabled = false
				$AnimationPlayer.play("Snap")
			

func open():
	triggerCD = 1
	if triggerStartpos != null:
		var box = boxPacked.instance()
		box.position = triggerStartpos
		triggerStartpos = null
	$AnimationPlayer.play("Open")
	snappedBody.disabled = true
	triggered = false