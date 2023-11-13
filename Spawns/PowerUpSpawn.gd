extends Area2D

const HEALTH = preload("res://PowerUps/HealthPowerUp.tscn")
const DAMAGE = preload("res://PowerUps/DamagePowerUp.tscn")
const SPEED = preload("res://PowerUps/SpeedPowerUp.tscn")
const JUMP = preload("res://PowerUps/JumpPowerUp.tscn")
const POWERUPS = [HEALTH, DAMAGE, SPEED, JUMP]

func _ready():
	self.add_child_below_node($CollisionShape2D, random_powerup())



func _on_SpawnTimer_timeout():
	$AnimatedSprite.visible = true
	spawn()
	$AnimatedSprite.play("spawn")
	$SpawnTimer.start()

func spawn():
	if(self.get_child_count() == 4):
		self.remove_child(self.get_child(1))
	self.add_child_below_node($CollisionShape2D, random_powerup())
	
func random_powerup():
	return POWERUPS[randi() % POWERUPS.size()].instance()

func _on_AnimatedSprite_animation_finished():
	if($AnimatedSprite.animation == "spawn"):
		$AnimatedSprite.visible = false
		$AnimatedSprite.play("idle")
