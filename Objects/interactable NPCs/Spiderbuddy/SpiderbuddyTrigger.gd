extends Node2D

#text that spiderbuddy will "say" for this trigger
export var text = "insert text"

signal triggered

func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		emit_signal("triggered", text)