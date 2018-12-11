extends Container


signal yesPressed

func _ready():
	hide()


func _on_NoButton_pressed():
	hide()

func _on_YesButton_pressed():
	emit_signal("yesPressed")

