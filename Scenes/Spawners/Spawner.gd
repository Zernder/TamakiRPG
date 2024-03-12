extends Node2D

# Node refs

const BLUESLIME = preload("res://Scenes/Characters/Enemy/Blue Slime/BlueSlime.tscn")
const WARRIOR = preload("res://Scenes/Characters/Adventurer/Warrior/Warrior.tscn")

@export var SpawnedBlueSlimes: Node2D
@export var SpawnedWarriorSlimes: Node2D

# Enemy Count
@export var MaxBlueSlimes: int = 50
@export var MaxWarriorSlimes: int = 5


func SpawnWarriorSlime():
	var WarriorSlime = WARRIOR.instantiate()
	SpawnedWarriorSlimes.add_child(WarriorSlime)
	WarriorSlime.global_position = generateRandomPosition()

func SpawnBlueSlime():
	var BlueSlime = BLUESLIME.instantiate()
	SpawnedBlueSlimes.add_child(BlueSlime)
	BlueSlime.global_position = generateRandomPosition()


func generateRandomPosition() -> Vector2:
	# Define the boundaries for spawning
	var minX = 0 # Up
	var minY = 0 # Left
	var maxX = 1000 # Right
	var maxY = 580 # Down
	
	# Generate random coordinates within the defined boundaries
	var randomX = randf_range(minX, maxX)
	var randomY = randf_range(minY, maxY)
	
	# Return the randomly generated position
	return Vector2(randomX, randomY)

func SpawnTimer():
	if SpawnedBlueSlimes.get_child_count() < MaxBlueSlimes:
		SpawnBlueSlime()
		#print("Blue Slimes:" + str(SpawnedBlueSlimes.get_child_count()))
	if SpawnedWarriorSlimes.get_child_count() < MaxWarriorSlimes:
		SpawnWarriorSlime()
		#print("Green Slimes:" + str(SpawnedGreenSlimes.get_child_count()))
