extends Container


onready var masterSlider = $Volume/Master/MasterSlider
onready var musicSlider = $Volume/Music/MusicSlider
onready var sfxSlider = $Volume/SFX/SFXSlider


func _ready():
	if global.masterVol != null:
		masterSlider.value = global.masterVol
	if global.musicVol != null:
		musicSlider.value = global.musicVol
	if global.sfxVol != null:
		sfxSlider.value = global.sfxVol
	hide()


func _on_BackButton_pressed():
	UISelect.playing = true
	hide()

func _on_SFXSlider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SoundEffects"), sqrt(value*sfxSlider.max_value) - 100)
	global.sfxVol = value

func _on_MusicSlider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), sqrt(value*musicSlider.max_value) - 100)
	global.musicVol = value

func _on_MasterSlider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), sqrt(value*masterSlider.max_value) - 100)
	global.masterVol = value