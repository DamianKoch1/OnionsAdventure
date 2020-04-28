extends Node2D

onready var activated = false

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
	if activated:
		return
	if !body.is_in_group("Player"):
		return
	body.connect("loseHp", self, "respawn")
	activated = true
