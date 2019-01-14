extends Node2D

export(NodePath) var objToDestroyPath
export var destroyRadius = 300
var objToDestroyParent

var objToDestroy 
var triggered = false

onready var anim = $AnimationPlayer

var player


#set up destroying object on player jumping on self and resetting it on player respawn
func _ready():
	if objToDestroyPath != null:
		objToDestroy = get_node(objToDestroyPath)
		objToDestroyParent = objToDestroy.get_parent()
	

func _on_FireStoneTrigger_body_entered(body):
	if body.is_in_group("Player") && objToDestroyPath != null:
		if player == null:
			player = body
			player.connect("loseHp", self, "resetObj")
		if body.motion.y > body.gravity*10:
			if triggered == false:
				var distanceToObject = global_position.distance_to(objToDestroy.global_position)
				if body.motion.y > 3 && global_position.distance_to(objToDestroy.global_position) < destroyRadius:
					triggered = true
					anim.play("burn")

#called by burn anim
#fire breath particles
func emit():
	$FireParticles.look_at(objToDestroy.global_position)
	$FireParticles.emitting = true
	$FireParticles/FireSFX.playing = true

#called by burn anim
#burning particles at object
func burn():
	$BurnParticles.global_position = objToDestroy.global_position
	$BurnParticles.emitting = true

#called by burn anim
func removeObj():
	objToDestroyParent = objToDestroy.get_parent()
	objToDestroyParent.remove_child(objToDestroy)

#reset own state on player respawn
func resetObj():
	anim.stop()
	objToDestroyParent.add_child(objToDestroy)
	triggered = false