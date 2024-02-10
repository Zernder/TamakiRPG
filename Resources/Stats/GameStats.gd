extends Resource
class_name GameStats

@export var Name: String
@export var Type: String
@export var level: float
@export var DifficultyLevel: float
@export var speed: float
@export var location: Vector2


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
var Strength: float
var Dexterity: float
var Constitution: float
var Intelligence: float
var Wisdom: float

# NPC info
var XPValue: float
var GoldValue: float

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
	#Affects magic defense.
	#Contributes to mana regeneration.
#Wisdom:
	#Contributes to mana regeneration.

# Define the maximum speed

func StatCheck():

	requiredxp = 100
	# Health, Stamina, and Mana
	maxHealth = ceil(Constitution * 5)
	maxStamina = ceil(Dexterity * 5)
	maxMana = ceil(Intelligence * 5)
	health = maxHealth
	stamina = maxStamina
	mana = maxMana


	# Damage Numbers
	meleeDamage = ceil((Strength * 0.5) * 5)
	rangedDamage = ceil((Dexterity * 0.5) * 5)
	magicDamage = ceil((Intelligence * 0.5) * 5)


	# Regeneration
	healthRegeneration = ceil(Constitution * 0.4)
	staminaRegeneration = ceil(Dexterity * 0.4)
	manaRegeneration = ceil(Wisdom * 0.4)


	# Protection
	meleeDefense = ceil(Constitution / 2)
	rangedDefense = ceil(Dexterity / 2)
	magicDefense = ceil(Intelligence / 2)


	# Monster Drops
	XPValue = DifficultyLevel + level * 20
	GoldValue = level * 2

func StatUpdate():
	for i in range(int(level)):
		if Name == "Tamaki":
			Strength += 1.5
			Dexterity += 4
			Constitution += 1.5
			Intelligence += 2
			Wisdom += 2
			#print("Player Stats:")
			#print(Strength)
			#print(Dexterity)
			#print(Constitution)
			#print(Intelligence)
			#print(Wisdom)
		if Type == "Blue Slime":
			Strength += 1
			Dexterity += 1
			Constitution += 1
			Intelligence += 1
			Wisdom += 1
		#if Type == "Red Slime":
			#Strength += 1
			#Dexterity += 1
			#Constitution += 1
			#Intelligence += 1
			#Wisdom += 1
		if Type == "Warrior":
			Strength += 2
			Dexterity += 1
			Constitution += 2
			Intelligence += 1
			Wisdom += 1
			#print("SlimeWarrior Stats:")
			#print(Strength)
			#print(Dexterity)
			#print(Constitution)
			#print(Intelligence)
			#print(Wisdom)


# Function to gain experience points
func experienceGain() -> void:
	currentxp += XPValue
	overallexp += XPValue

	while currentxp >= requiredxp:
		LevelUp()


func calculateXPForLevel() -> int:
	# Define a base XP value for the first level
	var baseXP = 100
	# Define a growth factor for exponential growth
	var growthFactor = 3
	
	# Calculate the XP required for the given level using exponential growth
	requiredxp = baseXP * (growthFactor ** (level - 1))
	
	return int(requiredxp)

func LevelUp():
	if currentxp >= requiredxp:
		print("Leveling Up!")
		print("Current Stats: " + "\n Strength: " + str(Strength) + "\n Dexterity: " + str(Dexterity) + "\n Intelligence: " + str(Intelligence) + "\n Constitution: " + str(Constitution) + "\n Wisdom: " + str(Wisdom))
		overallexp += currentxp
		currentxp = 0
		level += 1
		Strength += 1 
		Dexterity += 2
		Constitution += 2
		Intelligence += 1
		Wisdom += 1
		StatCheck()
		
		# Calculate required XP for the next level using exponential growth
		requiredxp = calculateXPForLevel()
