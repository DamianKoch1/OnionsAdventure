extends Area2D

onready var panel = $CanvasLayer/Panel
onready var anim = $AnimationPlayer

func _ready():
	anim.play("start")

func _on_Goal_body_entered(body):
	if body.is_in_group("Player") && anim.is_playing() == false:
			anim.play("end")
			body.state = body.frozen

func loadNextLevel():
	var path = "Levels/Level " + str(SaveGame.currLevelId+1) + ".tscn"
	get_tree().change_scene(path)