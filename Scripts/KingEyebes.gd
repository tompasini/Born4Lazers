extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Body_body_entered(body):
	if(body.name == 'LZer'):
		body.hurt()
	elif(body.name == 'Laser'):
		$HitAura.visible = true
		$HitAuraTimer.start()


func _on_HitAuraTimer_timeout():
	$HitAura.visible = false
