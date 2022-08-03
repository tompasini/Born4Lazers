extends Node2D


func _ready():
	pass


func _on_RedSwitch_body_entered(body):
	$LZer.finished = true
	$RedSwitch.get_node("AnimatedSprite").play("pressed")
