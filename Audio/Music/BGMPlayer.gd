extends AudioStreamPlayer


#fades in audioplayer volume from 0 to previous volume
func fadeIn(speed = 1.0):
	var fadeInAnim = $AnimationPlayer.get_animation("fadeIn")
	var track = fadeInAnim.find_track("volume_db")
	fadeInAnim.track_set_key_value(track, 1, volume_db)
	$AnimationPlayer.play("fadeIn", -1, speed)

func fadeOut(speed = 1.0):
	var fadeOutAnim = $AnimationPlayer.get_animation("fadeOut")
	var track = fadeOutAnim.find_track("volume_db")
	fadeOutAnim.track_set_key_value(track, 0, volume_db)
	$AnimationPlayer.play("fadeOut", -1, speed)