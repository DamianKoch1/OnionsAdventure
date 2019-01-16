extends Camera2D


onready var npcFull = $CanvasLayer/NPCs/NPCsFull
onready var npcEmpty = $CanvasLayer/NPCs/NPCsEmpty
onready var npcImgWidth  = npcFull.region_rect.size.x / 3

var npcsInLevel


onready var players = get_tree().get_nodes_in_group("Player")
export var playerId = 0
var player

#get player to follow by id, setup npc hud updating
func _ready():
	$BGMPlayer.fadeIn()
	if players.size() > 0:
		player = players[playerId]
		player.connect("NPCsaved", self, "updateNPCsaved")


func _physics_process(delta):
	#_ready is called too early for registering npcs in level
	if npcsInLevel == null:
		npcsInLevel = get_tree().get_nodes_in_group("trappedNPCs").size()
		npcEmpty.region_rect.size.x = npcsInLevel * npcImgWidth
		updateNPCsaved()
	if player != null:
		global_position = player.global_position


func updateNPCsaved():
	npcFull.region_rect.size.x = (npcsInLevel - get_tree().get_nodes_in_group("trappedNPCs").size()) * npcImgWidth