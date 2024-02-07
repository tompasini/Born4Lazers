extends Area2D

var spawns = 0
export var spawn_grounded = false
export var spawn_flyers = false
export var boss_spawn_threshold: int
const FLYING_ENEMIES = ["BlueBat", "RedBat"]
const GROUND_ENEMIES = ["Eyebes", "IceCube"]
const GROUND_BOSSES = ["KingEyebes"]
const FLYING_BOSSES = []
const directions = [-1, 1]
var valid_enemies = []
var valid_bosses = []

func _ready():
	get_enemies()
	spawn()
	
func spawn():
	if(spawns < boss_spawn_threshold):
		self.add_child_below_node($CollisionShape2D, random_enemy())
	else:
		spawns = 0
		if(boss_spawn_threshold > 0):
			boss_spawn_threshold -= 1
		self.add_child_below_node($CollisionShape2D, random_boss())
	spawns += 1
	$SpawnTimer.start()

func random_enemy():
	var enemy = load("res://Enemies/" + valid_enemies[randi() % valid_enemies.size()] + ".tscn").instance()
	if("direction" in enemy):
		enemy.direction = directions[randi() % directions.size()]
	return enemy

func random_boss():
	return load("res://Bosses/" + valid_bosses[randi() % valid_bosses.size()] + ".tscn").instance()
	
func get_enemies():
	valid_enemies = ["Eyebes"]
	valid_bosses = ["KingEyebes"]
#	if(spawn_grounded):
#		valid_enemies += GROUND_ENEMIES
#		valid_bosses += GROUND_BOSSES
#	if(spawn_flyers):
#		valid_enemies += FLYING_ENEMIES
#		valid_bosses += FLYING_BOSSES

func _on_SpawnTimer_timeout():
	spawn()
