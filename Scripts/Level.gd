extends Node2D


func _ready():
	GlobalVariables.currentWorld = "Red"


func _on_Switch_body_entered(body):
	$LZer.finished = true
	$Switch.get_node("AnimatedSprite").play("pressed")
	$LZer.get_node("AnimatedSprite").play("finished")
