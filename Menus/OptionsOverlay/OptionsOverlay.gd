extends Container



onready var masterSlider = $Volume/Master/MasterSlider
onready var musicSlider = $Volume/Music/MusicSlider
onready var sfxSlider = $Volume/SFX/SFXSlider




func _ready():
	SaveGame.loadVolume()
	masterSlider.value = SaveGame.masterVol
	musicSlider.value = SaveGame.musicVol
	sfxSlider.value = SaveGame.sfxVol
	hide()



#set volume bus values if sliders change
func _on_SFXSlider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SoundEffects"), sqrt(value*sfxSlider.max_value) - 100)
	SaveGame.saveVolume(masterSlider.value, musicSlider.value, sfxSlider.value)

func _on_MusicSlider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), sqrt(value*musicSlider.max_value) - 100)
	SaveGame.saveVolume(masterSlider.value, musicSlider.value, sfxSlider.value)

func _on_MasterSlider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), sqrt(value*masterSlider.max_value) - 100)
	SaveGame.saveVolume(masterSlider.value, musicSlider.value, sfxSlider.value)