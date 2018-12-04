extends Node

var savePath 
var saveFile

var latestCheckpoint

func _ready():
	savePath = "user://save.cfg" 
	saveFile = ConfigFile.new()
	

func saveGame():
	saveFile.set_value("SaveState", "latestLevelId", global.currLevelId) 
	saveFile.set_value("SaveState", "spawnPosX", latestCheckpoint.position.x) 
	saveFile.set_value("SaveState", "spawnPosY", latestCheckpoint.position.y) 
	saveFile.set_value("SaveState", "difficulty", global.diff) 
	saveFile.set_value("SaveState", "NPCsSaved", global.player.NPCsavedCount) 
	saveFile.save(savePath)

func loadGame():
	saveFile.load(savePath)
	var levelToLoadId = saveFile.get_value("SaveState", "latestLevelId") 
	global.diff = saveFile.get_value("SaveState", "difficulty") 
	var path = "Levels/Level " + str(levelToLoadId) + ".tscn"
	get_tree().change_scene(path)
	#global.player.NPCsavedCount = saveFile.get_value("Save state", "NPCs saved") 
	#global.player.position.x = saveFile.get_value("Save state", "spawnPosX")
	#global.player.position.y= saveFile.get_value("Save state", "spawnPosY")
	