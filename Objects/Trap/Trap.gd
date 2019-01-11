extends Area2D

#removed feature


var triggered = false
onready var snappedBody = $triggeredTrap/CollisionShape2D
var triggerCD = 0
onready var boxPacked = preload("res://Objects/Box/Box.tscn")

var obj

#setup trap reset on player respawn, disable triggered trap body
func _ready():
	if get_tree().get_nodes_in_group("Player").size() > 0:
		get_tree().get_nodes_in_group("Player").front().connect("loseHp", self, "open")
	snappedBody.disabled = true

func _physics_process(delta):
	triggerCD = max(triggerCD-delta, 0)

#hurt player or remove box that triggered trap, called by snap animation
func snap():
	if obj != null:
		snappedBody.disabled = false
		if obj.is_in_group("Player"):
			obj.emit_signal("loseHp",obj)
		else:
			if obj.get_filename() == boxPacked.get_path():
				get_tree().get_nodes_in_group("Player").front().attachTo(get_tree().get_nodes_in_group("Player").front().worldNode)
				obj.get_parent().remove_child(obj)
				

#make trap snap if triggered
func _on_Trap_body_entered(body):
	if triggered == false && triggerCD == 0:
		if body.name != "StaticBody2D" && body.name != "TileMap":
			triggerCD = 1
			triggered = true
			obj = body
			$AnimationPlayer.play("Snap")

#open trap on player respawn, if triggered by box make it respawn
func open():
	triggerCD = 1
	if obj != null:
		if obj.get_filename() == boxPacked.get_path():
			var box = boxPacked.instance()
			get_tree().get_root().add_child(box)
			box.global_position = obj.startpos
			box.getpos()
	$AnimationPlayer.play("Open")
	snappedBody.disabled = true
	triggered = false