extends KinematicBody2D


var health = 100
onready var ai = $AI
onready var hurtbox = $Hurtbox



func _ready():
	ai.initialize(self, hurtbox)

func handle_hit(damage):
	health -= damage
	if health <= 0:
		queue_free()
		
