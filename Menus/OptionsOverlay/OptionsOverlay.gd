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
	masterSlider.value = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master"))
	musicSlider.value = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music"))
	sfxSlider.value = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("SoundEffects"))
	diffSlider.value = global.diff
	setDiffDescr()
	#show options if newgame was pressed
	if global.newGame == false:
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
	global.newGame = false
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


func _on_MusicSlider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), sqrt(value*musicSlider.max_value) - 100)


func _on_MasterSlider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), sqrt(value*masterSlider.max_value) - 100)
