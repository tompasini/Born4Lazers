extends RigidBody2D

var life = 45
const LASER = preload("res://Enemies/Lasers/Blue Laser.tscn")
export var direction = -1

func _on_Area2D_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if(body.name == 'Laser'):
		if(life):
			$AnimatedSprite.play('hit')
			body.queue_free()
			life -= GlobalVariables.laser_damage
			$HitTimer.start()
		if(!life):
			remove_collisions()	
			queue_free()
			
func remove_collisions():
	set_collision_mask_bit(1, false)
	$Area2D.set_collision_mask_bit(5, false)
	$Area2D.set_collision_layer_bit(8, false)
	
func _on_HitTimer_timeout():
	$AnimatedSprite.play("flap")

func shoot():
	var l = LASER.instance()
	get_parent().add_child(l)
	l.direction = direction
	l.position.y = position.y - 7
	l.position.x = position.x + 18


func _on_LaserTimer_timeout():
	shoot()
