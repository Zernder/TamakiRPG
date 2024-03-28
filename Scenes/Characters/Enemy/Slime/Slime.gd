extends CharacterBody2D
class_name SlimeClass

@export var slimestats: EnemyClass
var ActionCooldown: bool = false
var damageTaken: bool = false
var dead: bool = false


func readyStats():
	slimestats.level = randi_range(1, 5)
	StatUpdate()
	randomize()

func processStats():
	slimestats.coordinates = global_position


func StatUpdate():
	for i in range(int(slimestats.level)):
		slimestats.Strength += 1
		slimestats.Constitution += 1
