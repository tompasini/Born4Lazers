extends MarginContainer


var yellow = Color8(247, 247, 10, 255)
var default = Color(1, 1, 1, 1)


# Called when the node enters the scene tree for the first time.
func _ready():
	$HBoxContainer/VBoxContainer/Play.grab_focus()
	
func _process(delta):
	if(Input.is_action_just_pressed("select")):
		if($HBoxContainer/VBoxContainer/Play.has_focus()):
			SceneManager.goto_current_level()
		elif($"HBoxContainer/VBoxContainer/Level Select".has_focus()):
			SceneManager.goto_scene("res://Menus/LevelSelectScreen.tscn")
		elif($"HBoxContainer/VBoxContainer/Options".has_focus()):
			SceneManager.goto_scene("res://Menus/OptionsScreen.tscn")
		elif($HBoxContainer/VBoxContainer/Quit.has_focus()):
			SceneManager.quit_game()

func _on_Play_focus_entered():
	$HBoxContainer/VBoxContainer/Play.modulate = yellow


func _on_Level_Select_focus_entered():
	$"HBoxContainer/VBoxContainer/Level Select".modulate = yellow


func _on_Play_mouse_entered():
	$HBoxContainer/VBoxContainer/Play.grab_focus()


func _on_Level_Select_mouse_entered():
	$"HBoxContainer/VBoxContainer/Level Select".grab_focus()


func _on_Play_focus_exited():
	$HBoxContainer/VBoxContainer/Play.modulate = default


func _on_Level_Select_focus_exited():
	$"HBoxContainer/VBoxContainer/Level Select".modulate = default


func _on_Options_focus_entered():
	$HBoxContainer/VBoxContainer/Options.modulate = yellow


func _on_Options_focus_exited():
	$HBoxContainer/VBoxContainer/Options.modulate = default


func _on_Options_mouse_entered():
	$HBoxContainer/VBoxContainer/Options.grab_focus()


func _on_Quit_focus_entered():
	$HBoxContainer/VBoxContainer/Quit.modulate = yellow


func _on_Quit_focus_exited():
	$HBoxContainer/VBoxContainer/Quit.modulate = default


func _on_Quit_mouse_entered():
	$HBoxContainer/VBoxContainer/Quit.grab_focus()
