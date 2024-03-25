extends Node2D

@export var TamakiScene: PackedScene
@onready var main = $"."
@onready var spawn = $Spawn



#func _ready():
	#var tamaki = TamakiScene.instantiate()
	#main.add_child(tamaki)
	#tamaki.global_position = spawn.global_position


func ThirdDimensionEntered(body):
	if body.is_in_group("Tamaki"):
			call_deferred("ChangeScene")


func ChangeScene():
	get_tree().change_scene_to_file("res://Scenes/Locations/Main3D/Main3D.tscn")
