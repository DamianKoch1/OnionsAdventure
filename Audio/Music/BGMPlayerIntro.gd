extends Node



func _on_Intro_finished():
	$Mainpart.playing = true

#fades in audioplayer volumes from 0 to previous volume
func fadeOut(speed = 1.0):
	var fadeOutAnim = $AnimationPlayer.get_animation("fadeOut")
	var introTrack = fadeOutAnim.find_track("Intro:volume_db")
	var mainpartTrack = fadeOutAnim.find_track("Mainpart:volume_db")
	fadeOutAnim.track_set_key_value(introTrack, 0, $Intro.volume_db)
	fadeOutAnim.track_set_key_value(mainpartTrack, 0, $Mainpart.volume_db)
	$AnimationPlayer.play("fadeOut", -1, speed)

func fadeIn(speed = 1.0):
	var fadeInAnim = $AnimationPlayer.get_animation("fadeIn")
	var introTrack = fadeInAnim.find_track("Intro:volume_db")
	var mainpartTrack = fadeInAnim.find_track("Mainpart:volume_db")
	fadeInAnim.track_set_key_value(introTrack, 1, $Intro.volume_db)
	fadeInAnim.track_set_key_value(mainpartTrack, 1, $Mainpart.volume_db)
	$AnimationPlayer.play("fadeIn", -1, speed)