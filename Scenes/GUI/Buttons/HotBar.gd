extends Control
class_name Hotbar

const tamastats = preload("res://Scenes/Characters/Tamaki/TamaStats.tres")
const blinkscene = preload("res://Scenes/Weapons, Tools, and Spells/Spells/Blink/blink.tscn")
const fireballscene = preload("res://Scenes/Weapons, Tools, and Spells/Spells/FireBall/Fireball.tscn")
const ShurikenScene = preload("res://Scenes/Weapons, Tools, and Spells/Weapons/Shuriken.tscn")



var cooldown = Timer.new()
@export var weaponmarker: Marker2D

func blinkpressed():
	var blink = blinkscene.instantiate()
	get_tree().current_scene.add_child(blink)
	blink.queue_free()


func fireballpressed():
	var fireball = fireballscene.instantiate()
	add_child(fireball)
	fireball.position = tamastats.coordinates


#func Familiarpressed():
	#var SlimePet = SummonFamiliarscene.instantiate()
	#get_tree().current_scene.add_child(SlimePet)

