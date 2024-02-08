extends Node2D

#Experience GD
@onready var Tamaki = Global.TAMAKI



func _process(_delta):
	LevelUp()

func LevelUp():
	if Tamaki.currentxp >= Tamaki.requiredxp:
		print("Leveling Up!")
		Tamaki.overallexp += Tamaki.currentxp
		Tamaki.currentxp = 0
		Tamaki.Level += 1
		
		# Calculate required XP for the next level using exponential growth
		Tamaki.requiredxp = calculateXPForLevel(Tamaki.Level)

		# Increment attributes based on level up
		Tamaki.Strength += 2
		Tamaki.MaxHealth += Tamaki.Strength + 5
		Tamaki.Damage += Tamaki.Strength + 2

		Tamaki.Dexterity += 2
		Tamaki.MaxStamina += 10

		Tamaki.Intelligence += 2
		Tamaki.MaxMana += 10

		# Print updated stats
		print("Current Level:", Tamaki.Level)
		print("Current XP:", Tamaki.currentxp)
		print("Required XP:", Tamaki.requiredxp)
		print("Max Health:", Tamaki.MaxHealth)
		print("Max Stamina:", Tamaki.MaxStamina)
		print("Max Mana:", Tamaki.MaxMana)
		print("Damage: ", Tamaki.Damage)



func calculateXPForLevel(level: int) -> int:
	# Define a base XP value for the first level
	var baseXP = 300
	# Define a growth factor for exponential growth
	var growthFactor = 1.5
	
	# Calculate the XP required for the given level using exponential growth
	var xpRequired = baseXP * (growthFactor ** (level - 1))
	
	return int(xpRequired)
