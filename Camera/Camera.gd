extends Camera2D


onready var npcFull = $CanvasLayer/NPCs/NPCsFull
onready var npcEmpty = $CanvasLayer/NPCs/NPCsEmpty
onready var npcImgWidth  = npcFull.region_rect.size.x / 3

#is assigned by start module
var player

onready var dandelionCounter = $CanvasLayer/Dandelions/Label

onready var hudUpdated = false

func _ready():
	$BGMPlayer.fadeIn()

func _physics_process(delta):
	if player != null:
		global_position = player.global_position
	#ready here is called before collectables check if they are already collected, so hud would always start empty
	if hudUpdated == false:
		hudUpdated = true
		updateNPCsaved()
		updateCollectables()

func connectSignals():
	player.connect("NPCsaved", self, "updateNPCsaved")
	player.connect("collectedDandelion", self, "updateCollectables")

func updateNPCsaved():
	npcFull.region_rect.size.x = (3 - get_tree().get_nodes_in_group("trappedNPCs").size()) * npcImgWidth

func updateCollectables():
	dandelionCounter.text = str(50-get_tree().get_nodes_in_group("dandelions").size()) + "/50"