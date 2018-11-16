extends Camera2D

onready var player = get_parent().find_node("Onion")

#speed must be in [0, 1]
export var camSpeed = 0.08

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
		#move camera to playerposition at certain speed
		global_position.x = lerp(global_position.x, player.global_position.x, camSpeed)
		global_position.y = lerp(global_position.y, player.global_position.y, camSpeed)

func updateHp():
	$HP.set_text("Health: "+str(player.health))

func updateNPCsaved():
	$NPCsSaved.set_text("Animals saved: "+str(player.NPCsavedCount))