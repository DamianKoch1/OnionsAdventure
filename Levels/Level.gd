extends Node2D

func _ready():
	SaveGame.currLevelId = int(name)
