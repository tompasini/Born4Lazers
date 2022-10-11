extends KinematicBody2D

var velocity = Vector2()

enum STATES {UP, DOWN, IDLE, ATTACK}

var _state : int = STATES.UP

func _ready():
	pass

func _physics_process(delta):
	if(_state != STATES.ATTACK):
		bob()
	move_and_slide(velocity)

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

func attack(position):	
	print('attack!')

func _on_Area2D_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	_state = STATES.ATTACK
	attack(body.position)
