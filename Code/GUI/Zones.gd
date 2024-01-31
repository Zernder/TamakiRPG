extends Node2D

@onready var Location
@onready var Menu

func _ready():
	pass

# Menu Items
func Menus():
	if Menu == 1:
		get_tree().change_scene_to_file("res://Scenes/GUI/MainMenu.tscn")

# World Locations
func Locations():
		get_tree().change_scene_to_file("res://Scenes/Locations/WorldMap.tscn")
