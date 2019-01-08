extends Node2D

var collected = false
#path: C:\Users\username\AppData\Roaming\Godot\app_userdata\Onion Adventures
var savePath = "user://collectibleSave.cfg"
var saveFile

func _ready():
	saveFile = ConfigFile.new()
	checkCollected()

#delete self and increase counter if player presses button in area
func _on_Area2D_body_entered(body):
	if body == global.player:
		if Input.is_action_just_pressed("push"):
			global.player.NPCsavedCount += 1
			global.player.emit_signal("NPCsaved")
			collected = true
			saveCollected()
			$AnimationPlayer.play("onCollect")

#save this objects name and that it was collected into another .cfg
func saveCollected():
	saveFile.set_value(str(global.currLevelId,name), "collected", collected)
	saveFile.save(savePath)

#delete self if already collected in currently saved game
func checkCollected():
	saveFile.load(savePath)
	collected = saveFile.get_value(str(global.currLevelId,name), "collected")
	if collected == true:
		queue_free()