extends KinematicBody2D

var velocity = Vector2(0,0)
var life = 30
var speed = 200
export var direction = 1

func _ready():
	if(direction == 1):
		$AnimatedSprite.flip_h = true
	$FloorChecker.position.x = $CollisionShape2D.shape.extents.x * direction
	
func _physics_process(delta):
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

func _on_Body_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if(body.name == 'Laser'):
		body.queue_free()
		if(life):
			$AnimatedSprite.play('hit')
			life -= GlobalVariables.laser_damage
			$HitTimer.start()
		if(!life):
			remove_collisions()	
			queue_free()
