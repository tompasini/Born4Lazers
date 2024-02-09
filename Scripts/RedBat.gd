extends Flyer

var player_position = Vector2(0, 0)

var attack_speed = 175

enum STATES {IDLE, ATTACK}

var _state : int = STATES.IDLE

func _ready():
	life = 60
	hit_animation = 'hit'

func _physics_process(delta):
	if(_state == STATES.ATTACK):
		attack(delta)
		
	if(global_position == player_position):
		_state = STATES.IDLE
		randomize_direction()

func attack(delta):
	global_position = global_position.move_toward(player_position, delta * attack_speed)

func _on_Area2D_body_shape_entered(_body_rid, body, _body_shape_index, _local_shape_index):
	player_position = Vector2(body.global_position.x, body.global_position.y)
	_state = STATES.ATTACK


func _on_Body_body_entered(body):
	if(body.name == 'LZer'):
		body.hurt()
	elif(body.name == 'Laser'):
		$HitTimer.start()
		hit_by_laser(body)
			
func remove_collisions():
	set_collision_layer_bit(4, false)
	set_collision_mask_bit(0, false)
	$Body.set_collision_mask_bit(5, false)
	$Body.set_collision_mask_bit(0, false)


func _on_HitTimer_timeout():
	$AnimatedSprite.play("flap")

func die():
	call_deferred("queue_free")
