extends KinematicBody2D

var velocity = Vector2(0, 0)
var damage = 5
var alive = true
var finished = false
var direction = 1
var oldDirection = 1
var speedMultiplier = 1
const SPEED = 90
const JUMPFORCE = -550
const GRAVITY = 35
const LASER = preload("res://Laser.tscn")

signal finished_level

enum STATES {ON_GROUND, JUMPING, ON_WALL_IN_AIR, ON_GROUND_TOUCHING_WALL}

var _state = STATES.ON_GROUND

func _physics_process(delta):
	if(alive && !finished):
		if((is_on_floor()) && bottomColliding() && !sidesColliding() && !is_on_wall()):
			_state = STATES.ON_GROUND
		if(is_on_floor() && bottomColliding() && sidesColliding() && is_on_wall()):
			_state = STATES.ON_GROUND_TOUCHING_WALL
		if(!bottomColliding() && sidesColliding() && is_on_wall()):
			_state = STATES.ON_WALL_IN_AIR
		if(!is_on_floor() && (!is_on_wall() && !sidesColliding())):
			_state = STATES.JUMPING
			
		if (Input.is_action_pressed("right")):
			direction = 1
			if(_state != STATES.ON_WALL_IN_AIR || is_on_floor()):
				$AnimatedSprite.flip_h = false				
				if(Input.is_action_pressed("run")):
					speedMultiplier = 2
				else:
					speedMultiplier = 1
				velocity.x = (SPEED * speedMultiplier)
				move()
		elif(Input.is_action_pressed("left")):
			direction = -1
			if(_state != STATES.ON_WALL_IN_AIR || is_on_floor()):
				$AnimatedSprite.flip_h = true				
				if(Input.is_action_pressed("run")):
					speedMultiplier = 2
				else:
					speedMultiplier = 1
				velocity.x = (-SPEED * speedMultiplier)
				move()
		else:
			$AnimatedSprite.play('idle')	
		
		if(_state == STATES.JUMPING):
			$AnimatedSprite.play('jump')
			if(velocity.y == 0):
				_state = STATES.ON_GROUND
			
		if(Input.is_action_just_pressed("shoot")):
			shoot()
		
		if(_state != STATES.ON_WALL_IN_AIR):
			velocity.y += GRAVITY
		else:
			$AnimatedSprite.flip_h = false
			if($LeftSide.is_colliding()):
				$AnimatedSprite.play("left_wall")
			elif($RightSide.is_colliding()):
				$AnimatedSprite.play("right_wall")
			if(Input.is_action_pressed("slide_down")):
				velocity.y = 180
			else:
				velocity.y = 0
				velocity.y += 10
		
		if(((Input.is_action_just_pressed("jump") && (_state != STATES.JUMPING && _state != STATES.ON_WALL_IN_AIR)) || valid_wall_jump())):
			jump()

		velocity = move_and_slide(velocity, Vector2.UP)
		
		if(_state == STATES.ON_GROUND || _state == STATES.ON_GROUND_TOUCHING_WALL):
			velocity.x = lerp(velocity.x, 0, 0.9)
			

func valid_wall_jump():
	return (Input.is_action_just_pressed("jump") && ((Input.is_action_pressed("right") && $LeftSide.is_colliding()) || (Input.is_action_pressed("left") && $RightSide.is_colliding())))

func _on_FallZone_body_entered(body):
	if(body.name == "LZer"):
		get_tree().reload_current_scene()

func bounce():
	velocity.y = JUMPFORCE * 0.5


func hurt():
	alive = false
	Input.action_release('left')
	Input.action_release('right')
	remove_collisions()
	$AnimatedSprite.play('dead')
	
func shoot():
	var l = LASER.instance()
	if($AnimatedSprite.flip_h):
		l.direction = -1
	get_parent().add_child(l)
	l.position.y = position.y - 7
	l.position.x = position.x + 18
	
func move():
	if(speedMultiplier == 1):
		$AnimatedSprite.play("walk")
	else:
		$AnimatedSprite.play("run")

func jump():
	if(speedMultiplier == 1 && bottomColliding()):
		velocity.y = JUMPFORCE
	elif(sidesColliding() && !bottomOrTopColliding()):
		velocity.y = -600
		velocity.x += (600 * direction)		
	else:
		velocity.y = -700
		velocity.x += (700 * direction)
			
func sidesColliding():
	return $LeftSide.is_colliding() || $RightSide.is_colliding()
	
func topColliding():
	return $Top.is_colliding()

func bottomColliding():
	return $Bottom.is_colliding()
	
func bottomOrTopColliding():
	return topColliding() || bottomColliding()

func _on_Timer_timeout():
	get_tree().reload_current_scene()


func _on_AnimatedSprite_animation_finished():
	if($AnimatedSprite.animation == "dead"):
		$Timer.start()
	elif($AnimatedSprite.animation == "finished"):
		SceneManager.next_level(GlobalVariables.currentWorld)

func remove_collisions():
	set_collision_layer_bit(0, false)
	set_collision_mask_bit(4, false)
	$LeftSide.enabled = false
	$RightSide.enabled = false
	$Bottom.enabled = false
	$Top.enabled = false
