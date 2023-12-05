extends KinematicBody2D

var velocity = Vector2(0,0)
var life = 30
var speed = 200
export var direction = 1

func _ready():
	if(direction == 1):
		$AnimatedSprite.flip_h = true
	$FloorChecker.position.x = ($CollisionShape2D.shape.extents.x) * direction
	
func _physics_process(delta):
	if(is_on_wall()):
		direction *= -1
		$AnimatedSprite.flip_h = !$AnimatedSprite.flip_h
		$FloorChecker.position.x = $CollisionShape2D.shape.extents.x * direction
	
	velocity.y += 20
	
	velocity.x = speed * direction
	
	velocity = move_and_slide(velocity, Vector2.UP)


func _on_Body_body_entered(body):
	if(body.name == "LZer"):
		body.hurt()
	elif(body.name == 'Laser'):
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
	$Body.set_collision_layer_bit(4, false)
	$Body.set_collision_mask_bit(0, false)
	$Body.set_collision_mask_bit(5, false)

func _on_HitTimer_timeout():
	$AnimatedSprite.play("idle")
