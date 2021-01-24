extends KinematicBody2D


func _physics_process(delta):
	look_at(get_global_mouse_position())
	if Input.is_action_pressed("up"):
		position += transform.x * 10
	if Input.is_action_pressed("down"):
		position -= global_transform.x * 10
	if Input.is_action_pressed("right"):
		position += global_transform.y * 10
	if Input.is_action_pressed("left"):
		position -= global_transform.y *10
