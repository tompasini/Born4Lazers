extends Enemy

func _ready():
	life = 60
	speed = 200
	hit_animation = 'hit'
	if(direction == 1):
		$AnimatedSprite.flip_h = true
	$FloorChecker.position.x = $CollisionShape2D.shape.extents.x * direction
	
func _physics_process(_delta):
	if(is_on_wall() || (!$FloorChecker.is_colliding()) && is_on_floor()):
		direction *= -1
		$AnimatedSprite.flip_h = !$AnimatedSprite.flip_h
		$FloorChecker.position.x = $CollisionShape2D.shape.extents.x * direction
	
	velocity.y += 20
	
	velocity.x = speed * direction
	
	velocity = move_and_slide(velocity, Vector2.UP)


func _on_Body_body_entered(body):
	if(body.name == "LZer"):
		body.hurt()

func remove_collisions():
	set_collision_mask_bit(1, false)
	$Body.set_collision_layer_bit(4, false)
	$Body.set_collision_mask_bit(0, false)
	$Body.set_collision_mask_bit(5, false)

func _on_HitTimer_timeout():
	$AnimatedSprite.play("idle")

func _on_Body_body_shape_entered(_body_rid, body, _body_shape_index, _local_shape_index):
	if(body.name == 'Laser'):
		$HitTimer.start()
		hit_by_laser(body)
		
func die():
	call_deferred("queue_free")
