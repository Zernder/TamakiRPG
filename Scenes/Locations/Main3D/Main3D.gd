extends Node3D


func _ready():
	Global.is2D = false



func _on_area_3d_body_entered(body):
	if body.is_in_group("Tamaki"):
		call_deferred("ChangeScene")

func ChangeScene():
	get_tree().change_scene_to_file("res://Scenes/GUI/Main2D.tscn")
