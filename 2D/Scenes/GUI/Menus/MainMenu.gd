extends Control

@export var MainScene: PackedScene
@export var Tutorial: PackedScene


func SinglePlayer():
	get_tree().change_scene_to_packed(MainScene)
	

func ExitGame():
	get_tree().quit()


func _on_tutorial_pressed():
	get_tree().change_scene_to_packed(MainScene)


func _on_controls_pressed():
	$MainMenu.hide()
	$Controls.show()


func _on_back_pressed():
	$MainMenu.show()
	$Controls.hide()


func _on_options_pressed():
	pass # Replace with function body.
