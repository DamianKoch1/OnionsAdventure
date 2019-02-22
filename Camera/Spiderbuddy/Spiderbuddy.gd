extends Node2D

onready var anim = $AnimationPlayer
onready var label = $Speechbubble/Label
onready var idleTimer = $IdleTimer

#setup spiderbuddy triggers
func _ready():
	for trigger in get_tree().get_nodes_in_group("SpiderbuddyTrigger"):
		trigger.connect("triggered", self, "onTriggerEntered")

func onTriggerEntered(text, idleDuration):
	label.text = text
	idleTimer.wait_time = idleDuration
	if anim.is_playing() == false:
		anim.play("show")



func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "show":
		anim.play("blabbing")
		idleTimer.start()


func _on_IdleTimer_timeout():
	anim.play("hide")
	idleTimer.stop()
