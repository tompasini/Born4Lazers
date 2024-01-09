extends Laser

func _ready():
	direction = 1
	speed  = 15
	$Timer.start()	

func _on_Timer_timeout():
	queue_free()
