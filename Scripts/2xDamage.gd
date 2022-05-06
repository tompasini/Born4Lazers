extends Area2D



func _on_2xDamage_body_entered(body):
	$AnimationPlayer.play("bounce")
	body.multiply_damage(2)

func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()
