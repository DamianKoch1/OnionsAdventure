extends Camera2D

onready var player = get_parent().find_node("Onion")

export var camSpeed = 0.08

func _ready():
	if player != null:
		global_position = player.global_position
		player.connect("changeHp", self, "updateHp")
		updateHp()

func _physics_process(delta):
	if player != null:
		global_position.x = lerp(global_position.x, player.global_position.x, camSpeed)
		global_position.y = lerp(global_position.y, player.global_position.y, camSpeed)

func updateHp():
	$Label.set_text("Health: "+str(player.health))