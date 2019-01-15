extends Area2D

onready var panel = $CanvasLayer/Panel
onready var anim = $AnimationPlayer

func _ready():
	anim.play("start")

func _on_Goal_body_entered(body):
	if body.is_in_group("Player") && anim.is_playing() == false:
			anim.play("end")
			body.state = body.noControl

func loadNextLevel():
	global.currLevelId += 1
	var path = "Levels/Level " + str(global.currLevelId) + ".tscn"
	get_tree().change_scene(path)