extends KinematicBody2D

var velocity = Vector2()

var player_position = Vector2(0, 0)

var attack_speed = 175

var life = 15

enum STATES {UP, DOWN, IDLE, ATTACK}

var _state : int = STATES.UP

func _ready():
	pass

func _physics_process(delta):
	if(_state != STATES.ATTACK):
		bob()
		move_and_slide(velocity)
	else:
		attack(delta)
		
	if(position == player_position):
		_state = STATES.UP


func bob():
	if($Timer.is_stopped()):
		if(_state == STATES.UP):
			_state = STATES.DOWN
		elif(_state == STATES.DOWN):
			_state = STATES.UP
		$Timer.start()
	if(_state == STATES.UP):
		if(velocity.y > 0):
			velocity.y = lerp(velocity.y, 0, 1.0)
		velocity.y -= 0.15
	elif(_state == STATES.DOWN):
		if(velocity.y < 0):
			velocity.y = lerp(velocity.y, 0, 1.0)
		velocity.y += 0.15

func attack(delta):
	position = position.move_toward(player_position, delta * attack_speed)

func _on_Area2D_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	_state = STATES.ATTACK
	player_position = Vector2(body.position.x, body.position.y)


func _on_Body_body_entered(body):
	if(body.name == 'LZer'):
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
	set_collision_layer_bit(4, false)
	set_collision_mask_bit(0, false)
	$Body.set_collision_mask_bit(5, false)
	$Body.set_collision_mask_bit(0, false)


func _on_HitTimer_timeout():
	$AnimatedSprite.play("flap")
