extends KinematicBody2D


# Declare member variables here. Examples:
var life = 50


func _on_Body_body_entered(body):
	if(body.name == 'LZer'):
		body.hurt()
	elif(body.name == 'Laser'):
		if(life):
			life -= GlobalVariables.laser_damage
			body.queue_free()
			$HitAura.visible = true
			$HitAuraTimer.start()
		if(!life):
			$AnimatedSprite.play("dead")
			remove_collisions()

func _on_HitAuraTimer_timeout():
	$HitAura.visible = false

func remove_collisions():
	$Body.set_collision_mask_bit(0, false)	
	$Body.set_collision_mask_bit(5, false)
