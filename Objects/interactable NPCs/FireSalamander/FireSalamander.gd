extends Node2D

export(NodePath) var objToDestroyPath
export var destroyRadius = 300
var objToDestroyParent

var objToDestroy 
var triggered = false

#set up destroying object on player jumping on self and resetting it on player respawn
func _ready():
	if objToDestroyPath != null && global.player != null:
		global.player.connect("loseHp", self, "resetObj")
		objToDestroy = get_node(objToDestroyPath)
		objToDestroyParent = objToDestroy.get_parent()
		

func _on_FireStoneTrigger_body_entered(body):
	if body == global.player && objToDestroyPath != null:
		#destroy assigned object if player enters area with certain downwards motion
		if body.motion.y > body.gravity*10:
			if triggered == false:
				var distanceToObject = global_position.distance_to(objToDestroy.global_position)
				if body.motion.y > 3 && global_position.distance_to(objToDestroy.global_position) < destroyRadius:
					$FireParticles.look_at(objToDestroy.global_position)
					$FireParticles.emitting = true
					objToDestroyParent = objToDestroy.get_parent()
					objToDestroyParent.remove_child(objToDestroy)
					triggered = true

#reset own state on player respawn
func resetObj():
	objToDestroyParent.add_child(objToDestroy)
	triggered = false