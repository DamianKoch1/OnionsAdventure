extends Node2D

onready var anim = $AnimationPlayer
onready var label = $Speechbubble/Label
onready var idleTimer = $IdleTimer

#setup spiderbuddy triggers
func _ready():
	for trigger in get_tree().get_nodes_in_group("SpiderbuddyTrigger"):
		trigger.connect("triggered", self, "onTriggerEntered")
		trigger.connect("spiderHide", self, "onSelectedKeyPressed")

func onTriggerEntered(text, idleDuration):
	label.text = text
	idleTimer.wait_time = idleDuration
	if !anim.is_playing():
		anim.play("show")

#when key spiderbuddy waits for is pressed he should either not appear (in trigger script) or go up again
func onSelectedKeyPressed():
	if anim.get_current_animation() == "blabbing":
		anim.play("hide")
		idleTimer.stop()


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "show":
		anim.play("blabbing")
		idleTimer.start()


func _on_IdleTimer_timeout():
	anim.play("hide")
	idleTimer.stop()
