extends Node


var current_scene = null
var current_level = 1
var current_world = "Red"

func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)

func goto_scene(path, level_change):
	call_deferred("_deferred_goto_scene", path)
	
func goto_current_level():
	call_deferred("_deferred_goto_scene", "res://Worlds/" + current_world + " World/" + current_world + "Level" + str(current_level) + ".tscn")
	
func next_level(world):
	current_level += 1
	call_deferred("_deferred_goto_scene", "res://Worlds/" + world + " World/" + world + "Level" + str(current_level) + ".tscn")

func _deferred_goto_scene(path):
	get_tree().change_scene(path)
#	# It is now safe to remove the current scene
#	current_scene.free()
#
#	# Load the new scene.
#	var s = ResourceLoader.load(path)
#
#	# Instance the new scene.
#	current_scene = s.instance()
#
#	# Add it to the active scene, as child of root.
#	get_tree().get_root().add_child(current_scene)
#
#	# Optionally, to make it compatible with the SceneTree.change_scene() API.
#	get_tree().set_current_scene(current_scene)

func save_game():
	pass
