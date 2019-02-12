extends Container

#used for eg going to main menu from level or quitting to prevent misclicks

signal yesPressed
signal noPressed

func _ready():
	hide()

func _on_NoButton_pressed():
	UISelect.playing = true
	emit_signal("noPressed")

func _on_YesButton_pressed():
	UISelect.playing = true
	emit_signal("yesPressed")

