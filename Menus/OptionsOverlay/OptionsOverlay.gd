extends Container

onready var diffSlider = $Difficulty/DiffSlider
onready var diffDescription = $Difficulty/DiffText

onready var masterSlider = $Volume/Master/MasterSlider
onready var musicSlider = $Volume/Music/MusicSlider
onready var sfxSlider = $Volume/SFX/SFXSlider

export var easyDescription = "insert description for easy"
export var normalDescription = "insert description for normal"
export var hardDescription = "insert description for hard"

func _ready():
	if global.masterVol != null:
		masterSlider.value = global.masterVol
	if global.musicVol != null:
		musicSlider.value = global.musicVol
	if global.sfxVol != null:
		sfxSlider.value = global.sfxVol
	diffSlider.value = global.diff
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
	UISelect.playing = true
	hide()

func _on_DiffSlider_value_changed(value):
	if value == 0:
		global.diff = global.easy
	elif value == 1:
		global.diff = global.normal
	elif value == 2:
		global.diff = global.hard
	setDiffDescr()

func _on_SFXSlider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SoundEffects"), sqrt(value*sfxSlider.max_value) - 100)
	global.sfxVol = value

func _on_MusicSlider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), sqrt(value*musicSlider.max_value) - 100)
	global.musicVol = value

func _on_MasterSlider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), sqrt(value*masterSlider.max_value) - 100)
	global.masterVol = value