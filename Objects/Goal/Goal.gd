extends Area2D

onready var panel = $CanvasLayer/Panel
onready var panel1 = $CanvasLayer/Level2Start
onready var panel2 = $CanvasLayer/Level3Start

onready var endPanels = preload("res://Menus/StoryPanels/EndGamePanels/EndGamePanels.tscn")
onready var transitionPanels = preload("res://Menus/StoryPanels/TransitionPanels/TransitionPanels.tscn")

onready var fade = $CanvasLayer/Fade
onready var anim = $AnimationPlayer

onready var npcFull = $CanvasLayer/Collectables/NPCs/NPCsFull
onready var npcImgWidth  = npcFull.region_rect.size.x / 3
onready var dandelionCounter = $CanvasLayer/Collectables/Dandelions/Label


#show story panel depending on current level
func _ready():
	fade.fadeIn(2)
		
#show story panel depending on level, end game at last level
func _on_Goal_body_entered(body):
	if body.is_in_group("Player") && anim.is_playing() == false:
		var i = randf()
		if i > 0.5:
			$SFX/OnionYeah1.play()
		else:
			$SFX/OnionYeah2.play()
		body.playGoalAnim()
		npcFull.region_rect.size.x = (3 - get_tree().get_nodes_in_group("trappedNPCs").size()) * npcImgWidth
		dandelionCounter.text = str(50-get_tree().get_nodes_in_group("dandelions").size()) + "/50"
		anim.play_backwards("fadeIn")
		body.state = body.frozen

func nextAnim():
	if SaveGame.currLevelId == 4:
		anim.play("lastFadeOut")
	else:
		anim.play("fadeOut")

func loadTransitionPanels():
	get_tree().change_scene_to(transitionPanels)

func loadEndPanels():
	get_tree().change_scene_to(endPanels)

