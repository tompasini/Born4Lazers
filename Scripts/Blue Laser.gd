extends KinematicBody2D

var velocity = Vector2()
var direction = 1
const SPEED = 10

func _ready():
	$Timer.start()
	
func _physics_process(delta):
	velocity.x = SPEED * direction
	move_and_collide(velocity)


func _on_Timer_timeout():
	queue_free()
