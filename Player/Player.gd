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

onready var gracePeriodTimer = 0
export var gracePeriod = 2

var rope
var ropeAttachCD = 0

export var health = 3 setget setHealth, getHealth

signal noHp
signal loseHp
signal changeHp
signal NPCsaved

var NPCsavedCount = 0

#gets called if health value is changed
func setHealth(newHealth):
	if debugGodmode == -1 && gracePeriodTimer == 0:
		var oldHealth = health
		health = newHealth
		if newHealth != oldHealth:
			emit_signal("changeHp")
			if newHealth < oldHealth :
				gracePeriodTimer = gracePeriod
				emit_signal("loseHp")
		if health <= 0:
			setState(dead)
			get_tree().reload_current_scene()

func getHealth():
	return health

func setState(newState):
	#set current animation on state changes
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
			
			#dead code, level restarts on 0hp
			rotation_degrees = 90
			$AnimationPlayer.stop()

func _ready():
	global.player = self
	setState(idle)
	health = global.maxHealth
	global.currLevelId = int(get_parent().name)
	


func _physics_process(delta):
	if state != dead:
		gracePeriodTimer = max(gracePeriodTimer - delta, 0)
		ghostjumpTimeframe = max(ghostjumpTimeframe - delta, 0)
		#debug fly and godmode
		if Input.is_action_just_pressed("debugFly"):
			if debugFly == -1:
				print("Fly ON")
				motion.y = 0
				setState(climb)
				$CollisionShape2D.disabled = true
				climbspeed *= 2
				movespeed *= 2
			else:
				print("Fly OFF")
				$CollisionShape2D.disabled = false
				setState(idle)
				climbspeed /= 2
				movespeed /= 2
			debugFly *= -1
		if Input.is_action_just_pressed("debugGodmode"):
			if debugGodmode == -1:
				print("Godmode ON")
			else:
				print("Godmode OFF")
			debugGodmode *= -1
		
		#play current animation if changed
		if newAnim != anim:
			anim = newAnim
			$AnimationPlayer.play(anim)
		
		#attach to ground if not climbing, rotate to 0
		if state != climb:
			rayUpdate()
			motion.y += gravity
			if abs(rotation_degrees) > 3:
				rotation_degrees = lerp(rotation_degrees, 0, delta*3)
				global_scale.x = 0.5
				global_scale.y = 0.5
			else:
				rotation_degrees = 0
		#climbing
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
		
		#ovement(run, jump, idle, fall states)
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
		
		if is_on_floor() && motion.x == 0 && state != climb:
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
	#find object below, attach to it if close enough(smoothes movement on moving platforms)
	ray.force_raycast_update()
	if ray.is_colliding():
		var col = ray.get_collider()
		#add exception if obj is an Area2D
		if col.get_class() == "Area2D":
			ray.add_exception(col)
		else:
			if global_position.distance_to(ray.get_collision_point()) <= 30:
				attachTo(col)
			elif global_position.distance_to(ray.get_collision_point()) > 30:
				attachTo(worldNode)
	else:
		attachTo(worldNode)

#remove self from current parent, attach to new parent and keep transform
func attachTo(obj):
	if obj.get_class() != "KinematicBody2D":
		var transf = get_global_transform()
		get_parent().remove_child(self)
		obj.add_child(self)
		set_global_transform(transf)
		global_scale.x = 0.5
		global_scale.y = 0.5