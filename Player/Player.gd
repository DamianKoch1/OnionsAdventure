extends KinematicBody2D

const UP = Vector2(0, -1)
var motion = Vector2()
var anim
var newAnim
var state
enum {idle, run, jump, fall, climb, dead}

onready var worldNode = get_parent()
onready var ray = $RayCast2D



onready var ghostjumpTimeframe = 0
export var maxGhostjumpDelay = 0.2

export var movespeed = 250
export var gravity = 20
export var jumpheight = 550
export var climbspeed = 200

onready var debugGodmode = -1
onready var debugFly = -1


var rope
var ropeAttachCD = 0

export var health = 3 setget setHealth, getHealth

signal noHp
signal loseHp
signal changeHp
signal NPCsaved

var NPCsavedCount = 0

func setHealth(newHealth):
	if debugGodmode == -1:
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
			global_scale.x = 0.5
			global_scale.y = 0.5
			newAnim = "Onion_JumpUp"
		fall:
			global_scale.x = 0.5
			global_scale.y = 0.5
			newAnim = "Onion_JumpDown"
			
		climb:
			global_scale.x = 0.5
			global_scale.y = 0.5
			#cimb anim?
			newAnim = "Onion_Idle"
		dead:
			#death anim
			rotation_degrees = 90
			$AnimationPlayer.stop()

func _ready():
	setState(idle)
	health = global.maxHealth
	global.currLevelId = int(get_parent().name)
	


func _physics_process(delta):
	if state != dead:
		
		if Input.is_action_just_pressed("debugFly"):
			if debugFly == -1:
				print("fly ON")
				$CollisionShape2D.disabled = true
				setState(climb)
				climbspeed *= 2
				movespeed *= 2
			else:
				print("fly OFF")
				$CollisionShape2D.disabled = false
				setState(fall)
				climbspeed /= 2
				movespeed /= 2
			debugFly *= -1
		
		if Input.is_action_just_pressed("debugGodmode"):
			if debugGodmode == -1:
				print("Godmode ON")
			else:
				print("Godmode OFF")
			debugGodmode *= -1
			
		
		ghostjumpTimeframe = max(ghostjumpTimeframe - delta, 0)
		if newAnim != anim:
			anim = newAnim
			$AnimationPlayer.play(anim)
		if state != climb:
			rayUpdate()
			motion.y += gravity
			if abs(rotation_degrees) > 3:
				rotation_degrees = lerp(rotation_degrees, 0, delta*3)
				global_scale.x = 0.5
				global_scale.y = 0.5
			else:
				rotation_degrees = 0
		elif state == climb:
			if rope != null:
				var transf = get_global_transform()
				attachTo(rope)
				set_global_transform(transf)
				rope = null
			if Input.is_action_pressed("ui_up"):
				motion.y = -climbspeed
			elif Input.is_action_pressed("ui_down"):
				motion.y = climbspeed
			else:
				motion.y = 0
		
		if Input.is_action_pressed("ui_right"):
			if is_on_floor():
				ghostjumpTimeframe = maxGhostjumpDelay
			motion.x = movespeed
			$Sprite.scale.x = 1	
			if is_on_floor() && state != climb:
				setState(run)
		elif Input.is_action_pressed("ui_left"):
			if is_on_floor():
				ghostjumpTimeframe = maxGhostjumpDelay
			motion.x = -movespeed
			$Sprite.scale.x = -1
			if is_on_floor() && state != climb:
				setState(run)
		else:	
			motion.x = 0
		
		if  ghostjumpTimeframe!= 0:
			if Input.is_action_just_pressed("jump"):
				motion.y = -jumpheight
				ghostjumpTimeframe = 0
		
		if ray.is_colliding() && global_position.distance_to(ray.get_collision_point()) <= 30 && abs(motion.y) <= 70:
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
		global_scale.x = 0.5
		global_scale.y = 0.5