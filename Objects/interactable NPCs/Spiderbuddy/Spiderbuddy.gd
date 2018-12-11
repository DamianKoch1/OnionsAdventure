extends Node2D

onready var anim = $AnimationPlayer

#is hanging down?
export var down = false


func _on_upTrigger_body_entered(body):
	if body == global.player && down == true && anim.is_playing() == false:
		anim.play("hide")


#on area exit isnt working properly due to player constantly changing parents
func _on_downTrigger_body_entered(body):
	if body == global.player && down == false && anim.is_playing() == false:
		anim.play("show")
