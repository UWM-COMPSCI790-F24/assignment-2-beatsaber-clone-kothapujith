extends Node3D
@export var speed = 5.0  # Speed at which the cube moves towards the player
@export var start_distance = 10.0  # Start position 10 meters away from the player

# Adding a color property
var cube_color = Color()

func _ready():
	# Set the cube's initial position 10 meters away along the Z-axis
	#position = Vector3(0, 0, -start_distance)
	pass

func _process(delta):
	position.z += speed * delta
	if position.z > 0:
		queue_free()  # Remove the cube when it reaches/passes the player

func get_color() -> Color:
	return cube_color
	
# Ensure this script is attached to a Node3D that has a MeshInstance3D as a child.
#func get_color() -> Color:
	#var mesh_instance = get_node_or_null("MeshInstance3D")
	#if mesh_instance and mesh_instance.material_override:
		#var material = mesh_instance.material_override as StandardMaterial3D
		#if material:
			#return material.albedo_color
		#else:
			#print("Material is not StandardMaterial3D")
			#print("No material found or MeshInstance3D node is incorrect")
	#return Color(0, 0, 0)  # Return default color if no material or node is found


	
	
