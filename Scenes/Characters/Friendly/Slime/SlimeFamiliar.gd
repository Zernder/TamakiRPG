extends SlimeClass
class_name SlimeFamiliar


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


# State Machine
var currentState = IDLE

func _ready():
	slimestats.level = randi_range(1, 5)
	StatUpdate()
	#slimexp.StatCheck()
	randomize()
	$UI/Name.text = slimestats.Name + " " + "\n" + "Level: " + str(slimestats.level)


func _process(delta):
	Arrayprocess()
	statemachine(delta)
	slimestats.coordinates = global_position
	$UI/Healthbar.value = slimestats.health
	$UI/Healthbar.max_value = slimestats.maxHealth

func _physics_process(_delta):
	Animations()
# ------------------------------- State Machine Code ---------------------------------------------


enum {
		IDLE,
		FOLLOW,
		ATTACK,
	}

func statemachine(_delta):
	if slimestats.health > 0:
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
			position += directionToSummoner * slimestats.speed * get_process_delta_time()


func AttackEnemies():
	enemyPosition = slimestats.coordinates
	if currentState == ATTACK:
		var directionToEnemy = (enemyPosition - global_position).normalized()
		var distanceToEnemy = global_position.distance_to(enemyPosition)  # Calculate distance
		if distanceToEnemy > minAttackDistance:
			position += directionToEnemy * slimestats.speed * get_process_delta_time()


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


#func HitboxEntered(area):
	#if area.is_in_group("BlueSlimeDamageBox"):
		#if not damageTaken and not dead:
			#var meleedamage = max(1, tamastats.meleeDamage - slimestats.meleeDefense)
			#slimestats.health -= meleedamage
#
	#damageTaken = true
	#slimestats.speed -= 10
	#AnimPlayer.play("hit")
	#$Timers/HitTimer.start(.2)
	#if slimestats.health < 0 and dead == false:
		#dead = true
		#AnimPlayer.play("hit")
		#$Timers/DeathTimer.start(.5)
		#if area.is_in_group("Melee") or area.is_in_group("Ranged"):
			#tamastats.currentxp += slimexp.XPValue


func HitTimeout():
	damageTaken = false
	slimestats.speed += 10


func DeathTimerTimeout():
	dead = false
	queue_free()


#func RegenTimer():
	#slimeregen.StartRegeneration()
