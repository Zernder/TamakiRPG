extends CharacterBody2D

@export var Stats: GameStats
@onready var TamakiStats = Global.TamakiStats
@onready var BlueSlimeStats = Global.BlueslimeStats
@onready var RedSlimeStats = Global.RedSlimeStats
var Katana = Global.KatanaData.BaseDamage
var Shuriken = Global.ShurikenData.BaseDamage


@onready var AnimPlayer = $AnimationPlayer
var direction = Vector2.RIGHT
var lastDirection: Vector2 = Vector2.ZERO

# Combat Variables
var Chase: bool = false
var damageTaken: bool = false
var dead: bool = false

# State Machine
var currentState = IDLE


func _ready():
	Stats.Name = "Warrior " + str(Stats.level)
	Stats.level = randi_range(1, 3)
	Stats.StatUpdate()
	Stats.StatCheck()
	randomize()
	$Gui/Name.text = Stats.Name + " " + "\n" + "Level: " + str(Stats.level)


func _process(delta):
	statemachine(delta)
	Stats.location = global_position
	$Gui/Healthbar.value = Stats.health
	$Gui/Healthbar.max_value = Stats.maxHealth

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
@onready var ActionCooldown: bool = false
var FireballCost: float = Global.FireballData.baseDamage


func GiveChase():
	if currentState == CHASE:
		var targetPosition = BlueSlimeStats.location
		var directionToTarget = (targetPosition - global_position).normalized()
		var distanceToTarget = targetPosition.distance_to(global_position)
		var minAttackDistance = 6 # Adjust this value as neede
		
		if distanceToTarget > minAttackDistance:
			# Move towards the target only if the dddistance is greater than the minimum attack distance
			var chaseSpeed = 20
			position += directionToTarget * chaseSpeed * get_process_delta_time()


func DetectionBoxEntered(body):
	if TamakiStats.Name == "Tamaki":
		print(body)
		Chase = true


func DetectionBoxExited(body):
	if TamakiStats.Name == "Tamaki":
		Chase = false

func DamageBoxEntered(area):
	if area.is_in_group("BlueslimeHitbox"):
		BlueSlimeStats.health -= (Stats.meleeDamage - BlueSlimeStats.meleeDefense)


func HitboxEntered(area):
	if area.is_in_group("Melee"):
		if damageTaken == false and dead == false:
			Stats.health -= (TamakiStats.meleeDamage + Katana - Stats.meleeDefense)
	if area.is_in_group("Ranged"):
		if damageTaken == false and dead == false:
			Stats.health -= (TamakiStats.rangedDamage + Shuriken - Stats.rangedDefense)
	if area.is_in_group("Magic"):
		if damageTaken == false and dead == false:
			Stats.health -= (TamakiStats.magicDamage - Stats.magicDefense)
	if area.is_in_group("BlueSlimeMelee"):
		if damageTaken == false and dead == false:
			Stats.health -= (BlueSlimeStats.meleeDamage - BlueSlimeStats.meleeDefense)


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
