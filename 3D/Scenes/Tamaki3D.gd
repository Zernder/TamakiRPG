extends CharacterBody3D


const JUMP_VELOCITY = 12.0

@export var Stats: CharacterStats

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 24
var sensitivity = 0.002
@onready var camera3d = $Camera3D
@onready var raycast3d = $Camera3D/RayCast3D


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		rotation.y = rotation.y - event.relative.x * sensitivity
		camera3d.rotation.x = camera3d.rotation.x - event.relative.y * sensitivity
		camera3d.rotation.x = clamp(camera3d.rotation.x, deg_to_rad(-70), deg_to_rad(80))

func _physics_process(delta):
	Movement(delta)
	Jump(delta)
	CreateBlock()
	DestroyBlock()
	move_and_slide()


func Movement(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * Stats.tspeed
		velocity.z = direction.z * Stats.tspeed
	else:
		velocity.x = move_toward(velocity.x, 0,  Stats.tspeed)
		velocity.z = move_toward(velocity.z, 0,  Stats.tspeed)

func Jump(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

func CreateBlock():
	if Input.is_action_just_pressed("Secondary"):
		if raycast3d.is_colliding():
			if raycast3d.get_collider().has_method("placeblock"):
				raycast3d.get_collider().placeblock(raycast3d.get_collision_point() + raycast3d.get_collision_normal(), 1)

func DestroyBlock():
	if Input.is_action_just_pressed("Primary"):
		if raycast3d.is_colliding():
			if raycast3d.get_collider().has_method("destroyblock"):
				raycast3d.get_collider().destroyblock(raycast3d.get_collision_point() - raycast3d.get_collision_normal())




func ExitGame():
	if Input.is_action_just_pressed("Exit"):
		get_tree().quit()
