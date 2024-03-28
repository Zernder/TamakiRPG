extends Resource
class_name CharacterClass


@export var Name: String
@export var classtype: String
@export var level: float

@export var Strength: float
@export var Dexterity: float
@export var Constitution: float
@export var Intelligence: float
@export var Wisdom: float
@export var Charisma: float

var speed: float
var coordinates: Vector2
var leftclick: bool
var rightclick: bool

var health: float
var maxHealth: float
var healthRegeneration: float

var stamina: float
var maxStamina: float
var staminaRegeneration: float

var mana: float
var maxMana: float
var manaRegeneration: float

var meleeDamage: float
var rangedDamage: float
var magicDamage: float

var meleeDefense: float
var rangedDefense: float
var magicDefense: float

func statCheck() -> void:
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
	healthRegeneration = ceil(Constitution * 0.05)
	staminaRegeneration = ceil(Dexterity * 0.5)
	manaRegeneration = ceil(Wisdom * 0.08)


func StartRegeneration():
	HealthRegen()
	StaminaRegen()
	ManaRegen()

func HealthRegen():
	if health < maxHealth:
		health += healthRegeneration
		if health > maxHealth:
			health = maxHealth

func StaminaRegen():
	if stamina < maxStamina:
		stamina += staminaRegeneration
		if stamina > maxStamina:
			stamina = maxStamina

func ManaRegen():
	if mana < maxMana:
		mana += manaRegeneration
		if mana > maxMana:
			mana = maxMana



@export var currentxp: float
@export var requiredxp: float
@export var overallexp: float
@export var statpoints: float
var characterscreen: bool = false
var levelled: bool = false


# Function to gain experience points
func experienceGain(Name) -> void:
	currentxp += Name.xpValue
	overallexp += Name.xpValue
	while currentxp >= requiredxp:
		LevelUp()


func calculateXPForLevel() -> int:
	var baseXP = level * 10 # Define a base XP value for the first level
	var growthFactor = 3 # Define a growth factor for exponential growth
	requiredxp = baseXP * (growthFactor ** (level - 1)) # Calculate the XP required for the given level using exponential growth
	return int(requiredxp)


func LevelUp():
	if currentxp >= requiredxp:
		overallexp += currentxp
		currentxp = 0
		characterscreen = true
		requiredxp = calculateXPForLevel()

