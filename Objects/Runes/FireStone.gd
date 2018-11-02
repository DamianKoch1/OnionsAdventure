extends Node2D

export(NodePath) var objToDestroyPath
export var destroyRadius = 300

var objToDestroy 
var triggered = false

func _ready():
	if objToDestroyPath != null:
		objToDestroy = get_node(objToDestroyPath)

func _on_FireStoneTrigger_body_entered(body):
	if body.name == "Onion":
		if body.motion.y > body.gravity*15:
			if triggered == false:
				var distanceToObject = global_position.distance_to(objToDestroy.global_position)
				if body.motion.y > 3 && global_position.distance_to(objToDestroy.global_position) < destroyRadius:
					objToDestroy.get_parent().remove_child(objToDestroy)
					triggered = true