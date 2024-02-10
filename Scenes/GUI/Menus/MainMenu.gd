extends Control

@export var MainScene: PackedScene


func SinglePlayer():
	get_tree().change_scene_to_packed(MainScene)
	

func ExitGame():
	get_tree().quit()
