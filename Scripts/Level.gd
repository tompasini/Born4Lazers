extends Node2D


func _ready():
	GlobalVariables.currentWorld = "Red"


func _on_Switch_body_entered(body):
	$LZer.finished = true
	$Switch.get_node("AnimatedSprite").play("pressed")
	$LZer.get_node("AnimatedSprite").play("finished")


func _on_StartArea_body_entered(body):
	if(body.name == "LZer"):
		$StartArea.queue_free()
		$KingEyebes.get_child(5).start()
