extends Node3D

func _input(event):
	if event.is_action_pressed("reset"):
		get_tree().change_scene_to_file("test_scene.tscn")
