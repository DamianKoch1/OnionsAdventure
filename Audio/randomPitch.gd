extends AudioStreamPlayer2D

export (float)var startPitch = 1
export var pitchRange = 0.2

func setRandomPitch():
	var i = randf()*pitchRange
	pitch_scale = startPitch - 0.5*pitchRange + i

func playRandomPitch():
	setRandomPitch()
	playing = true