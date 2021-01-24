extends Light2D

onready var target = get_parent().get_node("Player")



func _ready():
	self.position = target.position


func _process(delta):
	self.position = target.position
