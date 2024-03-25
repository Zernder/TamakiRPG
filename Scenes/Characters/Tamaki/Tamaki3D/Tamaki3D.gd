extends CharacterBody3D



@export var Stats: CharacterStats
const jumpvelocity = 20.0
var gravity = 24
var sensitivity = 0.002


@onready var camera3d = $Camera3D
@onready var raycast3d = $Camera3D/RayCast3D
@onready var anim = $AnimationTree

@onready var charactersheet = $UI/CharacterSheet
@onready var castbar = $Weapons/Magic/Castbar

@onready var jumptimer = $Timers/JumpTimer
@onready var cast = $Timers/Cast


func _ready():
	Stats.speed = 60
	anim["parameters/conditions/idle"] = true
	Global.is2D = false


func _process(_delta):
	ExitGame()


func _physics_process(delta):
	Movement()
	Jump(delta)
	CreateBlock()
	DestroyBlock()
	move_and_slide()


func _unhandled_input(event):
	MoveMouse(event)


func Movement():
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		anim["parameters/conditions/walk"] = true
		anim["parameters/conditions/idle"] = false
		velocity.x = direction.x * Stats.speed
		velocity.z = direction.z * Stats.speed
	else:
		anim["parameters/conditions/idle"] = true
		anim["parameters/conditions/walk"] = false
		velocity.x = move_toward(velocity.x, 0,  Stats.speed)
		velocity.z = move_toward(velocity.z, 0,  Stats.speed)

var zoom_speed = 0.1
var min_fov = 30.0
var max_fov = 90.0
var zooming_in = false
var rts_mode = false
var normal_fov = 75.0 # Default FOV for normal mode
var rts_fov = 90.0 # FOV for RTS mode
var normalrotation = Vector3(0, 0, 0) # Store normal rotation
var normalposition = Vector3(0, 0.55, -0.235) # Store normal translation
var rtsrotation = Vector3(-90, 0, 0) # RTS rotation
var rtsposition = Vector3(0, 20, 0) # RTS translation


func MoveMouse(event):
	if Input.is_action_just_pressed("Map"):
		rts_mode = !rts_mode
		if rts_mode:
			# Enter RTS mode
			camera3d.position = rtsposition
			camera3d.rotation_degrees = rtsrotation
			camera3d.set_fov(rts_fov)
		else:
			# Exit RTS mode
			camera3d.position = normalposition
			camera3d.rotation_degrees = normalrotation
			camera3d.set_fov(normal_fov)
	elif event is InputEventMouseMotion and !rts_mode:
		rotation.y = rotation.y - event.relative.x * sensitivity
		camera3d.rotation.x = camera3d.rotation.x - event.relative.y * sensitivity
		camera3d.rotation.x = clamp(camera3d.rotation.x, deg_to_rad(-70), deg_to_rad(80))


func Jump(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		Stats.speed = 0
		jumptimer.start(0.9)
		anim["parameters/conditions/jump"] = true
		await jumptimer.timeout
		$GeneralSkeleton/Mesh.visible = false
		velocity.y = jumpvelocity
		anim["parameters/conditions/jump"] = false
		Stats.speed = 60
		jumptimer.start(1)
		await jumptimer.timeout
		$GeneralSkeleton/Mesh.visible = true


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
