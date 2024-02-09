extends Enemy

func _ready():
	speed = 50
	life = 10
	hit_animation = 'hit'
	death_animation = 'fall'
	if(direction == 1):
		$AnimatedSprite.flip_h = true
	$FloorChecker.position.x = $CollisionShape2D.shape.get_radius() * direction
	$FloorChecker.enabled = detects_cliffs	

func  _physics_process(_delta):
	if(is_on_wall() || (!$FloorChecker.is_colliding() && detects_cliffs && is_on_floor())):
		direction *= -1
		$AnimatedSprite.flip_h = !$AnimatedSprite.flip_h
		$FloorChecker.position.x = $CollisionShape2D.shape.get_radius() * direction
	velocity.y += 20
	
	velocity.x = speed * direction
	
	velocity = move_and_slide(velocity, Vector2.UP)


func _on_TopChecker_body_entered(body):
	if(body.name == 'LZer'):
		$AnimatedSprite.play('squished')
		speed = 0
		remove_collisions()
		$Timer.start()
		body.bounce()
	elif(body.name == 'Laser'):
		hit_by_laser(body)

func _on_Sides_body_entered(body):
	if(body.name == 'LZer'):
		body.hurt()
	elif(body.name == 'Laser'):
		hit_by_laser(body)

func _on_Timer_timeout():
	call_deferred("queue_free")

func _on_AnimatedSprite_animation_finished():
	if($AnimatedSprite.animation == 'hit' && life):
		$AnimatedSprite.play('walk')
		
func remove_collisions():
	call_deferred('set_collision_layer_bit', 4, false)
	call_deferred('set_collision_mask_bit', 0, false)	
	$TopChecker.call_deferred('set_collision_layer_bit', 4, false)
	$TopChecker.call_deferred('set_collision_mask_bit', 0, false)
	$Sides.call_deferred('set_collision_layer_bit', 4, false)
	$Sides.call_deferred('set_collision_mask_bit', 0, false)

func die():
	$Timer.start()
