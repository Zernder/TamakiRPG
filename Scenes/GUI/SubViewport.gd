extends SubViewport


@onready var camera = $Camera2D
@export var player: CharacterBody2D


func _process(_delta):
	camera.global_position = player.global_position
