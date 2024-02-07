extends CanvasLayer

@onready var Location
@export var PlayerScene: PackedScene
@export var WorldMap: Node2D

func Start():
	SpawnPlayer("Tamaki")


func SpawnPlayer(_CharacterType: String) -> void:
	var _stats := load("res://Resources/Characters/Tamaki_stats.tres") as CharacterStats
	var player := PlayerScene.instantiate() as Player
	WorldMap.add_child(player)
	player.global_position = $"../Spawn".global_position
	queue_free()


