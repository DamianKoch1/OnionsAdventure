extends Area2D

var triggered = false
onready var snappedBody = $triggeredTrap/CollisionShape2D
onready var player = get_parent().find_node("Onion")
var triggerCD = 0
onready var boxPacked = preload("res://Objects/Box/Box.tscn")

var obj

func snap():
	if obj != null:
		snappedBody.disabled = false
		if obj.name == "Onion":
			obj.health -= 1
		else:
			if obj.get_filename() == boxPacked.get_path():
				obj.get_parent().remove_child(obj)


func _ready():
	snappedBody.disabled = true
	player.connect("loseHp", self, "open")
	

func _physics_process(delta):
	triggerCD = max(triggerCD-delta, 0)

func _on_Trap_body_entered(body):
	if triggered == false && triggerCD == 0:
		if body.name != "StaticBody2D" && body.name != "TileMap":
			triggerCD = 1
			triggered = true
			obj = body
			$AnimationPlayer.play("Snap")


func open():
	triggerCD = 1
	if obj != null:
		if obj.get_filename() == boxPacked.get_path() && player.health >= 1:
			var box = boxPacked.instance()
			get_tree().get_root().add_child(box)
			box.global_position = obj.startpos
			box.getpos()
	$AnimationPlayer.play("Open")
	snappedBody.disabled = true
	triggered = false