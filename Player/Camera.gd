extends Camera2D

onready var player = get_parent().find_node("Onion")

#speed must be in [0, 1]
export var camSpeed = 0.08
export var upDownSpeed = 0.05

export var upDownAmount = 100

func _ready():
	if player != null:
		global_position = player.global_position
		#update hud values on certain signals
		player.connect("changeHp", self, "updateHp")
		player.connect("NPCsaved", self, "updateNPCsaved")
		updateHp()
		updateNPCsaved()

func _physics_process(delta):
	if player != null:
		#move camera to playerposition at certain speed, can move camera up/down while not climbing
		global_position.x = lerp(global_position.x, player.global_position.x, camSpeed)
		if player.state != player.climb:
			if Input.is_action_pressed("ui_down"):
				global_position.y = lerp(global_position.y, player.global_position.y + upDownAmount, upDownSpeed)
			elif Input.is_action_pressed("ui_up"):
				global_position.y = lerp(global_position.y, player.global_position.y - upDownAmount, upDownSpeed)
			else:
				global_position.y = lerp(global_position.y, player.global_position.y, upDownSpeed)
		else:
			global_position.y = lerp(global_position.y, player.global_position.y, camSpeed)
		
				
			

func updateHp():
	$HP.set_text("Health: "+str(player.health))

func updateNPCsaved():
	$NPCsSaved.set_text("Animals saved: "+str(player.NPCsavedCount))