extends KinematicBody2D

var velocity = Vector2(0, 0)
const SPEED = 180
const JUMPFORCE = -550
const GRAVITY = 35

func _physics_process(delta):
	if (Input.is_action_pressed("right")):
		velocity.x = SPEED
		$AnimatedSprite.flip_h = false		
		$AnimatedSprite.play('run')
	elif(Input.is_action_pressed("left")):
		velocity.x = -SPEED
		$AnimatedSprite.flip_h = true
		$AnimatedSprite.play('run')		
	else:
		$AnimatedSprite.play('idle')	
	
	if not is_on_floor():
		$AnimatedSprite.play('jump')	
	
	velocity.y += GRAVITY

	if(Input.is_action_just_pressed("jump") and is_on_floor()):
		velocity.y = JUMPFORCE

	velocity = move_and_slide(velocity, Vector2.UP)
	
	velocity.x = lerp(velocity.x, 0, 0.2)


func _on_FallZone_body_entered(body):
	get_tree().reload_current_scene()
