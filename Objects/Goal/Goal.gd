extends Area2D

onready var panel = $CanvasLayer/Panel
onready var panel1 = $CanvasLayer/Level2Start
onready var panel2 = $CanvasLayer/Level3Start
onready var anim = $AnimationPlayer

func _ready():
	match SaveGame.currLevelId:
		0:
			anim.play("start")
			panel.show()
			panel1.hide()
			panel2.hide()
		1:
			anim.play("start")
			panel.show()
			panel1.hide()
			panel2.hide()
		2:
			anim.play("startLevel2")
			panel.hide()
			panel1.show()
			panel2.hide()
		3:
			anim.play("startLevel3")
			panel.hide()
			panel1.hide()
			panel2.show()
		

func _on_Goal_body_entered(body):
	if body.is_in_group("Player") && anim.is_playing() == false:
			match SaveGame.currLevelId:
				0:
					anim.play("end")
					panel.show()
					panel1.hide()
					panel2.hide()
				1:
					anim.play("endLevel1")
					panel.hide()
					panel1.show()
					panel2.hide()
				2:
					anim.play("endLevel2")
					panel.hide()
					panel1.hide()
					panel2.show()
				3:
					anim.play("end")
					panel.show()
					panel1.hide()
					panel2.hide()
			body.state = body.frozen

func loadNextLevel():
	SaveGame.currLevelId += 1
	var path = "Levels/Level " + str(SaveGame.currLevelId) + ".tscn"
	get_tree().change_scene(path)