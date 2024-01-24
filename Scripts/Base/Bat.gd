extends Enemy

class_name Bat

func _ready():
	speed = 50
	randomize_direction()

func  _physics_process(delta):
	move_and_slide(velocity.normalized() * speed)

func randomize_direction():
	velocity = Vector2(rand_range(-1, 1), rand_range(-1, 1)).normalized()
