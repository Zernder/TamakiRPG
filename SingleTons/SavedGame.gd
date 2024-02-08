extends Node

@onready var Tamaki = Global.TAMAKI

func SaveGame():
	var SavedGame: CharacterStats = CharacterStats.new()
	
	SavedGame.Health = Tamaki.Health
	SavedGame.MaxHealth = Tamaki.MaxHealth
	SavedGame.Stamina = Tamaki.Stamina
	SavedGame.MaxStamina = Tamaki.MaxStamina
	SavedGame.Mana = Tamaki.Mana
	SavedGame.MaxMana = Tamaki.MaxMana
	SavedGame.Level = Tamaki.Level
	SavedGame.Strength = Tamaki.Strength
	SavedGame.Dexterity = Tamaki.Dexterity
	SavedGame.Intelligence = Tamaki.Intelligence
	SavedGame.Speed = Tamaki.Speed
	SavedGame.Damage = Tamaki.Damage
	SavedGame.currentxp = Tamaki.currentxp
	SavedGame.requiredxp = Tamaki.requiredxp
	SavedGame.overallexp = Tamaki.overallexp

	# Save the game to a file
	ResourceSaver.save(SavedGame, "user://SaveGame.tres")

func LoadGame():
	var SavedGame: CharacterStats = load("user://SaveGame.tres") as CharacterStats
	
	# Assign the loaded values to Tamaki
	Tamaki.Health = SavedGame.Health
	Tamaki.MaxHealth = SavedGame.MaxHealth
	Tamaki.Stamina = SavedGame.Stamina
	Tamaki.MaxStamina = SavedGame.MaxStamina
	Tamaki.Mana = SavedGame.Mana
	Tamaki.MaxMana = SavedGame.MaxMana
	Tamaki.Level = SavedGame.Level
	Tamaki.Strength = SavedGame.Strength
	Tamaki.Dexterity = SavedGame.Dexterity
	Tamaki.Intelligence = SavedGame.Intelligence
	Tamaki.Speed = SavedGame.Speed
	Tamaki.Damage = SavedGame.Damage
	Tamaki.currentxp = SavedGame.currentxp
	Tamaki.requiredxp = SavedGame.requiredxp
	Tamaki.overallexp = SavedGame.overallexp
