extends Node2D


#incase of collect animation
var collected = false

var savePath = "user://dandelions.cfg"
var saveFile

func _ready():
	saveFile = ConfigFile.new()
	checkCollected()

func _on_Area2D_body_entered(body):
	if body.is_in_group("Player") && collected != true:
		SaveGame.dandelions += 1
		collected = true
		saveCollected()
		SaveGame.saveGame()
		queue_free()

func saveCollected():
	SaveGame.dandelionDict[str(SaveGame.currLevelId,self)] = collected
	for key in SaveGame.dandelionDict.keys():
		saveFile.set_value("Dandelions", key, SaveGame.dandelionDict[key])
	saveFile.save(savePath)

#delete self if already collected in currently saved game
func checkCollected():
	saveFile.load(savePath)
	collected = saveFile.get_value("Dandelions", str(SaveGame.currLevelId,self), false)
	if collected == true:
		queue_free()
