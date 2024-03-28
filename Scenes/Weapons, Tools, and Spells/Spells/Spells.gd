extends Control
class_name Spells

@onready var tilemap = get_tree().current_scene.find_child("Forest")
@onready var player = get_tree().current_scene.find_child("Tamaki")
var casting: bool = false
var speed = 250
var direction = Global.direction
var lastdirection = Global.LastDirection

const tamastats = preload("res://Scenes/Characters/Tamaki/TamaStats.tres")
const BLINK = preload("res://Scenes/Weapons, Tools, and Spells/Spells/Blink/blink.tscn")
const fireballscene = preload("res://Scenes/Weapons, Tools, and Spells/Spells/FireBall/Fireball.tscn")
const ShurikenScene = preload("res://Scenes/Weapons, Tools, and Spells/Weapons/Shuriken.tscn")

