extends Node

const TamakiStats = preload("res://Scenes/Characters/Tamaki/Tamaki2D/TamakiStats.tres")


func SaveGame():
	var SavedGame: CharacterStats = CharacterStats.new()

	SavedGame.Position = TamakiStats.Position

	SavedGame.Health = TamakiStats.Health
	SavedGame.MaxHealth = TamakiStats.MaxHealth

	SavedGame.Stamina = TamakiStats.Stamina
	SavedGame.MaxStamina = TamakiStats.MaxStamina

	SavedGame.Speed = TamakiStats.Speed
	SavedGame.Damage = TamakiStats.Damage

	SavedGame.Level = TamakiStats.Level
	SavedGame.currentxp = TamakiStats.currentxp
	SavedGame.requiredxp = TamakiStats.requiredxp
	SavedGame.overallexp = TamakiStats.overallexp

	# Save the game to a file
	ResourceSaver.save(SavedGame, "user://SaveGame.tres")

func LoadGame():
	var SavedGame: CharacterStats = load("user://SaveGame.tres") as CharacterStats


	TamakiStats.Position = SavedGame.Position

	TamakiStats.Health = SavedGame.Health
	TamakiStats.MaxHealth = SavedGame.MaxHealth
	TamakiStats.Stamina = SavedGame.Stamina
	TamakiStats.MaxStamina = SavedGame.MaxStamina

	TamakiStats.Speed = SavedGame.Speed
	TamakiStats.Damage = SavedGame.Damage

	TamakiStats.Level = SavedGame.Level
	TamakiStats.currentxp = SavedGame.currentxp
	TamakiStats.requiredxp = SavedGame.requiredxp
	TamakiStats.overallexp = SavedGame.overallexp
