extends TextureButton

export var levelId = 1
onready var fade = $CanvasLayer/Fade
onready var transitionPanels = preload("res://Menus/StoryPanels/TransitionPanels/TransitionPanels.tscn")
onready var newGamePanels = preload("res://Menus/StoryPanels/NewGamePanels/NewGamePanels.tscn")
var scene

func loadScene():
	if levelId == 1:
		scene = newGamePanels
	else:
		scene = transitionPanels
	SaveGame.currLevelId = levelId-1
	get_tree().change_scene_to(scene)


func _on_LevelButton_pressed():
	$UISelect.playing = true
	fade.oneshot(self, "loadScene")


func _on_LevelButton_mouse_entered():
	grab_focus()
