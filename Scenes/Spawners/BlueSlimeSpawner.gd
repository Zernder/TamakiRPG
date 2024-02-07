extends Node2D

# Node refs
@onready var BlueSlime = preload("res://Scenes/NPC's/Enemies/BlueSlime.tscn")
@export var SpawnedSlimes: Node2D
@export var tilemap: TileMap

# Enemy stats
@export var MaxSlimes = 100
var BlueSlimeCount = 0 
var rng = RandomNumberGenerator.new()

func SpawnEnemy():
	var attempts = 0
	var maxattempts = 100
	var spawned = false

	while not spawned and attempts < maxattempts:
		# Randomly select a position on the map
		var random_position = Vector2(
			rng.randi() % tilemap.get_used_rect().size.x,
			rng.randi() % tilemap.get_used_rect().size.y
		)
		# Spawn blueslime
		var blueslime = BlueSlime.instantiate()
		blueslime.position = tilemap.map_to_local(random_position) + Vector2(16, 16) / 2
		SpawnedSlimes.add_child(blueslime)
		spawned = true

func _on_timer_timeout():
	if BlueSlimeCount < MaxSlimes:
		SpawnEnemy()
		BlueSlimeCount = BlueSlimeCount + 1
