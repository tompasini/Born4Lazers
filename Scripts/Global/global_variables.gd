extends Node

var dmgPowerUps = 0
var fireRatePowerUps = 0
var laser_damage = 5
var score = 0
var currentWorld = "Red"

func _ready():
	pass
	
func update_score(value):
	score = value
