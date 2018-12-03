extends Node

#level the player is in
var currLevelId = 0

var diff
enum{easy, normal, hard}


var maxHealth = 3

#object variables needed from start, assigned by their own scripts onready
var player
var spawnpoint