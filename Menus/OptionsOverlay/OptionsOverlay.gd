extends Container


var savePath = "user://settings.cfg"
var saveFile

onready var masterSlider = $Volume/Master/MasterSlider
onready var musicSlider = $Volume/Music/MusicSlider
onready var sfxSlider = $Volume/SFX/SFXSlider

#volume slider values
var masterVol
var musicVol
var sfxVol


func _ready():
	saveFile = ConfigFile.new()
	loadVolume()
	hide()

func saveVolume():
	saveFile.set_value("Volume", "master", masterSlider.value) 
	saveFile.set_value("Volume", "music", musicSlider.value) 
	saveFile.set_value("Volume", "sfx", sfxSlider.value) 
	saveFile.save(savePath)

func loadVolume():
	if File.new().file_exists(savePath):
		saveFile.load(savePath)
		masterSlider.value = saveFile.get_value("Volume", "master")
		musicSlider.value = saveFile.get_value("Volume", "music")
		sfxSlider.value = saveFile.get_value("Volume", "sfx")

func _on_BackButton_pressed():
	UISelect.playing = true
	hide()

func _on_SFXSlider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SoundEffects"), sqrt(value*sfxSlider.max_value) - 100)
	saveVolume()

func _on_MusicSlider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), sqrt(value*musicSlider.max_value) - 100)
	saveVolume()

func _on_MasterSlider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), sqrt(value*masterSlider.max_value) - 100)
	saveVolume()