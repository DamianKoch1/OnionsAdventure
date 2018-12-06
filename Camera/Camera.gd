extends Camera2D

onready var hpFull = $HP/HealthFull
onready var hpEmpty = $HP/HealthEmpty
onready var heartImgWidth = hpFull.region_rect.size.x / 5

#speed must be in [0, 1], cam won't move at 0
export var camSpeed = 0.08


func _ready():
	if global.player != null:
		global_position = global.player.global_position
		#update hud values on certain signals
		global.player.connect("changeHp", self, "updateHp")
		global.player.connect("NPCsaved", self, "updateNPCsaved")
		if global.diff == global.hard:
			hpFull.region_rect.size.x = global.player.hardHealth * heartImgWidth
			hpEmpty.region_rect.size.x = global.player.hardHealth * heartImgWidth
		else:
			hpFull.region_rect.size.x = global.player.normalHealth * heartImgWidth
			hpEmpty.region_rect.size.x = global.player.normalHealth * heartImgWidth
		updateHp()
		updateNPCsaved()

func _physics_process(delta):
	#move camera to playerposition at certain speed
	if global.player != null:
		global_position.x = lerp(global_position.x, global.player.global_position.x, camSpeed)
		global_position.y = lerp(global_position.y, global.player.global_position.y, camSpeed)
		
				
			

#update hud elements

func updateHp():
	hpFull.region_rect.size.x = global.player.health * heartImgWidth
	if global.diff == global.hard:
		hpEmpty.region_rect.size.x = global.player.hardHealth * heartImgWidth
	else:
		hpEmpty.region_rect.size.x = global.player.normalHealth * heartImgWidth

func updateNPCsaved():
	$NPCsSaved.set_text("Animals saved: "+str(global.player.NPCsavedCount))