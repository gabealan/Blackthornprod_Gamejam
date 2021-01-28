extends KinematicBody2D

const ACCELERATION = 500
var health = 100
var top_speed = 100

enum {
	IDLE
	CHASE
	ATTACK
}

onready var animation_player = $AnimationPlayer

var state = IDLE

var target_detected = false
var target = null
var direction = Vector2()
var motion = Vector2.ZERO

func _ready():
	pass


func _physics_process(delta):
	if state == CHASE:
		motion = move_and_slide(motion)
		var target_location = target.get_global_position()
		direction = target_location - self.get_global_position()
		apply_movement(direction * ACCELERATION * delta, top_speed)
	

func _process(delta):
	match state:
		IDLE:
			pass
#			animation_player.play("idle")
		CHASE:
			look_at(target.get_global_position())

		ATTACK:
			pass
			
	

func _on_DetectionArea_body_entered(body):
	if body.is_in_group("player"):
		target = body
		target_detected = true
		state = CHASE
		return target


func _on_DetectionArea_body_exited(body):
	if body.is_in_group("player"):
		target = null
		target_detected = false
		state = IDLE
		return target



func apply_movement(acceleration, top_speed):
	
	motion += acceleration
	if motion.length() > top_speed:
		motion = motion.normalized() * top_speed
