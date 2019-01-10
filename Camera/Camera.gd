extends Camera2D

onready var hpFull = $HP/HealthFull
onready var hpEmpty = $HP/HealthEmpty
onready var heartImgWidth = hpFull.region_rect.size.x / 5
onready var npcFull = $NPCs/NPCsFull
onready var npcEmpty = $NPCs/NPCsEmpty
onready var npcImgWidth  = npcFull.region_rect.size.x / 3

#speed must be in [0, 1], cam won't move at 0
export var camSpeed = 0.08

export var offsetX = 100
export var offsetY = 60

export var topLimit = 800
export var bottomLimit = 800

var npcsInLevel

onready var foundPlayer = false

func _ready():
	$BGMPlayer.fadeIn()
	if global.player != null:
		foundPlayer = true
		global_position = global.player.global_position
		#update hud values on certain signals
		global.player.connect("changeHp", self, "updateHp")
		global.player.connect("NPCsaved", self, "updateNPCsaved")
		hpFull.region_rect.size.x = global.player.maxHealth * heartImgWidth
		hpEmpty.region_rect.size.x = global.player.maxHealth * heartImgWidth
		updateHp()

func _physics_process(delta):
	if foundPlayer == false:
		_ready()
	#_ready is called too early for registering npcs in level
	if npcsInLevel == null:
		npcsInLevel = get_tree().get_nodes_in_group("trappedNPCs").size()
		npcEmpty.region_rect.size.x = npcsInLevel * npcImgWidth
		updateNPCsaved()
	#move camera to playerposition + offset at certain speed
	if global.player != null:
		var targetPosX = global.player.global_position.x + offsetX
		var targetPosY = global.player.global_position.y - offsetY
		if global.player != null:
			global_position.x = lerp(global_position.x, targetPosX, camSpeed)
			global_position.y = lerp(global_position.y, targetPosY, camSpeed)
		global_position.y = max(global_position.y, -topLimit)
		global_position.y = min(global_position.y, bottomLimit)
	


#update hud elements

func updateHp():
	hpFull.region_rect.size.x = global.player.health * heartImgWidth
	hpEmpty.region_rect.size.x = global.player.maxHealth * heartImgWidth

func updateNPCsaved():
	npcFull.region_rect.size.x = (npcsInLevel - get_tree().get_nodes_in_group("trappedNPCs").size()) * npcImgWidth