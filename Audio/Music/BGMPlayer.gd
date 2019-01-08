extends Node


func _on_Intro_finished():
	$Mainpart.playing = true

func fadeOut():
	$AnimationPlayer.play("fadeOut")