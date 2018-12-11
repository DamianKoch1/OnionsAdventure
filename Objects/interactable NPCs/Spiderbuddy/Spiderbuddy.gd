extends Node2D

onready var anim = $AnimationPlayer

export var down = false


func _on_upTrigger_body_entered(body):
	if body == global.player && down == true && anim.is_playing() == false:
		anim.play("hide")


func _on_downTrigger_body_entered(body):
	if body == global.player && down == false && anim.is_playing() == false:
		anim.play("show")
