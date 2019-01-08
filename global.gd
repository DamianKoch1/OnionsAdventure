extends Node

#level the player is in
var currLevelId = 0


enum{easy, normal, hard}
var diff = normal

#was new game clicked?
var newGame = false

var maxHealth = 3

#object variables needed from start, assigned by their own scripts onready
var player
var spawnpoint

#volume slider values
var masterVol
var musicVol
var sfxVol