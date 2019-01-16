extends Node2D

var collected = false

var savePath = "user://trappedNPCs.cfg"
var saveFile


func _ready():
	saveFile = ConfigFile.new()
	checkCollected()
	

#delete self and increase counter if player presses button in area
func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		if Input.is_action_just_pressed("push") && collected != true:
			remove_from_group("trappedNPCs")
			body.trappedNPCs += 1
			body.emit_signal("NPCsaved")
			collected = true
			saveCollected()
			$AnimationPlayer.play("onCollect")
			SaveGame.saveGame()

#save this objects name and that it was collected into another .cfg
func saveCollected():
	SaveGame.npcDict[str(SaveGame.currLevelId,name)] = collected
	for key in SaveGame.npcDict.keys():
		saveFile.set_value("TrappedNPCs", key, SaveGame.npcDict[key])
	saveFile.save(savePath)

#delete self if already collected in currently saved game
func checkCollected():
	saveFile.load(savePath)
	collected = saveFile.get_value("TrappedNPCs", str(SaveGame.currLevelId,name))
	if collected == true:
		queue_free()
	else:
		add_to_group("trappedNPCs")
	
		
