extends Node2D

onready var anim = $AnimationPlayer
onready var fullAnim = $AnimationPlayer2
onready var label = $Speechbubble/Label


#setup spiderbuddy triggers
func _ready():
	for trigger in get_tree().get_nodes_in_group("SpiderbuddyTrigger"):
		trigger.connect("triggered", self, "onTriggerEntered")

func onTriggerEntered(text, delay):
	label.text = text
	if fullAnim.is_playing() == false:
		fullAnim.play("anim")

#used by "anim"
func playAnim(name):
	anim.play(name)