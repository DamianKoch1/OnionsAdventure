extends Node

var savePath = "user://save.cfg"  
var saveFile

var latestCheckpoint

var loadPlayerState = false
var NPCsavedCount
var playerPosX
var playerPosY



func _ready():
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
	if saveFile.get_value("SaveState", "difficulty") != null:
		global.diff = saveFile.get_value("SaveState", "difficulty") 
	var path = "Levels/Level " + str(levelToLoadId) + ".tscn"
	get_tree().change_scene(path)
	NPCsavedCount = saveFile.get_value("SaveState", "NPCsSaved") 
	playerPosX = saveFile.get_value("SaveState", "spawnPosX")
	playerPosY = saveFile.get_value("SaveState", "spawnPosY")
	