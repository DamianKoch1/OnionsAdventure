extends KinematicBody2D

const UP = Vector2(0, -1)
var motion = Vector2()

var anim = idle setget setAnim, getAnim
var oldAnim

var state = idle setget setState, getState
enum {idle, run, jump, fall, climb, dead}

#node to attach to if airborne
onready var worldNode = get_parent()

#ray that finds downward object to attach to (movingplatforms etc)
onready var ray = $RayCast2D

#can jump for short time if walking off cliffs
onready var ghostjumpTimeframe = 0
export var maxGhostjumpDelay = 0.2

export var movespeed = 250
export var gravity = 20
export var jumpheight = 550
export var climbspeed = 200

onready var debugGodmode = -1
onready var debugFly = -1

#has grace period (invincibility) after getting hit
onready var gracePeriodTimer = 0
export var gracePeriod = 2

#rope player attaches to if climbing on it
var rope


#signals other objects react to
signal loseHp
signal NPCsaved

var NPCsavedCount = 0


func _ready():
	MenuMusic.playing = false
	setState(idle)
	
	#will use better solution later
	if get_parent() != get_tree().get_root():
		global.currLevelId = int(get_parent().get_parent().name)
		
	if SaveGame.loadPlayerState == true:
		SaveGame.loadPlayerState = false
		NPCsavedCount = SaveGame.NPCsavedCount
		global_position.x = SaveGame.playerPosX
		global_position.y = SaveGame.playerPosY

func _physics_process(delta):
	if state != dead:
		#reducing cooldowns
		gracePeriodTimer = max(gracePeriodTimer - delta, 0)
		ghostjumpTimeframe = max(ghostjumpTimeframe - delta, 0)
		
		#debug fly and godmode
		if Input.is_action_just_pressed("debugFly"):
			if debugFly == -1:
				print("Fly ON")
				motion.y = 0
				setState(climb)
				$CollisionShape2D.disabled = true
				climbspeed *= 2.5
				movespeed *= 4
			else:
				print("Fly OFF")
				$CollisionShape2D.disabled = false
				setState(idle)
				climbspeed /= 2.5
				movespeed /= 4
			debugFly *= -1
		if Input.is_action_just_pressed("debugGodmode"):
			if debugGodmode == -1:
				print("Godmode ON")
			else:
				print("Godmode OFF")
			debugGodmode *= -1
		
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
			
			#walking animation
			if state != jump:
				if Input.is_action_just_pressed("ui_right") || Input.is_action_just_pressed("ui_left"):
					setState(run)
			
			#jump
			if is_on_floor():
				if motion.x == 0:
					setState(idle)
				else:
					setState(run)
				if Input.is_action_just_pressed("jump"):
					$SFX/jump.playRandomPitch()
					motion.y = -jumpheight
					setState(jump)
			
			#falling animation
			if state == jump:
				if motion.y > 10:
					setState(fall)
		
		#climbing, attach to rope when climbing, var rope assigned by rope/ladder
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
				
		#movement(run, jump, idle, fall states)
		if Input.is_action_pressed("ui_right"):
			if is_on_floor():
				ghostjumpTimeframe = maxGhostjumpDelay
			motion.x = movespeed
			$Sprite.scale.x = 1	
		elif Input.is_action_pressed("ui_left"):
			if is_on_floor():
				ghostjumpTimeframe = maxGhostjumpDelay
			motion.x = -movespeed
			$Sprite.scale.x = -1
		else:	
			motion.x = 0
		
		#ghostjump
		if  ghostjumpTimeframe!= 0:
			if Input.is_action_just_pressed("jump"):
				$SFX/jump.playRandomPitch()
				motion.y = -jumpheight
				ghostjumpTimeframe = 0
				setState(jump)
		motion = move_and_slide(motion, UP)

func setState(newState):
	#set current animation on state changes, tried scale set to prevent scale glitches when attaching to rotated objects
	if state != dead:
		state = newState
		match state:
			idle:
				setAnim("Onion_Idle")
			run:
				setAnim("Onion_Walk")
				if $SFX/footstep.playing == false:
					$SFX/footstep.playRandomPitch()
			jump:
				global_scale.x = 0.5
				global_scale.y = 0.5
				setAnim("Onion_JumpUp")
			fall:
				global_scale.x = 0.5
				global_scale.y = 0.5
				setAnim("Onion_JumpDown")
				
			climb:
				global_scale.x = 0.5
				global_scale.y = 0.5
				#cimb anim?
				setAnim("Onion_Idle")
			dead:
				#death anim
				setAnim("Onion_Death")
				

func getState():
	return state

func setAnim(newAnim):
	#play current animation if changed
	if oldAnim != newAnim:
		oldAnim = newAnim
		anim = newAnim
		$AnimationPlayer.play(anim)

func getAnim():
	return anim

func bounce(bounceStr):
	motion.y = -bounceStr
	motion = move_and_slide(motion, UP)
	setState(jump)
	
func rayUpdate():
	#find object below, attach to it if close enough (smoothes movement on moving platforms)
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

#remove self from current parent, attach to new parent and keep transform
func attachTo(obj):
	if obj.get_class() != "KinematicBody2D":
		var transf = get_global_transform()
		get_parent().remove_child(self)
		obj.add_child(self)
		set_global_transform(transf)