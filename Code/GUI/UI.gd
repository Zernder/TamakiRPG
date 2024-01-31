extends CanvasLayer
class_name GUI

const TAMAKI = preload("res://Code/Resources/Tamaki_stats.tres")

@onready var healthbarlabel = $HealthbarLabel
@onready var HBar = $Healthbar
@onready var LevelLabel = $LevelLabel
@onready var xpbar = $XPBar

func _ready():
	TAMAKI.currentxp = 0


func _process(_delta):
	Bars()
	Labelled()
	LevelUp()

func _physics_process(delta):
	pass


func Labelled():
	healthbarlabel.text = "Health: " + str(TAMAKI.Health)
	LevelLabel.text = "Level " + str(TAMAKI.Level)

func Bars():
	HBar.value = TAMAKI.Health
	HBar.max_value = TAMAKI.MaxHealth
	xpbar.value = TAMAKI.currentxp



func LevelUp():
	if TAMAKI.currentxp >= TAMAKI.requiredxp:
		print("Leveling Up!")
		var Level = TAMAKI.Level
		TAMAKI.overallexp += TAMAKI.currentxp
		TAMAKI.currentxp = 0
		TAMAKI.requiredxp = 100 * Level
		xpbar.max_value = TAMAKI.requiredxp

		# Increment the level after updating required XP
		Level += 1
		TAMAKI.Level = Level
		# Increment Strength every level
		TAMAKI.Strength += 2
		# Increase MaxHealth and Damage for every level in Strength
		TAMAKI.MaxHealth += TAMAKI.Strength + 5
		TAMAKI.Damage += TAMAKI.Strength + 2

		# Increment Dexterity every level
		TAMAKI.Dexterity += 2
		# Increase MaxStamina for every level in Dexterity
		TAMAKI.MaxStamina += 10

		# Increment Intelligence every level
		TAMAKI.Intelligence += 2
		# Increase MaxMana for every level in Intelligence
		TAMAKI.MaxMana += 10

		print("Current Level:", TAMAKI.Level)
		print("Current XP:", TAMAKI.currentxp)
		print("Required XP:", TAMAKI.requiredxp)
		print("Max Health:", TAMAKI.MaxHealth)
		print("Max Stamina:", TAMAKI.MaxStamina)
		print("Max Mana:", TAMAKI.MaxMana)
		print("Damage: ", TAMAKI.Damage)

