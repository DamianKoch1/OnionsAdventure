extends Node2D

onready var playerDict = {}

func _ready():
	SaveGame.spawnpoint = self


func respawn(player):
	$respawn.playing = true
	player.global_transform = global_transform
	$OnionRespawnVFX.emitting = true

func playActivationSound():
	$activate.playing = true

func _on_Area2D_body_entered(body):
	if body.is_in_group("Player") && playerDict.has(body) == false:
		playerDict[body] = "connected"
		body.connect("loseHp", self, "respawn")
