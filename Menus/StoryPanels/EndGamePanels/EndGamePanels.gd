extends Node

onready var anim = $AnimationPlayer

onready var mainMenu = preload("res://Menus/MainMenu/MainMenu.tscn")

export var atPanel = 1

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	MenuMusic.fadeOut(2)
	$BGMPlayer.fadeIn(2)
	atPanel = 1

func _process(delta):
	if Input.is_action_just_pressed("jump") && anim.is_playing() == false:
		match atPanel:
			1:
				$pageTurn.playRandomPitch()
				anim.play("1to2")
			2:
				$pageTurn.playRandomPitch()
				anim.play("2to3")
			3:
				$pageTurn.playRandomPitch()
				atPanel = 4
				anim.play("3")
	
func loadMainMenu():
	get_tree().change_scene_to(mainMenu)


func _on_PanelButton1_pressed():
	if anim.is_playing() == false:
		$pageTurn.playRandomPitch()
		anim.play("1to2")


func _on_PanelButton2_pressed():
	if anim.is_playing() == false:
		$pageTurn.playRandomPitch()
		anim.play("2to3")


func _on_PanelButton3_pressed():
	if anim.is_playing() == false:
		atPanel = 4
		$pageTurn.playRandomPitch()
		anim.play("3")
		$BGMPlayer.fadeOut()


func _on_SkipButton_pressed():
	atPanel = 4
	if has_node("PanelButton1"):
		$PanelButton1.disabled = true
		$PanelButton1.hide()
	if has_node("PanelButton2"):
		$PanelButton2.disabled = true
		$PanelButton2.hide()
	UISelect.playing = true
	anim.play("3")
	$BGMPlayer.fadeOut()
	
