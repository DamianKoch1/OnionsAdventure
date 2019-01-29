extends Node2D

export(NodePath) var objToDestroyPath
export var destroyRadius = 300
var objToDestroyParent

var objToDestroy 
var triggered = false

onready var anim = $AnimationPlayer

var player

#set up destroying and respawning object
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
			var distanceToObject = global_position.distance_to(objToDestroy.global_position)
			if body.motion.y > 3:
				if global_position.distance_to(objToDestroy.global_position) < destroyRadius && triggered != true:
					triggered = true
					anim.play("burnObj")
				else:
					if anim.is_playing() != true:
						anim.play("spitFire")

#called by burn anim
#fire breath particles
func emit():
	$Fire_salamander_FlameVFX.look_at(objToDestroy.global_position)
	$Fire_salamander_FlameVFX.emitting = true
	$Fire_salamander_FlameVFX/FireSFX.playing = true

#called by burn anim
#burning particles at object
func burn():
	$Burning_Thorns_FlameVFX.global_position = objToDestroy.global_position
	$Burning_Thorns_FlameVFX.emitting = true

#called by burn anim
func removeObj():
	objToDestroyParent = objToDestroy.get_parent()
	objToDestroyParent.remove_child(objToDestroy)

#reset on player respawn
func resetObj():
	anim.stop()
	objToDestroyParent.add_child(objToDestroy)
	triggered = false