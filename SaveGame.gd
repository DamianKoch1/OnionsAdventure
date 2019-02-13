extends Node

#path: C:\Users\username\AppData\Roaming\Godot\app_userdata\Onion Adventures
var savePath = "user://save.cfg"  
var saveFile

var settingsPath = "user://settings.cfg"



#volume slider values
var masterVol
var musicVol
var sfxVol

var spawnpoint

#true on new game, player loads position when entering level if true
var loadPlayerState = false

var trappedNPCs = 0
var dandelions = 0
var playerPosX
var playerPosY

#level the player is in
var currLevelId = 0 setget setCurrLevelId
#highest level the player has been in, determines if level buttons show in level selection
var highestLevelId = 1

var npcDict = {}
var dandelionDict = {}


func _ready():
	saveFile = ConfigFile.new()
	loadCollectableCount()
	loadVolume()

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
	
func fileExists(path):
	var dir = Directory.new()
	return dir.file_exists(path)

func saveGame():
	saveFile.set_value("SaveState", "latestLevelId", currLevelId) 
	saveFile.set_value("SaveState", "highestLevelId", highestLevelId)
	saveFile.set_value("SaveState", "spawnPosX", spawnpoint.global_position.x) 
	saveFile.set_value("SaveState", "spawnPosY", spawnpoint.global_position.y) 
	saveFile.set_value("SaveState", "NPCsSaved", trappedNPCs) 
	saveFile.set_value("SaveState", "dandelions", dandelions) 
	saveFile.save(savePath)

func loadGame():
	loadPlayerState = true
	saveFile.load(savePath)
	var levelToLoadId = saveFile.get_value("SaveState", "latestLevelId") 
	var path = "Levels/Level " + str(levelToLoadId) + ".tscn"
	get_tree().change_scene(path)
	get_tree().paused = false
	trappedNPCs = saveFile.get_value("SaveState", "NPCsSaved", 0) 
	dandelions = saveFile.get_value("SaveState", "dandelions", 0)
	playerPosX = saveFile.get_value("SaveState", "spawnPosX", 0)
	playerPosY = saveFile.get_value("SaveState", "spawnPosY", 0)
	
func saveVolume(masterValue, musicValue, sfxValue):
	saveFile.set_value("Volume", "master", masterValue) 
	saveFile.set_value("Volume", "music", musicValue) 
	saveFile.set_value("Volume", "sfx", sfxValue) 
	saveFile.save(settingsPath)

func loadVolume():
	saveFile.load(settingsPath)
	masterVol = saveFile.get_value("Volume", "master", 100)
	musicVol = saveFile.get_value("Volume", "music", 100)
	sfxVol = saveFile.get_value("Volume", "sfx", 100)
	

func checkLevelProgress():
	saveFile.load(savePath)
	highestLevelId = saveFile.get_value("SaveState", "highestLevelId", 1)

func loadCollectableCount():
	saveFile.load(savePath)
	trappedNPCs = saveFile.get_value("SaveState", "NPCsSaved", 0) 
	dandelions = saveFile.get_value("SaveState", "dandelions", 0)