extends Node


func _on_Intro_finished():
	$Mainpart.playing = true

func fadeOut():
	var fadeOutAnim = $AnimationPlayer.get_animation("fadeOut")
	var introTrack = fadeOutAnim.find_track("Intro:volume_db")
	var mainpartTrack = fadeOutAnim.find_track("Mainpart:volume_db")
	fadeOutAnim.track_set_key_value(introTrack, 0, $Intro.volume_db)
	fadeOutAnim.track_set_key_value(mainpartTrack, 0, $Mainpart.volume_db)
	$AnimationPlayer.play("fadeOut")