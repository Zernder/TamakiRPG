extends CanvasLayer

@onready var Location
@export var PlayerScene: PackedScene
@export var WorldMap: Node2D

func WarriorSelected() -> void:
	SpawnPlayer("Warrior")


func RangerSelected() -> void:
	SpawnPlayer("Ranger")


func MageSelected() -> void:
	SpawnPlayer("Mage")


func Start():
	SpawnPlayer("Tamaki")


func SpawnPlayer(CharacterType: String) -> void:
	var stats := load("res://Code/Resources/%s_stats.tres" % CharacterType) as CharacterStats
	var player := PlayerScene.instantiate() as Player
	WorldMap.add_child(player)
	player.global_position = $"../Spawn".global_position
	queue_free()


