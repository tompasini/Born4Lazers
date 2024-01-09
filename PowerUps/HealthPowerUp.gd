extends PowerUp

func _on_HealthPowerUp_body_entered(body):
	power_up(body, "increase_health")
	queue_free()
