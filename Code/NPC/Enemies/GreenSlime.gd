extends CharacterBody2D

# Green Slime Code

@export var Health = 6
@export var SlimeSpeed = 50
@onready var Anim = $AnimatedSprite2D
var CurrentState = IDLE
var dir = Vector2.RIGHT

const TAMAKI = preload("res://Code/Resources/Tamaki_stats.tres")

func _ready():
	Anim.play("idle")
	randomize()
	$Healthbar.max_value = Health
	
	
	
func _process(delta):
	statemachine(delta)
	HealthBar()

func _physics_process(_delta):
	GiveChase()


enum {
		IDLE,
		CHASE,
		MOVE
	}

func statemachine(delta):
	if Health > 0:
		match CurrentState:
			IDLE:
				Anim.play("idle")
				dir = choose([Vector2.RIGHT, Vector2.LEFT, Vector2.UP, Vector2.DOWN])
			MOVE:
				move(delta)
			CHASE:
				GiveChase()

func choose(array):
	array.shuffle()
	return array.front()


func StateReset():
	if playerchase == true:
		CurrentState = CHASE
	else:
		CurrentState = IDLE
		$StateReset.start(3)
		CurrentState = MOVE

func move(delta):
	position += dir * SlimeSpeed * delta
	
	if dir.x > 0:
		Anim.play("walk")
		Anim.flip_h = true
	elif dir.x < 0:
		Anim.play("walk")
		Anim.flip_h = false
	elif dir.y > 0:
		Anim.play("walk")
	elif dir.y < 0:
		Anim.play("walk")
	else:
		Anim.play("idle")
	move_and_slide()


func HealthBar():
	$Healthbar.value = Health

var Dying: bool = false

func HitboxEntered(area):
	if area.is_in_group("RangedAttack") and Dying == false:
		Health -= TAMAKI.Damage
		print(Health)
	if Health <= 0 and Dying == false:
		Dying = true
		TAMAKI.currentxp += 10
		Anim.play("death")
		$DeathTimer.start()


func DeathTimer():
	Dying = false
	queue_free()


var playerchase = false
var player = null

func GiveChase():
	if playerchase:
		position += (player.global_position - global_position) / SlimeSpeed

func DetectionRadius(body):
	player = body
	playerchase = true


func DetectionRadiusExited(_body):
	player = null
	playerchase = false
