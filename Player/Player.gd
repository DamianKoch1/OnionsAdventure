extends KinematicBody2D

const UP = Vector2(0, -1)
var motion = Vector2()
var anim
var newAnim
var state
enum {idle, run, jump, fall, climb, dead}

onready var worldNode = get_parent()
onready var ray = $RayCast2D

export var movespeed = 250
export var gravity = 20
export var jumpheight = 550
export var climbSpeed = 200

var rope

export var health = 3 setget setHealth, getHealth

signal noHp
signal loseHp
signal changeHp

func setHealth(newHealth):
	var oldHealth = health
	health = newHealth
	if newHealth != oldHealth:
		emit_signal("changeHp")
		if newHealth < oldHealth :
			emit_signal("loseHp")
	if health <= 0:
		setState(dead)
		get_tree().reload_current_scene()

func getHealth():
	return health

func setState(newState):
	state = newState
	match state:
		idle:
			newAnim = "Onion_Idle"
		run:
			newAnim = "Onion_Walk"
		jump:
			rotation_degrees = 0
			global_scale.x = 0.5
			global_scale.y = 0.5
			newAnim = "Onion_JumpUp"
		fall:
			rotation_degrees = 0
			global_scale.x = 0.5
			global_scale.y = 0.5
			newAnim = "Onion_JumpDown"
		climb:
			#cimb anim?
			newAnim = "Onion_Idle"
		dead:
			#death anim
			rotation_degrees = 90
			$AnimationPlayer.stop()

func _ready():
	setState(idle)
	health = global.maxHealth

func _physics_process(delta):
	if state != dead:
		if newAnim != anim:
			anim = newAnim
			$AnimationPlayer.play(anim)
		if state != climb:
			rayUpdate()
			motion.y += gravity
		elif state == climb:
			if rope != null:
				var transf = get_global_transform()
				attachTo(rope)
				set_global_transform(transf)
				rope = null
			if Input.is_action_pressed("ui_up"):
				motion.y = -climbSpeed
			elif Input.is_action_pressed("ui_down"):
				motion.y = climbSpeed
			else:
				motion.y = 0
		
		if Input.is_action_pressed("ui_right"):
			motion.x = movespeed
			$Sprite.scale.x = 1	
			if is_on_floor() && state != climb:
				setState(run)
		elif Input.is_action_pressed("ui_left"):
			motion.x = -movespeed
			$Sprite.scale.x = -1
			if is_on_floor() && state != climb:
				setState(run)
		else:	
			motion.x = 0
		
		if is_on_floor():
			if motion.x == 0 && state != climb:
				setState(idle)
			if Input.is_action_just_pressed("jump"):
				motion.y = -jumpheight
		else:
			if state != climb:
				if motion.y > 40:
					setState(fall)
				elif motion.y < 0:
					setState(jump)
		motion = move_and_slide(motion, UP)

func bounce(bounceStr):
	motion.y = -bounceStr
	motion = move_and_slide(motion, UP)
	
func rayUpdate():
	if state != climb:
		ray.force_raycast_update()
		if ray.is_colliding():
			var col = ray.get_collider()
			if col.get_class() == "Area2D":
				ray.add_exception(col)
			else:
				if global_position.distance_to(ray.get_collision_point()) <= 30:
					attachTo(col)
				elif global_position.distance_to(ray.get_collision_point()) > 30:
					attachTo(worldNode)
		else:
			attachTo(worldNode)
	
func attachTo(obj):
	if obj.get_class() != "KinematicBody2D":
		var transf = get_global_transform()
		get_parent().remove_child(self)
		obj.add_child(self)
		set_global_transform(transf)
		rotation_degrees = 0






