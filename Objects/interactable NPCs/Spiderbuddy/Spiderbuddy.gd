extends Node2D

onready var anim = $AnimationPlayer
onready var label = $Speechbubble/Label

#is hanging down?
export var down = false


func show(text):
	if down == false && anim.is_playing() == false:
		label.text = text
		anim.play("show")


func hide():
	if down == true && anim.is_playing() == false:
		anim.play("hide")
