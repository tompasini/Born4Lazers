extends Area2D



func _on_DamagePowerUp_body_entered(body):
	if(body.name == "LZer"):
		body.increase_damage()
	queue_free()
