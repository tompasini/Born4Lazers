extends Area2D

const HEALTH = preload("res://PowerUps/HealthPowerUp.tscn")
const DAMAGE = preload("res://PowerUps/DamagePowerUp.tscn")

func _ready():
	self.add_child_below_node($CollisionShape2D, HEALTH.instance())



func _on_SpawnTimer_timeout():
	$AnimatedSprite.visible = true
	spawn()
	$AnimatedSprite.play("spawn")

func spawn():
	if(self.get_child_count() == 4):
		self.remove_child(self.get_child(1))
	self.add_child_below_node($CollisionShape2D, DAMAGE.instance())


func _on_AnimatedSprite_animation_finished():
	if($AnimatedSprite.animation == "spawn"):
		$AnimatedSprite.visible = false
		$AnimatedSprite.play("idle")
