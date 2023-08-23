extends Node2D

func _ready():
	GlobalVariables.currentWorld = "Blue"


func _on_BlueSwitch_body_entered(body):
	$LZer.remove_collisions()
	$LZer.finished = true
	$BlueSwitch.get_node("AnimatedSprite").play("pressed")
	$LZer.get_node("AnimatedSprite").play("finished")
