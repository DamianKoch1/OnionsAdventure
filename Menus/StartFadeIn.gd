extends Panel

#black panel fades out at start
func _ready():
	show()
	$AnimationPlayer.play("fadeIn")