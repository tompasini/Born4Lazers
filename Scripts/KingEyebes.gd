extends KinematicBody2D

const DIRECTIONS = [-1, 1]
const ACTIONS = [1, 2]
var velocity = Vector2(0,0)
var life = 200
var eyebes_direction = -1
var jump_direction
var dash_direction
var action
var has_dashed = false
const EYEBES = preload("res://Enemies/Eyebes.tscn")
const GRAVITY = 35

enum STATES {IDLE, JUMPING, DASHING, DEAD}

var _state = STATES.IDLE

func _ready():
	jump_direction = random_direction()
	dash_direction = random_direction()
	action = ACTIONS[randi() % ACTIONS.size()]
	$AttackTimer.start()

func _physics_process(_delta):
	if(_state != STATES.DEAD):
		if(is_on_floor() && velocity.x == 0):
			_state = STATES.IDLE
		elif(is_on_floor() && velocity.x != 0):
			_state = STATES.DASHING
		else:
			_state = STATES.JUMPING
	
	velocity.y += GRAVITY
	if(_state == STATES.IDLE):
		$AnimatedSprite.play("idle")
	if(_state == STATES.JUMPING):
		$AnimatedSprite.play("jump")
	if(_state == STATES.DASHING):
		if(dash_direction == 1):
			$AnimatedSprite.play("dash_right")
		else:
			$AnimatedSprite.play("dash_left")
	if(_state == STATES.DEAD):
		$AnimatedSprite.play("dead")
		GlobalVariables.score += 200
		queue_free()
	velocity = move_and_slide(velocity, Vector2.UP)
	if(is_on_wall() && _state != STATES.DASHING):
		velocity.x = 0

func _on_Body_body_entered(body):
	if(body.name == 'LZer'):
		body.hurt()
	elif(body.name == 'Laser'):
		if(life >= GlobalVariables.laser_damage):
			call_deferred('spawn_eyebes')
			life -= GlobalVariables.laser_damage
			body.queue_free()
			$HitAura.visible = true
			$HitAuraTimer.start()
		if(!life || life <= GlobalVariables.laser_damage):
			_state = STATES.DEAD
			remove_collisions()
			$HitAura.visible = false

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
	velocity.y = -750
	velocity.x = (750 * jump_direction)
	if(has_dashed):
		dash_direction = random_direction()
	if(dash_direction == 1):
		jump_direction = random_direction()
	else:
		jump_direction = random_direction()
	action = 2

func dash():
	velocity.x = (700 * dash_direction)
	action = 1
	
func random_direction():
	return DIRECTIONS[randi() % DIRECTIONS.size()]

func _on_AttackTimer_timeout():
	if(_state != STATES.DEAD):
		match action:
			1:
				jump()
			2:
				dash()
				if(!has_dashed):
					has_dashed = true
