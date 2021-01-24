extends KinematicBody2D

var top_speed = 250
var MAX_SPEED = 250
var CROUCHED_SPEED = 75
var ACCELERATION = 1000
var SPRINTING_SPEED = 400
var motion = Vector2.ZERO
var is_crouched = false
var is_sprinting = false
var stamina = 100

func _physics_process(delta):
	
	if Input.is_action_just_pressed("crouch"):
		crouch()
	
	if Input.is_action_pressed("sprint"):
		sprint()
	
	if not Input.is_action_pressed("sprint"):
		top_speed = MAX_SPEED
		
	look_at(get_global_mouse_position())

	var axis = get_input_axis()
	if axis == Vector2.ZERO:
		apply_friction(ACCELERATION * delta)
	else:
		apply_movement(axis * ACCELERATION * delta, top_speed)
	motion = move_and_slide(motion)
	
	
	
	
func get_input_axis():
	var axis = Vector2.ZERO
	axis.x = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	axis.y = int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("up"))
	return axis.normalized()
	
	
func apply_friction(amount):
	if motion.length() > amount:
		motion -= motion.normalized() * amount
	else:
		motion = Vector2.ZERO
		
		
func apply_movement(acceleration, top_speed):

	motion += acceleration
	if motion.length() > top_speed:
		motion = motion.normalized() * top_speed
	print(motion)

	

func crouch():
	if is_crouched == false:
		is_crouched = true
	else:
		is_crouched = false
	
	if is_crouched == true:
		top_speed = CROUCHED_SPEED
		print(is_crouched)
	if is_crouched == false:
		top_speed = MAX_SPEED
		print(is_crouched)
	return top_speed
	

func sprint():
	if stamina > 0:
		if is_sprinting == false:
			is_sprinting = true
		else:
			is_sprinting = false
	
	if is_sprinting == true:
		is_crouched = false
		top_speed = SPRINTING_SPEED

	
	return top_speed
