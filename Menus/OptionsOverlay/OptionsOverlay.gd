extends Container

onready var diffSlider = $Difficulty/DiffSlider
onready var diffDescription = $Difficulty/DiffText

export var easyDescription = "insert description for easy"
export var normalDescription = "insert description for normal"
export var hardDescription = "insert description for hard"

func _ready():
	match global.diff:
		global.easy:
			diffSlider.value = 0
		global.normal:
			diffSlider.value = 1
		global.hard:
			diffSlider.value = 2
	setDiffDescr()
	hide()

func setDiffDescr():
	match global.diff:
		global.easy:
			diffDescription.text = easyDescription
		global.normal:
			diffDescription.text = normalDescription
		global.hard:
			diffDescription.text = hardDescription

func _on_BackButton_pressed():
	hide()

func _on_DiffSlider_value_changed(value):
	if value == 0:
		global.diff = global.easy
	elif value == 1:
		global.diff = global.normal
	elif value == 2:
		global.diff = global.hard
	setDiffDescr()