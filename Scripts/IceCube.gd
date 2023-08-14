extends KinematicBody2D

var velocity = Vector2(0,0)
var life = 30
export var direction = 1


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_Body_body_entered(body):
	if(body.name == "LZer"):
		body.hurt()
	elif(body.name == 'Laser'):
		if(life):
			$AnimatedSprite.play('hit')
			body.queue_free()
			life -= GlobalVariables.laser_damage
			$HitTimer.start()
		if(!life):
			remove_collisions()	
			queue_free()

func remove_collisions():
	set_collision_mask_bit(1, false)
	$Body.set_collision_layer_bit(4, false)
	$Body.set_collision_mask_bit(0, false)
	$Body.set_collision_mask_bit(5, false)
