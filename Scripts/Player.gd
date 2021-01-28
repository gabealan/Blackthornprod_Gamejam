extends KinematicBody2D

var walking_sound = load("res://Assets/Sounds/GameJamFootsteps-2021-01-24-22-29-30_3sec_session.wav")
var crouched_sound = load("res://Assets/Sounds/GameJamFootsteps-2021-01-24-22-29-30_slow_session.wav")
var sprinting_sound = load("res://Assets/Sounds/GameJamFootsteps-2021-01-24-22-29-30_sprint_session.wav")
var top_speed = 150
var MAX_SPEED =150
var CROUCHED_SPEED = 60
var ACCELERATION = 1000
var SPRINTING_SPEED = 225
var motion = Vector2.ZERO
var is_crouched = false
var is_sprinting = false
var stamina = 100

onready var spawn_point = get_parent().get_node("SpawnPoint")


func _ready():
	position = spawn_point.position

func _physics_process(delta):
	if Input.is_action_just_pressed("crouch"):
		crouch()
		audio_manager.walk_audio_stop()
	
	if Input.is_action_just_pressed("sprint"):
		audio_manager.walk_audio_stop()
	if Input.is_action_just_released("sprint"):
		audio_manager.walk_audio_stop()
	if Input.is_action_pressed("sprint"):
		sprint()
		
	if not Input.is_action_pressed("sprint") and is_crouched == false:
		top_speed = MAX_SPEED

	
	look_at(get_global_mouse_position())

	var axis = get_input_axis()
	if axis == Vector2.ZERO:
		apply_friction(ACCELERATION * delta)
		audio_manager.walk_audio_stop()
		
	else:
		apply_movement(axis * ACCELERATION * delta, top_speed)
	motion = move_and_slide(motion)
	
	if axis != Vector2.ZERO:
		play_footsteps()
	
	
	
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

	

func crouch():
	if is_crouched == false:
		is_crouched = true
		top_speed = CROUCHED_SPEED
	else:
		is_crouched = false
		top_speed = MAX_SPEED
		
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
	
	
func play_footsteps():
	if top_speed == CROUCHED_SPEED:
		change_audio(crouched_sound)
	elif top_speed == MAX_SPEED:
		change_audio(walking_sound)
	elif top_speed == SPRINTING_SPEED:
		change_audio(sprinting_sound)
		
func change_audio(sound):
	if not audio_manager.play_walk_effects(sound):
#			audio_manager.walk_audio_stop()
			audio_manager.play_walk_effects(sound)

