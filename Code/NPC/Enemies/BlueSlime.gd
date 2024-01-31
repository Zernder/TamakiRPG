extends CharacterBody2D

# Blue Slime code

const TAMAKI = preload("res://Code/Resources/Tamaki_stats.tres")

@export var Health = 4
@export var SlimeSpeed = 50

@onready var Anim = $AnimatedSprite2D
var CurrentState = IDLE
var dir = Vector2.RIGHT
var is_dying: bool = false


func _ready():
	Anim.play("idle")
	randomize()
	$Healthbar.max_value = Health
	
	
func _process(delta):
	statemachine(delta)
	HealthBar()


enum {
		IDLE,
		NEWDIR,
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

func choose(array):
	array.shuffle()
	return array.front()
	
	
func StateReset():
	$DecisionTimer.wait_time = choose([0.5, 1, 3])
	CurrentState = choose([IDLE,MOVE])

func move(delta):
	position += dir * SlimeSpeed * delta
	
	if dir.x > 0:
		Anim.play("walk")
		Anim.flip_h = false
	elif dir.x < 0:
		Anim.play("walk")
		Anim.flip_h = true
	elif dir.y > 0:
		Anim.play("walk")
	elif dir.y < 0:
		Anim.play("walk")
	else:
		Anim.play("idle")
	move_and_slide()

func HealthBar():
	$Healthbar.value = Health

func HitboxEntered(area):
	if area.is_in_group("RangedAttack") and is_dying == false:
		Health -= TAMAKI.Damage
	if Health <= 0 and is_dying == false:
		is_dying = true
		TAMAKI.currentxp += 10
		print(TAMAKI.currentxp)
		Anim.play("death")
		$DeathTimer.start()

func DeathTimer():
	is_dying = false
	queue_free()

