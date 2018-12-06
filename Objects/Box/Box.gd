extends KinematicBody2D

var motion = Vector2()

#must be in [0, 1], 0 doesnt brake, 1 instantly brakes
export var brakeSpeed = 0.08

onready var isPushed = false
export var gravity = 12

onready var worldNode = get_parent()
onready var ray = $RayCast2D

var startpos

#distance player-box, pushing stops if distance too high
var distance

#make box reset its position if player respawns
func _ready():
	if global.player != null:
		global.player.connect("loseHp", self, "resetPos")
	getpos()

func _physics_process(delta):
	rayUpdate()
	motion.y += gravity
	#move with player if being pushed
	if isPushed == true:
		motion.x = global.player.motion.x
		if abs(global.player.motion.y) > 60 || abs(motion.y) > 60 || global_position.distance_to(global.player.global_position) > distance + 30:
			isPushed = false
	#slow down if player stops pushing
	else:
		motion.x = lerp(motion.x, 0, brakeSpeed)
	motion = move_and_slide(motion)

func getpos():
		startpos = global_position

func _on_Area2D_body_entered(body):
		#can press "push"button to push when in range
		if Input.is_action_just_pressed("push"):
			if isPushed == true:
				isPushed = false
			elif isPushed == false:
				isPushed = true
				global_position.x = global_position.x + (global_position.x - global.player.global_position.x)/4.2
				distance = abs(global_position.x - global.player.global_position.x)

func rayUpdate():
	#find first object ray downwards hits and attach to it
	ray.force_raycast_update()
	if ray.is_colliding():
		var col = ray.get_collider()
		if col.get_class() == "Area2D" || col == global.player:
			ray.add_exception(col)
		if global_position.distance_to(ray.get_collision_point()) <= 40:
			attachTo(col)
		elif global_position.distance_to(ray.get_collision_point()) > 40:
			attachTo(worldNode)
	else:
		attachTo(worldNode)

func attachTo(obj):
	#attach self to obj
	if obj.get_class() != "Area2D" && obj != get_parent() && obj != global.player:
		var transf = get_global_transform()
		get_parent().remove_child(self)
		obj.add_child(self)
		set_global_transform(transf)
		rotation_degrees = 0

#go to startposition on player respawn
func resetPos():
	global_position = startpos

