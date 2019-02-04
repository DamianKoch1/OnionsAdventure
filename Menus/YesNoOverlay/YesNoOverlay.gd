extends Container

#used for eg going to main menu from level or quitting to prevent misclicks

signal yesPressed

func _ready():
	hide()

func _on_NoButton_pressed():
	UISelect.playing = true
	hide()

func _on_YesButton_pressed():
	UISelect.playing = true
	emit_signal("yesPressed")

