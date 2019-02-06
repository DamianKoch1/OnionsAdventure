extends Node2D

#text that spiderbuddy will "say" for this trigger
export var text = "insert text"
export var spiderCooldown = 15

onready var cd = 0

signal triggered

func _process(delta):
	cd = max(cd-delta, 0)

func _on_Area2D_body_entered(body):
	if body.is_in_group("Player") && cd == 0:
		emit_signal("triggered", text)
		cd = spiderCooldown