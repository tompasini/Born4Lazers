extends Bat

const LASER = preload("res://Enemies/Lasers/Blue Laser.tscn")

func _ready():
	life = 45
	hit_animation = 'hit'

func _on_Area2D_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if(body.name == 'Laser'):
		$HitTimer.start()
		hit_by_laser(body)
			
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
