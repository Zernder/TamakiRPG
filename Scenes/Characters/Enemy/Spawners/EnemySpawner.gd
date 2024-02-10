extends Node2D

# Node refs
const BlueSlimeScene = preload("res://Scenes/Characters/Enemy/BlueSlime.tscn")
const RedSlimeScene = preload("res://Scenes/Characters/Enemy/RedSlime.tscn")
const WarriorSlimeScene = preload("res://Scenes/Characters/Adventurer/Warrior.tscn")


@export var SpawnedBlueSlimes: Node2D
@export var SpawnedRedSlimes: Node2D
@export var SpawnedWarriorSlimes: Node2D

# Enemy Count
@export var MaxBlueSlimes: int = 50
@export var MaxRedSlimes: int = 5
@export var MaxWarriorSlimes: int = 5


func SpawnWarriorSlime():
	var WarriorSlime = WarriorSlimeScene.instantiate()
	SpawnedWarriorSlimes.add_child(WarriorSlime)
	WarriorSlime.global_position = generateRandomPosition()

func SpawnBlueSlime():
	var BlueSlime = BlueSlimeScene.instantiate()
	SpawnedBlueSlimes.add_child(BlueSlime)
	BlueSlime.global_position = generateRandomPosition()

#func SpawnRedSlime():
	#var RedSlime = RedSlimeScene.instantiate()
	#SpawnedRedSlimes.add_child(RedSlime)
	#RedSlime.global_position = generateRandomPosition()


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
	#if SpawnedRedSlimes.get_child_count() < MaxRedSlimes:
		#SpawnRedSlime()
		##print("Green Slimes:" + str(SpawnedGreenSlimes.get_child_count()))
	if SpawnedWarriorSlimes.get_child_count() < MaxWarriorSlimes:
		SpawnWarriorSlime()
		#print("Green Slimes:" + str(SpawnedGreenSlimes.get_child_count()))
