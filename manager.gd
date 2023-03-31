extends Node3D

var physics_bodies_to_update = []

func _physics_process(delta):
	for physics_body_rid in physics_bodies_to_update:
		PhysicsServer3D.body_set_space(physics_body_rid, get_world_3d().space)
		
	physics_bodies_to_update = []

func _input(event):
	if event.is_action_pressed("reset"):
		get_tree().change_scene_to_file("test_scene.tscn")

func _init():
	# Update after physics objects
	process_priority = 1
