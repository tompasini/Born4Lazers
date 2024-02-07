extends Laser

func _ready():
	direction = 1
	speed  = 15
	$Timer.start()	

func _on_Timer_timeout():
	delete()

func delete():
	call_deferred("queue_free")
