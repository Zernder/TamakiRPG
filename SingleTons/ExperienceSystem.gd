extends Node2D

#Experience GD
const TAMAKI = preload("res://Resources/Characters/Tamaki_stats.tres")



func _process(delta):
	LevelUp()

func LevelUp():
	if TAMAKI.currentxp >= TAMAKI.requiredxp:
		print("Leveling Up!")
		TAMAKI.overallexp += TAMAKI.currentxp
		TAMAKI.currentxp = 0
		TAMAKI.Level += 1
		
		# Calculate required XP for the next level using exponential growth
		TAMAKI.requiredxp = calculateXPForLevel(TAMAKI.Level)

		# Increment attributes based on level up
		TAMAKI.Strength += 2
		TAMAKI.MaxHealth += TAMAKI.Strength + 5
		TAMAKI.Damage += TAMAKI.Strength + 2

		TAMAKI.Dexterity += 2
		TAMAKI.MaxStamina += 10

		TAMAKI.Intelligence += 2
		TAMAKI.MaxMana += 10

		# Print updated stats
		print("Current Level:", TAMAKI.Level)
		print("Current XP:", TAMAKI.currentxp)
		print("Required XP:", TAMAKI.requiredxp)
		print("Max Health:", TAMAKI.MaxHealth)
		print("Max Stamina:", TAMAKI.MaxStamina)
		print("Max Mana:", TAMAKI.MaxMana)
		print("Damage: ", TAMAKI.Damage)



func calculateXPForLevel(level: int) -> int:
	# Define a base XP value for the first level
	var baseXP = 300
	# Define a growth factor for exponential growth
	var growthFactor = 1.5
	
	# Calculate the XP required for the given level using exponential growth
	var xpRequired = baseXP * (growthFactor ** (level - 1))
	
	return int(xpRequired)
