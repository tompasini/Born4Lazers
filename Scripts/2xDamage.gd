extends Area2D

func _on_2xDamage_body_entered(body):
	$AnimationPlayer.play("bounce")
	PowerUps.dmgPowerUps += 1
	body.emit_signal("dmg_power_up_collected")
	set_collision_mask_bit(0, false)
	
func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()
