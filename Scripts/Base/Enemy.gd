extends KinematicBody2D

class_name Enemy

var velocity = Vector2()
export var direction = -1
export var detects_cliffs = true
var speed
var life
var hit_animation = ''
var death_animation = ''

func remove_collisions():
	pass

func hit_by_laser(body):
	if(life >= GlobalVariables.laser_damage):
		if(hit_animation != ''):
			$AnimatedSprite.play(hit_animation)
		body.delete()
		life -= GlobalVariables.laser_damage
	if(!life || life <= GlobalVariables.laser_damage):
		remove_collisions()
		if(death_animation != ''):
			$AnimatedSprite.play(death_animation)
		speed = 0
		die()
		
func die():
	pass
