extends MarginContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$HBoxContainer/VBoxContainer/Play.grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Play_focus_entered():
	print('focused on Play')


func _on_Level_Select_focus_entered():
	print('focused on Level Select')
