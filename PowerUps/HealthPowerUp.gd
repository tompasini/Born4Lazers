extends Area2D

func _on_HealthPowerUp_body_entered(body):
	if(body.name == "LZer"):
		body.increase_health()
	queue_free()
