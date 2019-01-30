extends Node2D

#the visible enemy object with collider etc
onready var enemy = $EnemyPath/Enemy

#variable for moving
onready var i = 0

export (bool)var moth = false

export (float) var movespeed = 2
export (bool) var pathLooped = true


onready var pathfollow = $EnemyPath/PathFollow2D

onready var muddySound = $EnemyPath/Enemy/muddySound

func _ready():
	add_to_group("Enemies")
	if moth == true:
		$EnemyPath/Enemy/mothSound.playing = true
	
#used this because godot doesn't allow overwriting _process()
func _physics_process(delta):
	_unique_process(delta)

func _unique_process(delta):
	if muddySound != null:
		if moth == false && $EnemyPath/Enemy/muddySound.playing == false:
			$EnemyPath/Enemy/muddySound.playRandomPitch()
	i += delta*movespeed
	#move from a to b and then b to a if path isnt a loop
	if pathLooped == false:
		if i >= 20*PI:
			i = 0
		pathfollow.unit_offset = acos(cos(i)) / acos(cos(PI))
	#move from a to a if on a closed path
	elif pathLooped == true:
		if i >= 20:
			i = 0
		pathfollow.unit_offset = i
	enemy.global_position = pathfollow.global_position

func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		body.loseHp()


