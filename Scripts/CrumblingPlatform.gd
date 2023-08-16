extends StaticBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


#func _on_Body_body_entered(body):
#	if(body.name == "LZer"):
#		print('colliding')


func _on_Body_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if(body.name == "LZer"):
		$CrumbleTimer1.start()


func _on_CrumbleTimer1_timeout():
	$AnimatedSprite.play("crumbling")
	$CrumbleTimer2.start()


func _on_CrumbleTimer2_timeout():
	queue_free()
