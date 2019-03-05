extends Node2D

#dictionary for known players
onready var playerDict = {}

func _ready():
	SaveGame.spawnpoint = self

func respawn(player):
	$respawn.playing = true
	player.global_transform = global_transform
	$OnionRespawnVFX.emitting = true

func activate():
	$activate.playing = true
	$AnimationPlayer.play("activate")

#setup respawning for not yet known players and give them a dict entry to prevent signal reconecting multiple times
func _on_Area2D_body_entered(body):
	if body.is_in_group("Player") && playerDict.has(body) == false:
		playerDict[body] = "connected"
		body.connect("loseHp", self, "respawn")
