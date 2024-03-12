extends Node2D

@export var TamakiScene: PackedScene
@onready var main = $"."
@onready var spawn = $Spawn



func _ready():
	var player = TamakiScene.instantiate()
	main.add_child(player)
	player.global_position = spawn.global_position
