extends KinematicBody2D

var velocity = Vector2()
export var direction = -1
export var detects_cliffs = true
var speed = 50
var life = 10

func _ready():
	if(direction == 1):
		$AnimatedSprite.flip_h = true
	$FloorChecker.position.x = $CollisionShape2D.shape.get_radius() * direction
	$FloorChecker.enabled = detects_cliffs	

func  _physics_process(delta):
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
	queue_free()
	


func _on_AnimatedSprite_animation_finished():
	if($AnimatedSprite.animation == 'hit' && life):
		$AnimatedSprite.play('walk')
		
func remove_collisions():
	set_collision_layer_bit(4, false)
	set_collision_mask_bit(0, false)
	$TopChecker.set_collision_layer_bit(4, false)
	$TopChecker.set_collision_mask_bit(0, false)
	$Sides.set_collision_layer_bit(4, false)
	$Sides.set_collision_mask_bit(0, false)

func hit_by_laser(body):
	if(life):
		$AnimatedSprite.play('hit')
		body.queue_free()
		life -= GlobalVariables.laser_damage
	if(!life):
		remove_collisions()	
		$AnimatedSprite.play('fall')
		speed = 0		
		$Timer.start()
