extends RigidBody2D

var life = 15

func _on_Area2D_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	print('we hit body shape entered')
