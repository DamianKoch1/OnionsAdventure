extends Node2D

#path of object to burn, max trigger radius and node to attach object back to on respawn
export(NodePath) var objToDestroyPath
export var destroyRadius = 300
var objToDestroyParent
export var useHorizontalFlames = false

var objToDestroy 
var triggered = false

onready var anim = $AnimationPlayer

onready var cone = $FireCone
var flames

var player

#set up destroying and respawning object
func _ready():
	if objToDestroyPath == null:
		return
	objToDestroy = get_node(objToDestroyPath)
	objToDestroyParent = objToDestroy.get_parent()
	
#burns object if object is in range and player has certain y motion, else just spits fire
func _on_FireStoneTrigger_body_entered(body):
	if objToDestroyPath == null:
		return
	if !body.is_in_group("Player"):
		return
	if player == null:
		player = body
		player.connect("loseHp", self, "resetObj")
	if body.motion.y > body.gravity*10:
		var distanceToObject = global_position.distance_to(objToDestroy.global_position)
		if global_position.distance_to(objToDestroy.global_position) < destroyRadius && !triggered:
			triggered = true
			anim.play("burnObj")
		elif !anim.is_playing():
				anim.play("spitFire")

#called by burn anim
#fire breath particles
func emit():
	cone.look_at(objToDestroy.global_position)
	cone.emitting = true
	$FireCone/FireSFX.playing = true

#called by burn anim
#burning particles at object
func burn():
	if useHorizontalFlames == false:
		flames = $Flames/VerticalFlames
	else:
		flames = $Flames/HorizontalFlames
	$Flames.global_position = objToDestroy.global_position
	attachBurningVFX(flames, objToDestroy)
	flames.emitting = true
	$Flames/burningSFX.play()

#called by burn anim
func removeObj():
	objToDestroyParent = objToDestroy.get_parent()
	objToDestroyParent.remove_child(objToDestroy)

#reset on player respawn
func resetObj():
	anim.stop()
	objToDestroyParent.add_child(objToDestroy)
	triggered = false

func attachBurningVFX(object, target):
	var transf = object.get_global_transform()
	object.get_parent().remove_child(object)
	target.add_child(object)
	object.set_global_transform(transf)