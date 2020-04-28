extends Node2D


#incase of collect animation later
var collected = false

var savePath = "user://dandelions.cfg"
var saveFile

func _ready():
	saveFile = ConfigFile.new()
	checkCollected()

func _on_Area2D_body_entered(body):
	if collected:
		return
	if !body.is_in_group("Player"):
		return
	SaveGame.dandelions += 1
	collected = true
	remove_from_group("dandelions")
	body.emit_signal("collectedDandelion")
	saveCollected()
	SaveGame.saveGame()
	hide()
	$AudioStreamPlayer2D.playing = true

#save level number, own name and collected state
func saveCollected():
	SaveGame.dandelionDict[str(SaveGame.currLevelId,name)] = collected
	for key in SaveGame.dandelionDict.keys():
		saveFile.set_value("Dandelions", key, SaveGame.dandelionDict[key])
	saveFile.save(savePath)

#delete self if already collected in currently saved game
func checkCollected():
	saveFile.load(savePath)
	collected = saveFile.get_value("Dandelions", str(SaveGame.currLevelId,name), false)
	if collected == true:
		queue_free()
