extends KinematicBody2D

class_name Laser

var velocity = Vector2()
var direction
var speed
	
func _physics_process(delta):
	velocity.x = speed * direction
	move_and_collide(velocity)
