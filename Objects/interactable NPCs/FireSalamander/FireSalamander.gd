extends Node2D

export(NodePath) var objToDestroyPath
export var destroyRadius = 300
var objToDestroyParent

var objToDestroy 
var triggered = false
var player

func _ready():
	if objToDestroyPath != null:
		objToDestroy = get_node(objToDestroyPath)
		

func _on_FireStoneTrigger_body_entered(body):
	if body.name == "Onion" && objToDestroyPath != null:
		if player == null:
			player = body
			player.connect("loseHp", self, "resetObj")
		#destroy assigned object if player enters area with certain downwards motion
		if body.motion.y > body.gravity*10:
			if triggered == false:
				var distanceToObject = global_position.distance_to(objToDestroy.global_position)
				if body.motion.y > 3 && global_position.distance_to(objToDestroy.global_position) < destroyRadius:
					objToDestroyParent = objToDestroy.get_parent()
					objToDestroyParent.remove_child(objToDestroy)
					triggered = true

func resetObj():
	objToDestroyParent.add_child(objToDestroy)
	triggered = false