extends Node2D


# Node refs
@onready var SpawnedSkeletons = $SpawnedSkeletons
@export var tilemap: TileMap

# Enemy stats
@export var MaxEnemies = 100
var SkeletonCount = 0 
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
		var skeleton = Global.Skeleton.instantiate()
		skeleton.position = tilemap.map_to_local(random_position) + Vector2(16, 16) / 2
		SpawnedSkeletons.add_child(skeleton)
		spawned = true

func _on_timer_timeout():
	if SkeletonCount < MaxEnemies:
		SpawnEnemy()
		SkeletonCount = SkeletonCount + 1
