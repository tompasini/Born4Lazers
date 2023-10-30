extends Area2D



func _on_SpeedPowerUp_body_entered(body):
	if(body.name == "LZer"):
		body.increase_speed()
	queue_free()
