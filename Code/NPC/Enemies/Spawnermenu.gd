extends Node2D


# Node refs
@onready var SpawnedSlimes = $SpawnedSlimes
@onready var tilemap = $"../TileMap"

# Enemy stats
@export var MaxEnemies = 10
var SlimeCount = 0 
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
		var mob = Global.BlueSlime.instantiate()
		mob.position = tilemap.map_to_local(random_position) + Vector2(16, 16) / 2
		SpawnedSlimes.add_child(mob)
		spawned = true

func _on_timer_timeout():
	if SlimeCount < MaxEnemies:
		SpawnEnemy()
		SlimeCount = SlimeCount + 1
