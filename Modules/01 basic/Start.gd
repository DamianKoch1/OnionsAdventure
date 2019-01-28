extends Node2D

func _ready():
	$Camera.player = $Onion
	$Camera.connectSignals()