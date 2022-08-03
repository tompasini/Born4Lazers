extends KinematicBody2D

var velocity = Vector2(0, 0)
var damage = 5
var alive = true
var finished = false
var direction = 1
var speedMultiplier = 1
const SPEED = 90
const JUMPFORCE = -550
const GRAVITY = 35
const LASER = preload("res://Laser.tscn")

signal dmg_power_up_collected

signal finished_level

func _physics_process(delta):
	if(alive && !finished):
		if (Input.is_action_pressed("right")):
			direction = 1
			if(Input.is_action_pressed("run")):
				speedMultiplier = 2
			else:
				speedMultiplier = 1
			velocity.x = (SPEED * speedMultiplier)
			$AnimatedSprite.flip_h = false
			move()
		elif(Input.is_action_pressed("left")):
			direction = -1
			if(Input.is_action_pressed("run")):
				speedMultiplier = 2
			velocity.x = (-SPEED * speedMultiplier)
			$AnimatedSprite.flip_h = true
			move()
		else:
			$AnimatedSprite.play('idle')	
		
		if not is_on_floor():
			$AnimatedSprite.play('jump')
			
		if(Input.is_action_just_pressed("shoot")):
			shoot()
		
		velocity.y += GRAVITY

		if(Input.is_action_just_pressed("jump") and is_on_floor()):
			if(speedMultiplier == 1):
				velocity.y = JUMPFORCE
			else:
				velocity.y = -700
				velocity.x += (700 * direction)

		velocity = move_and_slide(velocity, Vector2.UP)
		
		if(is_on_floor()):
			velocity.x = lerp(velocity.x, 0, 0.2)


func _on_FallZone_body_entered(body):
	get_tree().reload_current_scene()
	
func get_damage():
	return (GlobalVariables.dmgPowerUps * damage) if (GlobalVariables.dmgPowerUps) else damage

func bounce():
	velocity.y = JUMPFORCE * 0.5


func hurt():
	alive = false
	Input.action_release('left')
	Input.action_release('right')
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

func _on_Timer_timeout():
	get_tree().reload_current_scene()


func _on_AnimatedSprite_animation_finished():
	if($AnimatedSprite.animation == 'dead'):
		$Timer.start()
