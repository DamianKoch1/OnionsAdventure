extends Node2D

onready var anim = $AnimationPlayer
onready var fullAnim = $AnimationPlayer2
onready var label = $Speechbubble/Label

var player

func _ready():
	for trigger in get_tree().get_nodes_in_group("SpiderbuddyTrigger"):
		trigger.connect("triggered", self, "playAnim")



func playAnim(text):
	label.text = text
	if fullAnim.is_playing() == false:
		fullAnim.play("anim")

func show():
	anim.play("show")


func hide():
	anim.play("hide")
