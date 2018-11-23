extends Area2D

var triggered = false
onready var snappedBody = $triggeredTrap/CollisionShape2D
var triggerCD = 0
onready var boxPacked = preload("res://Objects/Box/Box.tscn")

var obj

func snap():
	#hurt player or remove box that triggered trap, called by snap animation
	if obj != null:
		snappedBody.disabled = false
		if obj == global.player:
			obj.health -= 1
		else:
			if obj.get_filename() == boxPacked.get_path():
				obj.get_parent().remove_child(obj)


func _ready():
	global.player.connect("loseHp", self, "open")
	#disable body of triggered trap
	snappedBody.disabled = true
	
	

func _physics_process(delta):
	triggerCD = max(triggerCD-delta, 0)

func _on_Trap_body_entered(body):
	#make trap snap if triggered
	if triggered == false && triggerCD == 0:
		if body.name != "StaticBody2D" && body.name != "TileMap":
			triggerCD = 1
			triggered = true
			obj = body
			$AnimationPlayer.play("Snap")


func open():
	#open trap on player respawn
	triggerCD = 1
	if obj != null:
		if obj.get_filename() == boxPacked.get_path() && global.player.health >= 1:
			var box = boxPacked.instance()
			get_tree().get_root().add_child(box)
			box.global_position = obj.startpos
			box.getpos()
	$AnimationPlayer.play("Open")
	snappedBody.disabled = true
	triggered = false