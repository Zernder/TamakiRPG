extends Node2D

var Cooldown = 0


# Enemy Preloads
@onready var BlueSlime = preload("res://Scenes/NPC's/Enemies/BlueSlime.tscn")
@onready var GreenSlime = preload("res://Scenes/NPC's/Enemies/GreenSlime.tscn")
@onready var Skeleton = preload("res://Scenes/NPC's/Enemies/Skeleton.tscn")



# Melee Weapon Preloads
var Katana = preload("res://Scenes/Weapons/Melee/Katana.tscn")
var CopperSwordScene = preload("res://Scenes/Weapons/Melee/CopperSword.tscn")


# Ranged Weapon Preloads
var WoodenBowScene = preload("res://Scenes/Weapons/Ranged/WoodenBow.tscn")
var RegularArrow = preload("res://Scenes/Weapons/Ranged/RegularArrow.tscn")
var ShurikenScene = preload("res://Scenes/Weapons/Ranged/Shuriken.tscn")
var CopperDaggerScene = preload("res://Scenes/Weapons/Ranged/Copperdagger.tscn")


@onready var MeleeWeaponSelected = "Katana"
@onready var RangedWeaponSelected = "Shuriken"

func MeleeWeaponChoice():
	match MeleeWeaponSelected:
		"Katana":
			return Katana.instantiate()
		"Copper Sword":
			return CopperSwordScene.instantiate()

func RangedWeaponChoice():
	match RangedWeaponSelected:
		"Shuriken":
			return ShurikenScene.instantiate()
		"Copper Dagger":
			return CopperDaggerScene.instantiate()
		"Bow and Arrow":
			return RegularArrow.instantiate()


