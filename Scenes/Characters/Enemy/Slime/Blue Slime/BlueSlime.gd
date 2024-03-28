extends SlimeClass
class_name Blueslime

#--------------------------------# ALL VARIABLES #---------------------------------------------#


# Combat Variables
@onready var nametag = $UI/VBoxContainer/Nametag
@onready var leveltag = $UI/VBoxContainer/LevelTag
@onready var healthbar = $UI/VBoxContainer/Healthbar

# Timers
@onready var deathtimer = $Timers/DeathTimer
@onready var hittimer = $Timers/HitTimer
@onready var regeneration = $Timers/Regeneration


func _ready():
	readyStats()
	ReadyGUI()
	StatUpdate()
	currentState = IDLE


func _process(delta):
	processStats()
	ProcessGui()
	Animations()
	#statemachine(delta)
	move_and_slide()


# -------------------------------------# Movement #--------------------------------------------#


@onready var AnimPlayer = $AnimationPlayer
func Animations():
	if Global.direction.x > 0:
		AnimPlayer.play("walkleft")
	elif Global.direction.x < 0:
		AnimPlayer.play("walkright")
	elif Global.direction.y > 0:
		AnimPlayer.play("walkright")
	elif Global.direction.y < 0:
		AnimPlayer.play("walkright")
	else:
		AnimPlayer.play("idleright")




# ------------------------------------- GUI Code --------------------------------------------#

func ReadyGUI():
	slimestats.Name = "Blue Slime"
	nametag.text = slimestats.Name
	leveltag.text = str(slimestats.level)

func ProcessGui():
	healthbar.value = slimestats.health
	healthbar.max_value = slimestats.maxHealth
	

# ------------------------------- State Machine Code ------------------------------------------#
@onready var statemachinetimer = $Timers/StateMachine
@onready var currentState

enum { IDLE, MOVE,}


func statemachine(delta):
	if slimestats.health > 0:
		match currentState:
			IDLE:
				AnimPlayer.play("idleright")
				Global.direction = choose([Vector2.RIGHT, Vector2.LEFT, Vector2.UP, Vector2.DOWN])
				Animations()
			MOVE:
				pass


func choose(array):
	array.shuffle()
	return array.front()


#func StateReset():
	#if Chase == true:
		#currentState = CHASE
	#else:
		#if currentState == IDLE:
			#currentState = MOVE
		#else:
			#currentState = IDLE


# ------------------------------------# Combat #-----------------------------------------------#


#func GiveChase():
	#if currentState == CHASE:
			#var directionToTarget = (targetPosition - global_position).normalized()
			#var distanceToTarget = targetPosition.distance_to(global_position)
			#var minAttackDistance = 6
			#if distanceToTarget > minAttackDistance:
				#position += directionToTarget * Stats.speed * get_process_delta_time()


#func DamageBoxEntered(area):
	#if area.is_in_group("TamakiHitbox"):
		#tamastats.health -= meleeDamage


#func HitboxEntered(area):
	#if not damageTaken and not dead:
		#if area.is_in_group("Melee"):
			#var meleedamage = max(1, tamastats.meleeDamage - meleeDefense)
			#health -= meleedamage
		#if area.is_in_group("Ranged"):
			#var rangedamage = max(1, tamastats.rangedDamage - rangedDefense)
			#health -= rangedamage
		#if area.is_in_group("Magic"):
			#var magicdamage = max(1, tamastats.magicDamage - magicDamage)
			#health -= magicdamage
	#damageTaken = true
	#speed -= 10
	#AnimPlayer.play("hit")
	#hittimer.start(.2)
	#if health < 0 and dead == false:
		#dead = true
		#AnimPlayer.play("hit")
		#deathtimer.start(0.2)
		#if area.is_in_group("Melee") or area.is_in_group("Ranged") or area.is_in_group("Magic"):
			#tamaexp.currentxp += xpValue

func hitTimer():
	damageTaken = false
	slimestats.speed += 10
	regeneration.start(3)


func deathTimer():
	queue_free()
	dead = false


#func RegenTimer():
	#slimeregen.StartRegeneration()

