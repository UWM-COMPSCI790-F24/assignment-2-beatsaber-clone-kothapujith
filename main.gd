extends Node3D
var xr_interface: XRInterface

func _ready():
	xr_interface = XRServer.find_interface("OpenXR")
	if xr_interface and xr_interface.is_initialized():
		print("OpenXR initialized successfully")

		# Turn off v-sync!
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)

		# Change our main viewport to output to the HMD
		get_viewport().use_xr = true
	else:
		print("OpenXR not initialized, please check if your headset is connected")
		# Enable both raycasts at startup

func _process(delta):
	check_collision($XROrigin3D/LeftSaber/MeshInstance3D/RayCast3D, $XROrigin3D/LeftSaber/MeshInstance3D.material_override.albedo_color)
	check_collision($XROrigin3D/RightSaber/MeshInstance3D/RayCast3D, $XROrigin3D/RightSaber/MeshInstance3D.material_override.albedo_color)

func check_collision(ray_path, saber_color):
	var ray = ray_path
	if ray:
		var collider = ray.get_collider()
		var global_sound_player = $AudioStreamPlayer3D
		if collider and collider.get_parent().has_method("get_color"):
			var cube_color = collider.get_parent().get_color()
			if cube_color == saber_color:
				global_sound_player.play()
				collider.queue_free()
				
				
func toggle_laser():
	var left_laser_mesh = get_node("XROrigin3D/LeftSaber/MeshInstance3D")
	left_laser_mesh.visible = !left_laser_mesh.visible
	var right_laser_mesh = get_node("XROrigin3D/RightSaber/MeshInstance3D")
	right_laser_mesh.visible = !right_laser_mesh.visible
	
var left_saber_path = "XROrigin3D/LeftSaber/MeshInstance3D"
var right_saber_path = "XROrigin3D/RightSaber/MeshInstance3D"	
	
func set_laser_visibility(saber_path, is_visible):
	var laser_mesh = get_node(saber_path)
	laser_mesh.visible = is_visible

func _on_right_saber_button_pressed(name):
	if name == "by_button":
		XRServer.center_on_hmd(XRServer.RESET_BUT_KEEP_TILT, true)
	elif name == "ax_button":  # Check if the correct button is pressed
			set_laser_visibility(right_saber_path, true)

func _on_right_saber_button_released(name):
	if name == "ax_button":  # Check if the correct button is release
		set_laser_visibility(right_saber_path, false)

# Left Controller
func _on_left_saber_button_pressed(name):
	if name == "ax_button":  # Similarly for left saber
		set_laser_visibility(left_saber_path, true)

func _on_left_saber_button_released(name):
	if name == "ax_button":
		set_laser_visibility(left_saber_path, false)
