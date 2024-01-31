extends CanvasLayer



func _ready():
	OtherOS()

# OS Controls
func OtherOS():
	if OS.get_name() != "Windows":
		show()


@onready var Location
@onready var Menu

# Menu Items
func Menus():
	if Menu == 1:
		get_tree().change_scene_to_file("res://Scenes/GUI/MainMenu.tscn")

# World Locations
func Locations():
	if Location == 1:
		get_tree().change_scene_to_file("res://Scenes/Locations/BeginnerForest.tscn")
	elif Location == 2:
		get_tree().change_scene_to_file("res://Scenes/Locations/SlimeFields.tscn")
	elif Location == 3:
		get_tree().change_scene_to_file("res://Scenes/Locations/WorldMap.tscn")
	elif Location == 4:
		get_tree().change_scene_to_file("res://Scenes/GUI/WeaponSelectionScreen.tscn")


# Main Menu
func Start():
	Location = 4
	call_deferred("Locations")

func ExitGame():
	get_tree().quit()


func BacktoMenu():
	Menu = 1
	call_deferred("Menus")


func OptionsButton():
	pass
