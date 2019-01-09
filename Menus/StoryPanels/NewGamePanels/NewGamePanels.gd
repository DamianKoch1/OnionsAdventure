extends Node

onready var anim = $AnimationPlayer

onready var lv1 = preload("res://Levels/Level 1.tscn")

func _ready():
	MenuMusic.playing = false
	var fadeOutAnim = $BGMPlayer/AnimationPlayer.get_animation("fadeOut")
	var introTrack = fadeOutAnim.find_track("Intro:volume_db")
	var mainpartTrack = fadeOutAnim.find_track("Mainpart:volume_db")
	fadeOutAnim.track_set_key_value(introTrack, 0, AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music")))
	fadeOutAnim.track_set_key_value(mainpartTrack, 0, AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music")))
	
func loadLv1():
	get_tree().change_scene_to(lv1)


func _on_PanelButton1_pressed():
	$pageTurn.playRandomPitch()
	anim.play("1to2")


func _on_PanelButton2_pressed():
	$pageTurn.playRandomPitch()
	anim.play("2to3")


func _on_PanelButton3_pressed():
	$pageTurn.playRandomPitch()
	anim.play("3")
	$BGMPlayer.fadeOut()


func _on_SkipButton_pressed():
	$PanelButton1.disabled = true
	$PanelButton2.disabled = true
	$PanelButton1.hide()
	$PanelButton2.hide()
	UISelect.playing = true
	anim.play("3")
	$BGMPlayer.fadeOut()
	
