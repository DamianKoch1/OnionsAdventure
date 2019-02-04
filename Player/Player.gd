extends KinematicBody2D

const UP = Vector2(0, -1)
var motion = Vector2()

onready var sprite = $Onion
onready var anim = $Onion/AnimationPlayer
onready var animTreePlayer = $Onion/AnimationTreePlayer1

var state = idle setget setState
enum {idle, run, jump, fall, climb, frozen}

#origin node to attach to if airborne
onready var worldNode = get_parent()

#ray that finds object below to attach to (movingplatforms etc)
onready var ray = $RayCast2D

#can jump for short time after walking off cliffs
onready var ghostjumpTimeframe = 0
export var maxGhostjumpDelay = 0.2

export var movespeed = 250
export var gravity = 20
export var jumpheight = 550
export var climbspeed = 200

#determines if fall particles should play when landing
onready var highestFallSpeed = 0
export var fallVFXspeedThreshhold = 700

onready var debugFly = false
onready var debugGodmode = false

#rope player attaches to if climbing on it
var rope

signal loseHp
signal NPCsaved
signal collectedDandelion

func _ready():
	MenuMusic.playing = false
	setState(idle)
	if SaveGame.loadPlayerState == true:
		SaveGame.loadPlayerState = false
		global_position.x = SaveGame.playerPosX
		global_position.y = SaveGame.playerPosY

func _physics_process(delta):
	if state != frozen:
		ghostjumpTimeframe = max(ghostjumpTimeframe - delta, 0)
		#debug fly and godmode
		if Input.is_action_just_pressed("debugFly"):
			if debugFly == false:
				print("Fly ON")
				motion.y = 0
				setState(climb)
				$CollisionShape2D.disabled = true
				climbspeed *= 2.5
				movespeed *= 4
				debugFly = true
			else:
				print("Fly OFF")
				$CollisionShape2D.disabled = false
				setState(idle)
				climbspeed /= 2.5
				movespeed /= 4
				debugFly = false
		if Input.is_action_just_pressed("debugGodmode"):
			if debugGodmode == false:
				print("Invincible ON")
				debugGodmode = true
			else:
				print("Invincible OFF")
				debugGodmode = false
		#attach to ground if not climbing, rotate to 0
		if state != climb:
			rayUpdate()
			motion.y += gravity
			trackFallSpeed()
			if abs(rotation_degrees) > 3:
				rotation_degrees = lerp(rotation_degrees, 0, delta*3)
				global_scale.x = 0.5
				global_scale.y = 0.5
			else:
				rotation_degrees = 0
			if is_on_floor():
				if motion.x == 0:
					setState(idle)
				else:
					setState(run)
				#jump
				if Input.is_action_just_pressed("jump"):
					jump(jumpheight)
			else:
				if motion.y >= 100:
					if state == run || state == idle:
						setState(fall)
			#fall
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
		#movement
		if Input.is_action_pressed("ui_right"):
			if is_on_floor():
				ghostjumpTimeframe = maxGhostjumpDelay
			motion.x = movespeed
			sprite.scale.x = 1	
		elif Input.is_action_pressed("ui_left"):
			if is_on_floor():
				ghostjumpTimeframe = maxGhostjumpDelay
			motion.x = -movespeed
			sprite.scale.x = -1
		else:	
			motion.x = 0
		#ghostjump
		if  ghostjumpTimeframe != 0:
			if Input.is_action_just_pressed("jump"):
				ghostjumpTimeframe = 0
				jump(jumpheight)
		motion = move_and_slide(motion, UP)
	else:
		#if frozen, finish jump if in air and freeze x motion
		motion.x = 0
		motion.y += gravity
		motion = move_and_slide(motion, UP)

#used to unfreeze player without setState from other scripts (trappedNPC)
func setIdle():
	state = idle

func setState(newState):
	#play animations on state changes, tried scale set to prevent scale glitches when attaching to rotated/scaled objects
	global_scale.x = 0.5
	global_scale.y = 0.5
	if state != frozen:
		if state == fall && highestFallSpeed >= fallVFXspeedThreshhold:
			if newState == run || newState == idle:
				$landingTest.emitting = true
				highestFallSpeed = 0
		state = newState
		match state:
			idle:
				animTreePlayer.oneshot_node_stop("fallOneshot")
				animTreePlayer.transition_node_set_current("idle/walk", 0)
			run:
				animTreePlayer.oneshot_node_stop("fallOneshot")
				animTreePlayer.transition_node_set_current("idle/walk", 1)
				if $SFX/footstep.playing == false:
					$SFX/footstep.playRandomPitch()
			jump:
				animTreePlayer.oneshot_node_stop("fallOneshot")
				animTreePlayer.oneshot_node_start("jumpOneshot")
			fall:
				animTreePlayer.oneshot_node_stop("jumpOneshot")
				animTreePlayer.oneshot_node_start("fallOneshot")
			climb:
				highestFallSpeed = 0
				#cimb anim?
				animTreePlayer.oneshot_node_stop("jumpOneshot")
				animTreePlayer.oneshot_node_stop("fallOneshot")
				animTreePlayer.transition_node_set_current("idle/walk", 0)
			frozen:
				highestFallSpeed = 0
				animTreePlayer.oneshot_node_stop("jumpOneshot")
				animTreePlayer.oneshot_node_stop("fallOneshot")
				animTreePlayer.transition_node_set_current("idle/walk", 0)

func loseHp():
	if state != frozen && debugGodmode != true:
		$SFX/hurt.playing = true
		#blinking? modulating alpha turns black in animationTreePlayer...
		emit_signal("loseHp", self)
		setState(idle)
		motion.x = 0
		motion.y = 0

#no sound, used for uncontrolled jumps (krakenmushroom)
func bounce(bounceStr):
	motion.y = -bounceStr
	motion = move_and_slide(motion, UP)
	setState(jump)

#sound, for controlled jumps using space
func jump(strength):
	$SFX/jump.playRandomPitch()
	motion.y = -strength
	setState(jump)

#find object below, attach to it if close enough (smoothes movement on moving platforms)
func rayUpdate():
	ray.force_raycast_update()
	if ray.is_colliding():
		var col = ray.get_collider()
		if col.is_in_group("rayIgnore") || col.get_class() == "Area2D":
			ray.add_exception(col)
		else:
			if global_position.distance_to(ray.get_collision_point()) <= 30:
				attachTo(col)
			elif global_position.distance_to(ray.get_collision_point()) > 30:
				attachTo(worldNode)
	else:
		attachTo(worldNode)

#track highest fall speed, fall vfx plays on landing if high enough
func trackFallSpeed():
	if motion.y > highestFallSpeed:
		highestFallSpeed = motion.y

#remove self from current parent, attach to new parent and keep transform
func attachTo(obj):
	if obj.get_class() != "KinematicBody2D":
		var transf = get_global_transform()
		get_parent().remove_child(self)
		obj.add_child(self)
		set_global_transform(transf)
		global_scale.x = 0.5
		global_scale.y = 0.5