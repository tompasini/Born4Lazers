extends KinematicBody2D


# Declare member variables here. Examples:
var velocity = Vector2(0,0)
var life = 50
var eyebes_direction = -1
var jump_direction = -1
const EYEBES = preload("res://Enemies/Eyebes.tscn")
const GRAVITY = 35

enum STATES {IDLE, JUMPING, DEAD}

var _state = STATES.IDLE

func _physics_process(delta):
	if(_state != STATES.DEAD):
		if(is_on_floor()):
			_state = STATES.IDLE
		else:
			_state = STATES.JUMPING
	
	velocity.y += GRAVITY
	if(_state == STATES.IDLE):
		$AnimatedSprite.play("idle")
	if(_state == STATES.JUMPING):
		$AnimatedSprite.play("jump")
	if(_state == STATES.DEAD):
		$AnimatedSprite.play("dead")
	velocity = move_and_slide(velocity, Vector2.UP)
	if(is_on_floor()):
		velocity.x = lerp(velocity.x, 0, 0.9)

func _on_Body_body_entered(body):
	if(body.name == 'LZer'):
		body.hurt()
	elif(body.name == 'Laser'):
		if(life):
			spawn_eyebes()			
			life -= GlobalVariables.laser_damage
			body.queue_free()
			$HitAura.visible = true
			$HitAuraTimer.start()
		if(!life):
			_state = STATES.DEAD
			remove_collisions()

func _on_HitAuraTimer_timeout():
	$HitAura.visible = false

func remove_collisions():
	$Body.set_collision_mask_bit(0, false)	
	$Body.set_collision_mask_bit(5, false)

func spawn_eyebes():
	var eyebes = EYEBES.instance()
	eyebes_direction = eyebes_direction * -1
	eyebes.direction = eyebes_direction
	get_parent().add_child(eyebes)
	eyebes.position.x = position.x
	eyebes.position.y = position.y

func jump():
	velocity.y = -600
	velocity.x = (600 * jump_direction)
	jump_direction = jump_direction * -1

func _on_AttackTimer_timeout():
	if(_state != STATES.DEAD):
		jump()
