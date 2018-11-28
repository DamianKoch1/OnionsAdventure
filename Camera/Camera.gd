extends Camera2D


#speed must be in [0, 1], cam won't move at 0
export var camSpeed = 0.08
export var upDownSpeed = 0.05

#distance camera can look up/down on pressing up/down
export var upDownAmount = 100

func _ready():
	if global.player != null:
		global_position = global.player.global_position
		#update hud values on certain signals
		global.player.connect("changeHp", self, "updateHp")
		global.player.connect("NPCsaved", self, "updateNPCsaved")
		updateHp()
		updateNPCsaved()

func _physics_process(delta):
	#move camera to playerposition at certain speed, can move camera up/down while not climbing
	if global.player != null:
		global_position.x = lerp(global_position.x, global.player.global_position.x, camSpeed)
		if global.player.state != global.player.climb:
			if Input.is_action_pressed("ui_down"):
				global_position.y = lerp(global_position.y, global.player.global_position.y + upDownAmount, upDownSpeed)
			elif Input.is_action_pressed("ui_up"):
				global_position.y = lerp(global_position.y, global.player.global_position.y - upDownAmount, upDownSpeed)
			else:
				global_position.y = lerp(global_position.y, global.player.global_position.y, upDownSpeed)
		else:
			global_position.y = lerp(global_position.y, global.player.global_position.y, camSpeed)
		
				
			

#update hud elements

func updateHp():
	$HP.set_text("Health: "+str(global.player.health))

func updateNPCsaved():
	$NPCsSaved.set_text("Animals saved: "+str(global.player.NPCsavedCount))