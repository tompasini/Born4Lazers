extends KinematicBody2D


const SPEED = 15

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
#	$Timer.start()


func _on_Timer_timeout():
	queue_free()
