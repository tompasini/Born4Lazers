extends Laser

func _ready():
	direction = 1
	speed = 8
	$Timer.start()

func _on_Timer_timeout():
	queue_free()


func _on_Area2D_body_entered(body):
	if(body.name == "LZer"):
		body.hurt()
