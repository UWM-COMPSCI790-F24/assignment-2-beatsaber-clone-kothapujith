extends Node3D
@export var speed = 5.0
@export var start_distance = 10.0

var cube_color = Color()

func _ready():
	pass

func _process(delta):
	position.z += speed * delta
	if position.z > 0:
		queue_free()

func get_color() -> Color:
	return cube_color
	

	
	
