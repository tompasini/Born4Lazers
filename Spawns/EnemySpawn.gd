extends Area2D

var spawns = 0
export var spawn_flyers = false
export var spawn_bosses = false
const FLYING_ENEMIES = ["BlueBat", "RedBat"]
const GROUND_ENEMIES = ["Eyebes", "IceCube"]
const BOSSES = ["KingEybes"]
const directions = [-1, 1]

func _ready():
	spawn()
	
func spawn():
	self.add_child_below_node($CollisionShape2D, random_enemy())
	$SpawnTimer.start()

func random_enemy():
	var enemy = load("res://Enemies/" + GROUND_ENEMIES[randi() % GROUND_ENEMIES.size()] + ".tscn").instance()
	if("direction" in enemy):
		enemy.direction = directions[randi() % directions.size()]
	return enemy

func random_boss():
	pass


func _on_SpawnTimer_timeout():
	spawn()
