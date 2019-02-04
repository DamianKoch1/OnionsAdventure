extends Node2D

onready var dandelionText = $Overlay/Dandelions/Label
onready var npcText = $Overlay/TrappedNPCs/Label
onready var anim = $AnimationPlayer

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
	_on_TextureButton_pressed()


func _on_TextureButton_pressed():
	if SaveGame.dandelions >= dandelionsNeeded && SaveGame.trappedNPCs >= NPCsNeeded:
		anim.play("unlock")
