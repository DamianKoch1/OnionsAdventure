extends Node2D

var collected = false
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
			queue_free()

func saveCollected():
	saveFile.set_value(str(global.currLevelId,name), "collected", collected)
	saveFile.save(savePath)

func checkCollected():
	saveFile.load(savePath)
	collected = saveFile.get_value(str(global.currLevelId,name), "collected")
	if collected == true:
		queue_free()