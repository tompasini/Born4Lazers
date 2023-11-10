extends KinematicBody2D

var velocity = Vector2(0, 0)
var damage = 5
var alive = true
var finished = false
var direction = 1
var oldDirection = 1
var speedMultiplier = 1
var health = 15
var maxHealth = 15
var hit = false
var speed = 90
var maxSpeed = 300
var maxJumps = 1
var jumpCount = 0
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
			
		if(_state != STATES.JUMPING):
			jumpCount = 0
			
		if (Input.is_action_pressed("right")):
			direction = 1
			if(_state != STATES.ON_WALL_IN_AIR || is_on_floor()):
				$AnimatedSprite.flip_h = false				
				if(Input.is_action_pressed("run")):
					speedMultiplier = 2
				else:
					speedMultiplier = 1
				velocity.x = (speed * speedMultiplier)
				move()
		elif(Input.is_action_pressed("left")):
			direction = -1
			if(_state != STATES.ON_WALL_IN_AIR || is_on_floor()):
				$AnimatedSprite.flip_h = true				
				if(Input.is_action_pressed("run")):
					speedMultiplier = 2
				else:
					speedMultiplier = 1
				velocity.x = (-speed * speedMultiplier)
				move()
		else:
			if(!hit):
				$AnimatedSprite.play("idle")
			else:
				$AnimatedSprite.play("hit")
		
		if(_state == STATES.JUMPING):
			if(!hit):
				$AnimatedSprite.play("jump")
			else:
				$AnimatedSprite.play("jump_hit")
			if(velocity.y == 0):
				_state = STATES.ON_GROUND
			
		if(Input.is_action_pressed("shoot")):
			shoot()
		
		if(_state != STATES.ON_WALL_IN_AIR):
			velocity.y += GRAVITY
		else:
			$AnimatedSprite.flip_h = false
			if($LeftSide.is_colliding()):
				if(!hit):
					$AnimatedSprite.play("left_wall")
				else:
					$AnimatedSprite.play("left_wall_hit")
			elif($RightSide.is_colliding()):
				if(!hit):
					$AnimatedSprite.play("right_wall")
				else:
					$AnimatedSprite.play("right_wall_hit")
			if(Input.is_action_pressed("slide_down")):
				velocity.y = 180
			else:
				velocity.y = 0
				velocity.y += 10
		
		if(((Input.is_action_just_pressed("jump") && (_state != STATES.ON_WALL_IN_AIR)) || valid_wall_jump())):
			if(jumpCount < maxJumps):
				jump()
				jumpCount += 1

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
	health -= 5
	if(health < 0):	
		alive = false
		Input.action_release('left')
		Input.action_release('right')
		remove_collisions()
		$AnimatedSprite.play('dead')
	else:
		hit = true
		$HitTimer.start();
	
func shoot():
	if($LaserTimer.is_stopped()):
		$LaserTimer.start()
	
func move():
	if(speedMultiplier == 1):
		if(!hit):
			$AnimatedSprite.play("walk")
		else:
			$AnimatedSprite.play("walk_hit")
	else:
		if(!hit):
			$AnimatedSprite.play("run")
		else:
			$AnimatedSprite.play("run_hit")

func jump():
	if(speedMultiplier == 1 && (bottomColliding() || _state == STATES.JUMPING)):
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
		SceneManager.next_level(SceneManager.current_world)

func remove_collisions():
	set_collision_layer_bit(0, false)
	set_collision_mask_bit(4, false)
	$LeftSide.enabled = false
	$RightSide.enabled = false
	$Bottom.enabled = false
	$Top.enabled = false
	
func create_laser():
	var l = LASER.instance()
	if($AnimatedSprite.flip_h || (_state == STATES.ON_WALL_IN_AIR && $RightSide.is_colliding())):
		l.direction = -1
	get_parent().add_child(l)
	l.position.y = position.y - 7
	l.position.x = position.x + 18

func increase_health():
	maxHealth += 5
	if((maxHealth - health) <= 10):
		health = maxHealth
	else:
		health += 5
	
func increase_damage():
	damage += 5
	
func increase_speed():
	if(speed < maxSpeed):
		speed +=10

func increase_jumps():
	maxJumps += 1

func _on_HitTimer_timeout():
	hit = false


func _on_LaserTimer_timeout():
	create_laser()
