extends Node3D

@export var cube_scene = preload("res://cube.tscn")
@export var min_spawn_time = 0.5
@export var max_spawn_time = 2.0

@export var spawn_distance = 10.0
@export var x_spawn_range = 1.5
@export var y_spawn_range = 1.5

var red_color = Color(255/255, 0/255, 0/255, 255/255)
var blue_color = Color(0/255, 0/255, 255/255, 255/255)

func _ready():
	_schedule_next_spawn()

func _schedule_next_spawn() -> void:
	var spawn_time = randf_range(min_spawn_time, max_spawn_time)

	var timer = Timer.new()
	timer.wait_time = spawn_time
	timer.one_shot = true
	add_child(timer)
	timer.start()

	await timer.timeout
	_spawn_cube()

	_schedule_next_spawn()

func _spawn_cube() -> void:
	var cube_instance = cube_scene.instantiate()

	var random_x = randf_range(-x_spawn_range, x_spawn_range)
	var random_y = randf_range(-y_spawn_range, y_spawn_range)

	cube_instance.position = Vector3(random_x, random_y, -spawn_distance)

	var material = StandardMaterial3D.new()
	if randi() % 2 == 0:
		material.albedo_color = red_color
		cube_instance.cube_color = red_color
	else:
		material.albedo_color = blue_color
		cube_instance.cube_color = blue_color
	
	var mesh_instance = cube_instance.get_node("CSGBox3D")
	mesh_instance.material_override = material

	add_child(cube_instance)
	
