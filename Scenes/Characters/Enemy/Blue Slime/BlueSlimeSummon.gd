extends CharacterBody2D


@export var Stats: CharacterStats
@export var TamakiStats: CharacterStats
@onready var player = get_tree().current_scene.find_child("Tamaki")
@onready var enemyblueslime = get_tree().current_scene.find_child("BlueSlime")
var Katana = "res://2D/Scenes/Weapons, Tools, and Spells/Weapons/Katana.tscn"
var Shuriken = "res://2D/Scenes/Weapons, Tools, and Spells/Weapons/Shuriken.tscn"


@onready var AnimPlayer = $AnimationPlayer
var direction = Vector2.RIGHT
var lastDirection: Vector2 = Vector2.ZERO


# Combat Variables
var Chase: bool = false
var Follow: bool = false
var ActionCooldown: bool = false
var damageTaken: bool = false
var dead: bool = false


# State Machine
var currentState = IDLE

func _ready():
	Stats.StatUpdate()
	Stats.StatCheck()
	randomize()
	$UI/Name.text = Stats.Name + " " + "\n" + "Level: " + str(Stats.level)


func _process(delta):
	Arrayprocess()
	statemachine(delta)
	Stats.location = global_position
	$UI/Healthbar.value = Stats.health
	$UI/Healthbar.max_value = Stats.maxHealth
	Stats.level = TamakiStats.level

func _physics_process(_delta):
	Animations()
# ------------------------------- State Machine Code ---------------------------------------------


enum {
		IDLE,
		FOLLOW,
		ATTACK,
	}

func statemachine(_delta):
	if Stats.health > 0:
		match currentState:
			IDLE:
				AnimPlayer.play("idleright")
			FOLLOW:
				FollowSummoner()
			ATTACK:
				AnimPlayer.play("walkright")
				AttackEnemies()

func StateReset():
	if Chase == true:
		currentState = ATTACK
	else:
		currentState = FOLLOW

# -------------------------------------# Movement #-----------------------------------------------------------------#

func Animations():
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

var minAttackDistance = 1
var minFollowDistance = 20
var enemyPosition
var summonerPosition


func FollowSummoner():
	summonerPosition = player.position
	if currentState == FOLLOW:
		var directionToSummoner = (summonerPosition - global_position).normalized()
		var distanceToSummoner = global_position.distance_to(summonerPosition)  # Calculate distance
		if distanceToSummoner > minFollowDistance:
			position += directionToSummoner * Stats.speed * get_process_delta_time()


func AttackEnemies():
	enemyPosition = Stats.location
	if currentState == ATTACK:
		var directionToEnemy = (enemyPosition - global_position).normalized()
		var distanceToEnemy = global_position.distance_to(enemyPosition)  # Calculate distance
		if distanceToEnemy > minAttackDistance:
			position += directionToEnemy * Stats.speed * get_process_delta_time()


var EnemyLocations = []

func Arrayprocess():
	for i in EnemyLocations:
		enemyPosition = i


func DetectionBoxEntered(body):
	if body.is_in_group("BlueSlime"):
		EnemyLocations.append(body.position)
		Chase = true

func DetectionBoxExited(body):
		EnemyLocations.erase(body.position)
		Chase = false

func DamageBoxEntered(area):
	pass


func HitboxEntered(_area):
	pass


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
