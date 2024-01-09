extends PowerUp

func _on_JumpPowerUp_body_entered(body):
	power_up(body, "increase_jumps")
	queue_free()
