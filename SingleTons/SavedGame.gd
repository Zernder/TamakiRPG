extends Node

const TAMAKI = preload("res://Resources/Characters/Tamaki_stats.tres")

func SaveGame():
	var SavedGame: CharacterStats = CharacterStats.new()
	
	SavedGame.Health = TAMAKI.Health
	SavedGame.MaxHealth = TAMAKI.MaxHealth
	SavedGame.Stamina = TAMAKI.Stamina
	SavedGame.MaxStamina = TAMAKI.MaxStamina
	SavedGame.Mana = TAMAKI.Mana
	SavedGame.MaxMana = TAMAKI.MaxMana
	SavedGame.Level = TAMAKI.Level
	SavedGame.Strength = TAMAKI.Strength
	SavedGame.Dexterity = TAMAKI.Dexterity
	SavedGame.Intelligence = TAMAKI.Intelligence
	SavedGame.Speed = TAMAKI.Speed
	SavedGame.Damage = TAMAKI.Damage
	SavedGame.currentxp = TAMAKI.currentxp
	SavedGame.requiredxp = TAMAKI.requiredxp
	SavedGame.overallexp = TAMAKI.overallexp

	# Save the game to a file
	ResourceSaver.save(SavedGame, "user://SaveGame.tres")

func LoadGame():
	var SavedGame: CharacterStats = load("user://SaveGame.tres") as CharacterStats
	
	# Assign the loaded values to TAMAKI
	TAMAKI.Health = SavedGame.Health
	TAMAKI.MaxHealth = SavedGame.MaxHealth
	TAMAKI.Stamina = SavedGame.Stamina
	TAMAKI.MaxStamina = SavedGame.MaxStamina
	TAMAKI.Mana = SavedGame.Mana
	TAMAKI.MaxMana = SavedGame.MaxMana
	TAMAKI.Level = SavedGame.Level
	TAMAKI.Strength = SavedGame.Strength
	TAMAKI.Dexterity = SavedGame.Dexterity
	TAMAKI.Intelligence = SavedGame.Intelligence
	TAMAKI.Speed = SavedGame.Speed
	TAMAKI.Damage = SavedGame.Damage
	TAMAKI.currentxp = SavedGame.currentxp
	TAMAKI.requiredxp = SavedGame.requiredxp
	TAMAKI.overallexp = SavedGame.overallexp
