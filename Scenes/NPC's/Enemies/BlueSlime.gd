extends CharacterBody2D

const TAMAKI = preload("res://Resources/NPC/Tamaki.tres")
# Green Slime Code

# Health, Speed, and animations
@onready var animation = $Animations
@export var Health = 2
@export var Speed = 20
@export var Damage = 2

# Combat Variables

var player = null
var playerchase: bool
var TakeDamage: bool
var Dying: bool

# GUI

@onready var HealthBar = $Gui/Healthbar
@onready var SlimeLabel = $Gui/Healthbar/Label

# Areas

@onready var HitBox = $Areas/Hitbox
@onready var DetectionBox = $Areas/DetectionRadius

# Timers

@onready var StateMachineTimeout = $Timers/StateMachineTimeout
@onready var DeathTimer = $Timers/DeathTimer
@onready var HitTimer = $Timers/HitTimer

# State Machine
var CurrentState = IDLE
var dir = Vector2.RIGHT


func _ready():
	animation.play("idle")
	randomize()
	HealthBar.max_value = Health

func _process(delta):
	statemachine(delta)
	Bars()

func _physics_process(_delta):
	GiveChase()

# state Machine Code

enum {
		IDLE,
		CHASE,
		MOVE,
		HIT
	}

func statemachine(delta):
	if Health > 0:
		match CurrentState:
			IDLE:
				animation.play("idle")
				dir = choose([Vector2.RIGHT, Vector2.LEFT, Vector2.UP, Vector2.DOWN])
			MOVE:
				move(delta)
			CHASE:
				GiveChase()
			HIT:
				animation.play("hit")

func choose(array):
	array.shuffle()
	return array.front()


func StateReset():
	if playerchase == true:
		CurrentState = CHASE
	else:
		CurrentState = IDLE
		StateMachineTimeout.start(3)
		CurrentState = MOVE


# ---------------------------------------------------------------------------------

# Movement and Animations


func move(delta):
	position += dir * Speed * delta
	
	if dir.x > 0:
		animation.play("walk")
		animation.flip_h = true
	elif dir.x < 0:
		animation.play("walk")
		animation.flip_h = false
	elif dir.y > 0:
		animation.play("walk")
	elif dir.y < 0:
		animation.play("walk")
	else:
		animation.play("idle")
	move_and_slide()

# ---------------------------------------------------------------------------------

# GUI Components

func Bars():
	HealthBar.value = Health

# Combat and Death Commands

func GiveChase():
	if playerchase:
		position += (player.position - position) / (Speed + 50)

func DetectionRadius(body):
	player = body
	playerchase = true


func DetectionRadiusExited(_body):
	player = null
	playerchase = false


func HitboxEntered(area):
	if area.is_in_group("RangedAttack") and Dying == false:
		Health -= TAMAKI.Damage
		TakeDamage = true
		CurrentState = HIT
		HitTimer.start(1)
		TakeDamage = false
	if Health <= 0 and Dying == false:
		Dying = true
		TAMAKI.currentxp += 50
		animation.play("death")
		DeathTimer.start(.5)


func DeathTimerTimeout():
	Dying = false
	queue_free()
