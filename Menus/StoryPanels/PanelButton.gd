extends TextureButton

onready var anim = $AnimationPlayer
export var animSpeed = 1.0

signal animFinished

func delete():
	emit_signal("animFinished")
	queue_free()


func _on_PanelButton_pressed():
	if anim.is_playing() != true:
		$pageTurn.playRandomPitch()
		anim.play("nextPanel", 1, animSpeed)
