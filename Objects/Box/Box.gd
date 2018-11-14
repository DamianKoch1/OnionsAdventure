extends KinematicBody2D

var motion = Vector2()
var player
export var brakeSpeed = 0.08
onready var isPushed = false
export var gravity = 12
onready var worldNode = get_parent()
onready var ray = $RayCast2D
var startpos
onready var damageCD = 0

func _ready():
	if startpos == null:
		startpos = global_position

func getpos():
		startpos = global_position

func _physics_process(delta):
	rayUpdate()
	motion.y += gravity
	damageCD = max(damageCD - delta, 0)
	if isPushed == true:
		motion.x = player.motion.x
		if abs(player.motion.y) > 60 || abs(motion.y) > 60:
			isPushed = false
	else:
		motion.x = lerp(motion.x, 0, brakeSpeed)
	motion = move_and_slide(motion)

func _on_Area2D_body_entered(body):
	if body.name == "Onion":
		if player == null:
			player = body
			player.connect("loseHp", self, "resetPos")
		if Input.is_action_just_pressed("push"):
			if isPushed == true:
				isPushed = false
			elif isPushed == false:
				isPushed = true
				global_position.x = global_position.x + (global_position.x - player.global_position.x)/4.2

func rayUpdate():
	ray.force_raycast_update()
	if ray.is_colliding():
		var col = ray.get_collider()
		if col.get_class() == "Area2D" || col.name == "Onion":
			ray.add_exception(col)
		if global_position.distance_to(ray.get_collision_point()) <= 40:
			attachTo(col)
		elif global_position.distance_to(ray.get_collision_point()) > 40:
			attachTo(worldNode)
	else:
		attachTo(worldNode)

func attachTo(obj):
	if obj.get_class() != "Area2D" && obj != get_parent() && obj.name != "Onion":
		var transf = get_global_transform()
		get_parent().remove_child(self)
		obj.add_child(self)
		set_global_transform(transf)
		rotation_degrees = 0

func resetPos():
	global_position = startpos

func _on_damageArea_body_entered(body):
	if damageCD == 0 && body.name == "Onion":
		damageCD = 1
		if motion.y >= 70:
			body.health = max(body.health - 1, 0)
