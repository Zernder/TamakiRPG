extends CanvasLayer

var Location

func Start():
	Location = 1
	call_deferred("Travel")

func ExitGame():
	get_tree().quit()

# World Locations
func Travel():
	if Location == 1:
		get_tree().change_scene_to_file("res://Scenes/GUI/ClassSelect.tscn")
