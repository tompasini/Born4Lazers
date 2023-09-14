extends Node2D


func _ready():
	GlobalVariables.currentWorld = "Red"


func _on_Switch_body_entered(body):
	$LZer.remove_collisions()
	$LZer.finished = true
	$Switch.get_node("AnimatedSprite").play("pressed")
	$LZer.get_node("AnimatedSprite").play("finished")


func _on_StartArea_body_entered(body):
	if(body.name == "LZer"):
		$StartArea.queue_free()
		$KingEyebes.get_child(5).start()
		$KingEyebes.level_started = true

func transition_to_blue_world():
	SceneManager.current_world = "Blue"
	SceneManager.current_level = 0
	SceneManager.next_level(SceneManager.current_world)


func _on_KingEyebes_transition_world():
	$TransitionTimer.start()


func _on_TransitionTimer_timeout():
	transition_to_blue_world()
