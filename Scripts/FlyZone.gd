extends Area2D



func _on_Area2D_body_exited(body):
	body.bounce_direction()
