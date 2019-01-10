extends Node

#level the player is in
var currLevelId = 0


enum{easy, normal, hard}
var diff = normal


var maxHealth = 3

#object variables needed from start, assigned by their own scripts onready
var player
var spawnpoint

#volume slider values
var masterVol
var musicVol
var sfxVol