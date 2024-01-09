extends PowerUp

func _on_SpeedPowerUp_body_entered(body):
	power_up(body, "increase_speed")
	queue_free()
