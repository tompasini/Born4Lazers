extends KinematicBody2D

var velocity = Vector2()
var direction = 1
const SPEED = 8

func _ready():
	$Timer.start()
	
func _physics_process(delta):
	velocity.x = SPEED * direction
	move_and_collide(velocity)


func _on_Timer_timeout():
	queue_free()


func _on_Area2D_body_entered(body):
	if(body.name == "LZer"):
		body.hurt()
