extends Camera3D
#
#
#
#var sensitivity = 0.01 # Define sensitivity here
#
#
#var zoom_speed = 0.1
#var min_fov = 30.0
#var max_fov = 90.0
#var zooming_in = false
#var rts_mode = false
#var normal_fov = 75.0 # Default FOV for normal mode
#var rts_fov = 90.0 # FOV for RTS mode
#var normalrotation = Vector3() # Store normal rotation
#var normalposition = Vector3() # Store normal translation
#var rtsrotation = Vector3(0, -45, 0) # RTS rotation
#var rtsposition = Vector3(0, 100, 0) # RTS translation
#
#func _unhandled_input(event):
	#Camera(event)
#
#func Camera(event):
	#if Input.is_action_just_pressed("Map"):
		#rts_mode = !rts_mode
		#if rts_mode:
			## Enter RTS mode
			#position = rtsposition
			#rotation_degrees = rtsrotation
			#set_fov(rts_fov)
		#else:
			## Exit RTS mode
			#position = normalposition
			#rotation_degrees = normalrotation
			#set_fov(normal_fov)
	#elif event is InputEventMouseMotion and !rts_mode:
		#rotation.y = rotation.y - event.relative.x * sensitivity
		#rotation.x = rotation.x - event.relative.y * sensitivity
		#rotation.x = clamp(rotation.x, deg_to_rad(-70), deg_to_rad(80))
