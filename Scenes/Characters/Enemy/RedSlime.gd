extends CharacterBody2D

@export var Stats: GameStats
@onready var TamakiStats = Global.TamakiStats
@onready var BlueSlime = Global.BlueslimeStats
@onready var RedSlime = Global.RedSlimeStats
@onready var Warrior = Global.WarriorStats

var Katana = Global.KatanaData
var Shuriken = Global.ShurikenData



@onready var AnimPlayer = $AnimationPlayer
var direction = Vector2.RIGHT
var lastDirection: Vector2 = Vector2.ZERO

# Combat Variables
var Chase: bool = false
var ActionCooldown: bool = false
var damageTaken: bool = false
var dead: bool = false

# State Machine
var currentState = IDLE


func _ready():
	Stats.level = randi_range(1, 3)
	Stats.StatUpdate()
	Stats.StatCheck()
	randomize()
	$UI/Name.text = Stats.Name + " " + "\n" + "Level: " + str(Stats.level)


func _process(delta):
	statemachine(delta)
	Stats.location = global_position
	$UI/Healthbar.value = Stats.health
	$UI/Healthbar.max_value = Stats.maxHealth

# ------------------------------- State Machine Code ---------------------------------------------

enum {
		IDLE,
		CHASE,
		MOVE,
	}

func statemachine(delta):
	if Stats.health > 0:
		match currentState:
			IDLE:
				AnimPlayer.play("idleright")
				direction = choose([Vector2.RIGHT, Vector2.LEFT, Vector2.UP, Vector2.DOWN])
			MOVE:
				move(delta)
			CHASE:
				AnimPlayer.play("walkright")
				GiveChase()


func choose(array):
	array.shuffle()
	return array.front()


func StateReset():
	if Chase == true:
		currentState = CHASE
	else:
		if currentState == IDLE:
			currentState = MOVE
		else:
			currentState = IDLE


# -------------------------------------# Movement #-----------------------------------------------------------------#

func move(delta):
	var collision = move_and_collide(direction * Stats.speed * delta)
	if collision:
		direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	if direction.x > 0:
		AnimPlayer.play("walkleft")
	elif direction.x < 0:
		AnimPlayer.play("walkright")
	elif direction.y > 0:
		AnimPlayer.play("walkright")
	elif direction.y < 0:
		AnimPlayer.play("walkright")
	else:
		AnimPlayer.play("idleright")

# -------------------------------------------# Combat #-------------------------------------------------------------#


var targetPosition
var bodytype
func DetectionBoxEntered(body):
	if body.is_in_group("Tamaki"):
		print(body)
		bodytype = "Tamaki"
		Chase = true
	elif body.is_in_group("Warrior"):
		print(body)
		bodytype = "Warrior"
		Chase = true

func GiveChase():
	if currentState == CHASE:
		if bodytype == "Tamaki":
			targetPosition = TamakiStats.location
		if bodytype == "Warrior":
			targetPosition = Warrior.location
		var directionToTarget = (targetPosition - global_position).normalized()
		var distanceToTarget = targetPosition.distance_to(global_position)
		var minAttackDistance = 6 # Adjust this value as neede

		if distanceToTarget > minAttackDistance:
			# Move towards the target only if the dddistance is greater than the minimum attack distance
			var chaseSpeed = 20
			position += directionToTarget * chaseSpeed * get_process_delta_time()


func DetectionBoxExited(body):
		Chase = false

func DamageBoxEntered(area):
	if area.is_in_group("TamakiHitbox"):
		TamakiStats.health -= (Stats.meleeDamage - clamp(TamakiStats.meleeDefense, 0, Stats.meleeDamage))

func HitboxEntered(area):
	if area.is_in_group("Melee"):
		if damageTaken == false and dead == false:
			Stats.health -= (TamakiStats.meleeDamage + Katana.BaseDamage - Stats.meleeDefense)
	if area.is_in_group("Ranged"):
		if damageTaken == false and dead == false:
			Stats.health -= (TamakiStats.rangedDamage + Shuriken.BaseDamage - Stats.rangedDefense)
	if area.is_in_group("Magic"):
		if damageTaken == false and dead == false:
			Stats.health -= (TamakiStats.magicDamage - Stats.magicDefense)


	damageTaken = true
	Stats.speed -= 10
	AnimPlayer.play("hit")
	$Timers/HitTimer.start(.2)

	if Stats.health <= 0 and dead == false:
		dead = true
		AnimPlayer.play("hit")
		$Timers/DeathTimer.start(.5)
		if area.is_in_group("Melee") or area.is_in_group("Ranged"):
			TamakiStats.currentxp += Stats.XPValue


func HitTimeout():
	damageTaken = false
	Stats.speed += 10


func DeathTimerTimeout():
	dead = false
	queue_free()

func HealthRegen():
	if Stats.health < Stats.maxHealth:
		Stats.health += Stats.healthRegeneration
		if Stats.health > Stats.maxHealth:
			Stats.health = Stats.maxHealth



func StaminaRegen():
	if Stats.stamina < Stats.maxStamina:
		Stats.stamina += Stats.staminaRegeneration
		if Stats.stamina > Stats.maxStamina:
			Stats.stamina = Stats.maxStamina

func MagicRegen():
	if Stats.mana < Stats.maxMana:
		Stats.mana += Stats.manaRegeneration
		if Stats.mana > Stats.maxMana:
			Stats.mana = Stats.maxMana

func RegenTimer():
	HealthRegen()
	StaminaRegen()
	MagicRegen()
