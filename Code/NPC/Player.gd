extends CharacterBody2D
class_name Player


const TAMAKI = preload("res://Code/Resources/Tamaki_stats.tres")

# GUI Variables
@onready var PMenu = $GUI/PauseMenu

# Movement and Aniamtion Variables
var direction : Vector2 = Vector2.ZERO
@onready var Anim = $AnimatedSprite2D
@onready var TalkArea = $Areas/TalkArea

# Combat and Weapon Animations
@onready var WeaponDestination = $Weapons/WeaponDestination
@onready var player = $"."
@onready var WeaponCooldownTimer = $Timers/WeaponCooldown
@onready var WoodenBow = $Weapons/WoodenBow

@onready var Experience: = 0

# The Runtimes
func _ready() -> void:
	PMenu.hide()
	print("Initial Health:", TAMAKI.Health)
	print("Initial Speed:", TAMAKI.Speed)
	print("Initial Level:", TAMAKI.Level)
	print("Initial Damage:", TAMAKI.Damage)
	print("Initial XP:", TAMAKI.currentxp)
	print("Required XP:", TAMAKI.requiredxp)


func _physics_process(_delta):
	Movement()
	Ranged()
	PauseMenu()
	Map()

func _process(_delta):
	pass

func _unhandled_input(_InputEvent) -> void:
	Interact()
# Actionable Tasks with Inputs

# Movement and Animations

func Movement():
	# Get input for directions
	direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down").normalized()
	
	if Input.is_action_pressed("ui_left"):
		Anim.play("walkleft")
		velocity = direction * TAMAKI.Speed
	elif Input.is_action_pressed("ui_right"):
		Anim.play("walkright")
		velocity = direction * TAMAKI.Speed
	elif Input.is_action_pressed("ui_up"):
		Anim.play("walkup")
		velocity = direction * TAMAKI.Speed
	elif Input.is_action_pressed("ui_down"):
		Anim.play("walkdown")
		velocity = direction * TAMAKI.Speed
	else:
		velocity.x = move_toward(velocity.x, 0, TAMAKI.Speed)
		velocity.y = move_toward(velocity.y, 0, TAMAKI.Speed)
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
		TAMAKI.Health -= 2
	if area.is_in_group("SkeletonEnemyHitbox"):
		TAMAKI.Health -= 5
	if TAMAKI.Health <= 0:
		TAMAKI.Health = 20
		get_tree().reload_current_scene()

# Combat section, for XP and damage

func Ranged():
	var MousePosition = get_global_mouse_position()
	var RangedWeaponInstance = Global.RangedWeaponChoice()
	WeaponDestination.look_at(MousePosition)
	
	if Input.is_action_just_pressed("Ranged"):
		var direction = (MousePosition - WeaponDestination.global_position).normalized()
		RangedWeaponInstance.set_direction(direction)
		RangedWeaponInstance.rotation = WeaponDestination.rotation
		RangedWeaponInstance.global_position = WeaponDestination.global_position
		add_child(RangedWeaponInstance)
		Global.Cooldown = 1
		WeaponCooldownTimer.start()



func WeaponCooldown():
	Global.Cooldown = 0


func PauseMenu():
	if Input.is_action_just_pressed('PauseMenu'):
		PMenu.show()
		get_tree().paused = true

func Map():
	if Input.is_action_just_pressed("Map"):
		$Camera2D.enabled = true
		
