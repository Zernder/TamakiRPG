extends Resource
class_name CharacterStats


#Strength:
	#Increases melee damage.
#Dexterity:
	#Increases ranged damage.
	#Affects ranged defense.
	#Contributes to stamina regeneration.
#Constitution:
	#Determines maximum health.
	#Affects health regeneration.
	#Influences melee defense.
#Intelligence:
	#Determines maximum mana.
	#Increases magic damage.
#Wisdom:
	#Contributes to mana regeneration.
	#Affects magic defense.

# Define the maximum speed

@export var Name: String
@export var Type: String
@export var Description: String
@export var level: float
@export var speed: float
@export var tspeed: float
@export var statpoints: int
@export var location: Vector2


var screenup = 0
# Define variables for basic character attributes
var health: float
var maxHealth: float
var meleeDamage: float
var meleeDefense: float
var healthRegeneration: float

var stamina: float
var maxStamina: float
var rangedDamage: float
var rangedDefense: float
var staminaRegeneration: float


var mana: float
var maxMana: float
var magicDamage: float
var magicDefense: float
var manaRegeneration: float

# Define variables for character attributes

# Define variables for character progression
var currentxp: float
var requiredxp: float
var overallexp: float


# Define variables for character stats
@export var Strength: float
@export var Dexterity: float
@export var Constitution: float
@export var Intelligence: float
@export var Wisdom: float

# NPC info
@export var DifficultyLevel: float
var XPValue: float
var GoldValue: float


func StatCheck():
	XPValue = (level + DifficultyLevel) * 5
	GoldValue = DifficultyLevel * 1.2

	maxHealth = ceil(Constitution * 1)
	maxStamina = ceil(Dexterity * 1)
	maxMana = ceil(Intelligence * 1)
	health = maxHealth
	stamina = maxStamina
	mana = maxMana


	# Damage Numbers
	meleeDamage = ceil(Strength * 0.2)
	rangedDamage = ceil(Dexterity * 0.2)
	magicDamage = ceil(Intelligence * 0.8)

	# Protection
	meleeDefense = ceil(Constitution * 0.2)
	rangedDefense = ceil(Constitution * 0.2)
	magicDefense = ceil(Constitution * 0.2)

	# Regeneration
	healthRegeneration = ceil(Constitution * 0.4)
	staminaRegeneration = ceil(Dexterity * 0.4)
	manaRegeneration = ceil(Wisdom * 0.4)


func StatUpdate():
	for i in range(int(level)):
		if Name == "Tamaki":
			Strength += 1
			Dexterity += 1
		if Type == "Slime":
			Strength += 0.5
			Constitution += 0.5
		if Type == "Warrior":
			Strength += 1
			Constitution += 1


# Function to gain experience points
func experienceGain() -> void:
	currentxp += XPValue
	overallexp += XPValue

	while currentxp >= requiredxp:
		LevelUp()


func calculateXPForLevel() -> int:
	# Define a base XP value for the first level
	var baseXP = level * 10
	# Define a growth factor for exponential growth
	var growthFactor = 3
	
	# Calculate the XP required for the given level using exponential growth
	requiredxp = baseXP * (growthFactor ** (level - 1))

	print("Level:", level)
	print("Required XP:", requiredxp)
	
	return int(requiredxp)


func LevelUp():
	if currentxp >= requiredxp:
		print("Leveling Up!")
		print("Current Stats: " + "\n Strength: " + str(Strength) + "\n Dexterity: " + str(Dexterity) + "\n Intelligence: " + str(Intelligence) + "\n Constitution: " + str(Constitution) + "\n Wisdom: " + str(Wisdom))
		overallexp += currentxp
		currentxp = 0
		level += 1
		print("New Level:", level)  # Add this line to check the new level
		statpoints += 2
		screenup = 1
		requiredxp = calculateXPForLevel()
		StatUpdate()
		StatCheck()
