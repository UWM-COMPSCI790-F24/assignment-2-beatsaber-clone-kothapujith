extends Node3D

@export var cube_scene = preload("res://cube.tscn")  # Preload the Cube scene
@export var min_spawn_time = 0.5  # Minimum spawn interval (seconds)
@export var max_spawn_time = 2.0  # Maximum spawn interval (seconds)

@export var spawn_distance = 10.0  # Distance from the player (along Z axis)
@export var x_spawn_range = 1.5  # Horizontal (X-axis) range for random spawning
@export var y_spawn_range = 1.5  # Vertical (Y-axis) range for random spawning

# Define red and blue colors
var red_color = Color(255/255, 0/255, 0/255, 255/255)
var blue_color = Color(0/255, 0/255, 255/255, 255/255)

func _ready():
	# Start the cube spawning process
	_schedule_next_spawn()

func _schedule_next_spawn() -> void:
	# Randomly choose a spawn time between min and max
	var spawn_time = randf_range(min_spawn_time, max_spawn_time)

	# Create and start a timer to delay cube spawning
	var timer = Timer.new()
	timer.wait_time = spawn_time
	timer.one_shot = true
	add_child(timer)
	timer.start()

	# Use await to wait for the timer to finish, then spawn the cube
	await timer.timeout
	_spawn_cube()

	# Schedule the next cube spawn recursively
	_schedule_next_spawn()

func _spawn_cube() -> void:
	# Create an instance of the cube scene
	var cube_instance = cube_scene.instantiate()

	# Randomize the X and Y spawn positions
	var random_x = randf_range(-x_spawn_range, x_spawn_range)
	var random_y = randf_range(-y_spawn_range, y_spawn_range)

	# Set the cube's initial position 10 meters away along the Z axis
	cube_instance.position = Vector3(random_x, random_y, -spawn_distance)

	# Randomly assign the cube to be either red or blue
	var material = StandardMaterial3D.new()
	if randi() % 2 == 0:
		material.albedo_color = red_color  # Assign red color
		cube_instance.cube_color = red_color
	else:
		material.albedo_color = blue_color  # Assign blue color
		cube_instance.cube_color = blue_color
	
	# Apply the material to the cube
	var mesh_instance = cube_instance.get_node("CSGBox3D")  # Adjust if needed based on your cube structure
	mesh_instance.material_override = material

	# Add the cube to the scene
	add_child(cube_instance)
	
