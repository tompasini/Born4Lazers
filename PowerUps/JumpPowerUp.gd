extends Area2D



func _on_JumpPowerUp_body_entered(body):
	if(body.name == "LZer"):
		body.increase_jumps()
	queue_free()
