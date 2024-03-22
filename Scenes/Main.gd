extends Node

var is_2d_mode: bool = true
@onready var main2d = get_node("Main2D")
@onready var main3d = get_node("Main3D")

func _ready():
	# Ensure only one mode is active initially
	main2d.visible = is_2d_mode
	main2d.set_process_input(is_2d_mode)
	main2d.set_process(is_2d_mode)

	main3d.visible = not is_2d_mode
	main3d.set_process_input(not is_2d_mode)
	main3d.set_process(not is_2d_mode)

func toggle_mode():
	is_2d_mode = not is_2d_mode

	# Enable/disable 2D mode
	main2d.visible = is_2d_mode
	main2d.set_process_input(is_2d_mode)
	main2d.set_process(is_2d_mode)

	# Enable/disable 3D mode
	main3d.visible = not is_2d_mode
	main3d.set_process_input(not is_2d_mode)
	main3d.set_process(not is_2d_mode)

# Additional logic for camera, controls, and game mechanics can be implemented here

func _input(event):
	if Input.is_action_just_pressed("changedimension"):
		toggle_mode()
