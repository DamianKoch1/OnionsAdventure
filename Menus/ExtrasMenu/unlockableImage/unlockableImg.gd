extends Node2D

onready var dandelionText = $Overlay/Dandelions/Label
onready var npcText = $Overlay/TrappedNPCs/Label
onready var anim = $unlock

onready var expanded = false

export var dandelionsNeeded = 0
export var NPCsNeeded = 0


#make texts display correct number, hide if unlock requirements arent met
func _ready():
	if dandelionsNeeded > 0:
		dandelionText.text = "x " + str(dandelionsNeeded)
	else:
		$Overlay/Dandelions.hide()
	if NPCsNeeded > 0:
		npcText.text = "x " + str(NPCsNeeded)
	else:
		$Overlay/TrappedNPCs.hide()
	if SaveGame.dandelions >= dandelionsNeeded && SaveGame.trappedNPCs >= NPCsNeeded:
		anim.play("unlock")


func _on_TextureButton_pressed():
	#needs animationplayer attched when used in other scenes because animation is different for each concept
	if has_node("AnimationPlayer"):
		if $AnimationPlayer.is_playing():
			return
		if expanded == false:
			$AnimationPlayer.play("expand")
			expanded = true
		else:
			$AnimationPlayer.play_backwards("expand")
			expanded = false
