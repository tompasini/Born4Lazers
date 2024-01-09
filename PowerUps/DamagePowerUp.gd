extends PowerUp

func _on_DamagePowerUp_body_entered(body):
	power_up(body, "increase_damage")
	queue_free()
