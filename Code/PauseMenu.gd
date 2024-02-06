extends Node2D


@onready var PauseMenu = $"."

func ResumePressed():
	PauseMenu.hide()
	get_tree().paused = false

func SavePressed():
	SavedGame.SaveGame()
	PauseMenu.hide()
	get_tree().paused = false

func LoadPressed():
	SavedGame.LoadGame()
	PauseMenu.hide()
	get_tree().paused = false


func OptionsPressed():
	pass # Replace with function body.


func ExitToMenuPressed():
	get_tree().quit()
