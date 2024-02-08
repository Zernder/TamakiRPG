extends CharacterBody2D
class_name Player


@onready var Tamaki = Global.TAMAKI

# GUI Variables
@onready var PMenu = $GUI/PauseMenu

# Movement and Aniamtion Variables
var direction : Vector2 = Vector2.ZERO
@onready var Anim = $AnimatedSprite2D
@onready var TalkArea = $Areas/TalkArea

# Combat and Weapon Animations
@onready var WeaponDestination = $Weapons/WeaponDestination
@onready var WeaponCooldownTimer = $Timers/WeaponCooldown
@onready var player = $"."


@onready var Experience: = 0

# The Runtimes
func _ready() -> void:
	PMenu.hide()
	print("Initial Health:", Tamaki.Health)
	print("Initial Speed:", Tamaki.Speed)
	print("Initial Level:", Tamaki.Level)
	print("Initial Damage:", Tamaki.Damage)
	print("Initial XP:", Tamaki.currentxp)
	print("Required XP:", Tamaki.requiredxp)


func _physics_process(_delta):
	Movement()
	Ranged()
	PauseMenu()

func _unhandled_input(_InputEvent) -> void:
	Interact()
# Actionable Tasks with Inputs

# Movement and Animations

func Movement():
	# Get input for directions
	direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down").normalized()
	
	if Input.is_action_pressed("ui_left"):
		Anim.play("walkleft")
		velocity = direction * Tamaki.Speed
	elif Input.is_action_pressed("ui_right"):
		Anim.play("walkright")
		velocity = direction * Tamaki.Speed
	elif Input.is_action_pressed("ui_up"):
		Anim.play("walkup")
		velocity = direction * Tamaki.Speed
	elif Input.is_action_pressed("ui_down"):
		Anim.play("walkdown")
		velocity = direction * Tamaki.Speed
	else:
		velocity.x = move_toward(velocity.x, 0, Tamaki.Speed)
		velocity.y = move_toward(velocity.y, 0, Tamaki.Speed)
	move_and_slide()

func Interact():
	if Input.is_action_just_pressed("Interact"):
			Global.Cooldown = 1
			var action = TalkArea.get_overlapping_areas()
			if action.size() > 0:
				action[0].action()
				return
			Global.Cooldown = 0


func PlayerHit(area):
	if area.is_in_group("SlimeEnemyHitbox"):
		Tamaki.Health -= 2
	if area.is_in_group("SkeletonEnemyHitbox"):
		Tamaki.Health -= 5
	if Tamaki.Health <= 0:
		Tamaki.Health = 20
		get_tree().reload_current_scene()

# Combat section, for XP and damage
const SHURIKEN = preload("res://Scenes/Weapons/Shuriken.tscn")


func Ranged():
	var MousePosition = get_global_mouse_position()
	var RangedWeaponInstance = SHURIKEN.instantiate()
	WeaponDestination.look_at(MousePosition)
	
	if Input.is_action_just_pressed("Ranged") and WeaponCooldownTimer.is_stopped():
		WeaponCooldownTimer.start()
		var direction = (MousePosition - WeaponDestination.global_position).normalized()
		RangedWeaponInstance.rotation = WeaponDestination.rotation
		RangedWeaponInstance.set_direction(direction)
		RangedWeaponInstance.global_position = WeaponDestination.global_position
		add_child(RangedWeaponInstance)


func WeaponCooldown():
	return

func PauseMenu():
	if Input.is_action_just_pressed('PauseMenu'):
		PMenu.show()
		get_tree().paused = true




