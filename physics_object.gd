extends RigidBody3D

var original_transfrom: Transform3D = Transform3D()

func _dump_ghost() -> void:
	var ghost_mi: MeshInstance3D = MeshInstance3D.new()
	ghost_mi.top_level = true
	ghost_mi.mesh = $MeshInstance3D.mesh
	ghost_mi.transparency = 0.1
	get_parent().add_child(ghost_mi)
	ghost_mi.global_transform = global_transform
			
func _reset() -> void:
	transform = original_transfrom
	linear_velocity = Vector3()
	angular_velocity = Vector3()
	sleeping = false
	
	if PhysicsServer3D.has_method("body_reset_state"):
		PhysicsServer3D.body_reset_state(get_rid())
	PhysicsServer3D.body_set_state(get_rid(), PhysicsServer3D.BODY_STATE_TRANSFORM, original_transfrom)
	PhysicsServer3D.body_set_state(get_rid(), PhysicsServer3D.BODY_STATE_LINEAR_VELOCITY, Vector3())
	PhysicsServer3D.body_set_state(get_rid(), PhysicsServer3D.BODY_STATE_ANGULAR_VELOCITY, Vector3())
	PhysicsServer3D.body_set_state(get_rid(), PhysicsServer3D.BODY_STATE_SLEEPING, false)
			
func _physics_process(_delta: float) -> void:
	# Sets all the physics objects back to their original transforms
	if Input.is_action_just_pressed("physics_reset"):
		_dump_ghost()
		_reset()
			

func _enter_tree() -> void:
	original_transfrom = transform
	
	_reset()

func _ready() -> void:
	_reset()
