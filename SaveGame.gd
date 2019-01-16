extends Node

#path: C:\Users\username\AppData\Roaming\Godot\app_userdata\Onion Adventures
var savePath = "user://save.cfg"  
var saveFile

var latestCheckpoint

var loadPlayerState = false
var trappedNPCs
var dandelions
var playerPosX
var playerPosY

#level the player is in
var currLevelId = 0

func _ready():
	saveFile = ConfigFile.new()

func deleteSave():
	var dir = Directory.new()
	dir.remove(savePath)
	dir.remove("user://trappedNPCs.cfg")
	dir.remove("user://dandelions.cfg")


func saveGame():
	saveFile.set_value("SaveState", "latestLevelId", currLevelId) 
	saveFile.set_value("SaveState", "spawnPosX", latestCheckpoint.global_position.x) 
	saveFile.set_value("SaveState", "spawnPosY", latestCheckpoint.global_position.y) 
	saveFile.set_value("SaveState", "NPCsSaved", get_tree().get_nodes_in_group("Player")[0].trappedNPCs) 
	saveFile.set_value("SaveState", "dandelions", get_tree().get_nodes_in_group("Player")[0].dandelions) 
	saveFile.save(savePath)

func loadGame():
	saveFile.load(savePath)
	var levelToLoadId = saveFile.get_value("SaveState", "latestLevelId") 
	var path = "Levels/Level " + str(levelToLoadId) + ".tscn"
	get_tree().change_scene(path)
	get_tree().paused = false
	trappedNPCs = saveFile.get_value("SaveState", "NPCsSaved") 
	dandelions = saveFile.get_value("SaveState", "dandelions")
	playerPosX = saveFile.get_value("SaveState", "spawnPosX")
	playerPosY = saveFile.get_value("SaveState", "spawnPosY")
	