extends Node

#path: C:\Users\username\AppData\Roaming\Godot\app_userdata\Onion Adventures
var savePath = "user://save.cfg"  
var saveFile

var spawnpoint

var loadPlayerState = false
var trappedNPCs = 0
var dandelions = 0
var playerPosX
var playerPosY

#level the player is in
var currLevelId = 0 setget setCurrLevelId
var highestLevelId = 1

var npcDict = {}
var dandelionDict = {}


func _ready():
	saveFile = ConfigFile.new()
	loadCollectableCount()

func setCurrLevelId(newId):
	if newId > currLevelId:
		highestLevelId = newId
	currLevelId = newId

func deleteSave():
	var dir = Directory.new()
	dir.remove(savePath)
	dir.remove("user://trappedNPCs.cfg")
	dir.remove("user://dandelions.cfg")
	trappedNPCs = 0
	dandelions = 0



func saveGame():
	saveFile.set_value("SaveState", "latestLevelId", currLevelId) 
	saveFile.set_value("SaveState", "highestLevelId", highestLevelId)
	saveFile.set_value("SaveState", "spawnPosX", spawnpoint.global_position.x) 
	saveFile.set_value("SaveState", "spawnPosY", spawnpoint.global_position.y) 
	saveFile.set_value("SaveState", "NPCsSaved", trappedNPCs) 
	saveFile.set_value("SaveState", "dandelions", dandelions) 
	saveFile.save(savePath)

func loadGame():
	saveFile.load(savePath)
	var levelToLoadId = saveFile.get_value("SaveState", "latestLevelId") 
	var path = "Levels/Level " + str(levelToLoadId) + ".tscn"
	get_tree().change_scene(path)
	get_tree().paused = false
	trappedNPCs = saveFile.get_value("SaveState", "NPCsSaved", 0) 
	dandelions = saveFile.get_value("SaveState", "dandelions", 0)
	playerPosX = saveFile.get_value("SaveState", "spawnPosX", 0)
	playerPosY = saveFile.get_value("SaveState", "spawnPosY", 0)
	

func checkLevelProgress():
	saveFile.load(savePath)
	highestLevelId = saveFile.get_value("SaveState", "highestLevelId", 1)

func loadCollectableCount():
	saveFile.load(savePath)
	trappedNPCs = saveFile.get_value("SaveState", "NPCsSaved", 0) 
	dandelions = saveFile.get_value("SaveState", "dandelions", 0)