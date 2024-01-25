extends Enemy

class_name Flyer
var collision: KinematicCollision2D

func _ready():
	speed = 55
	randomize_direction()

func  _physics_process(delta):
	collision = move_and_collide((velocity * speed) * delta)
	if collision:
		var reflect = collision.get_remainder().bounce(collision.get_normal())
		velocity = velocity.bounce(collision.get_normal())
		move_and_collide(reflect)

func randomize_direction():
	velocity = Vector2(rand_range(-1, 1), rand_range(-1, 1)).normalized()

func bounce_direction():
	if(collision):
		velocity = velocity.bounce(collision.normal)
