extends AudioStreamPlayer2D

export (float)var startPitch = 1
export var pitchRange = 0.2

func setRandomPitch():
	#random float from 0 to pitchRange
	var i = randf()*pitchRange
	#pitch scale can be 1-0.5pitchRange to 1+0.5pitchRange
	pitch_scale = startPitch - 0.5*pitchRange + i

func playRandomPitch():
	setRandomPitch()
	playing = true