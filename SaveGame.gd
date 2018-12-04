extends Node

var savePath = "user://save.cfg" 
var saveFile

var latestCheckpoint



func _ready():
	saveFile = ConfigFile.new()
	
	
func saveGame():
	saveFile.set_value("Save state", "latest level id", global.currLevelId) 
	saveFile.set_value("Save state", "latest checkpoint", latestCheckpoint) 
	saveFile.set_value("Save state", "difficulty", global.diff) 
	saveFile.set_value("Save state", "NPCs saved", global.player.NPCsavedCount) 
	saveFile.save(savePath)

func loadGame():
	pass
	