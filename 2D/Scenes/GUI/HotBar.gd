extends HBoxContainer

@export var player: CharacterBody2D
@export var TamakiStats: CharacterStats


@export var blinkscene: PackedScene
@export var fireballscene: PackedScene

var casting: bool = false

func blinkpressed():
	if TamakiStats.stamina >= 2 and casting == false:
		player.casting(0.2)
		casting = true
		await  player.find_child("Cast").timeout
		var blink = blinkscene.instantiate()
		blink.position = get_global_mouse_position()
		get_tree().current_scene.call_deferred("add_child",blink)
		casting = false


func fireballpressed():
	if TamakiStats.mana >= 5:
		player.casting(1)
		casting = true
		await  player.find_child("Cast").timeout
		var fireball = fireballscene.instantiate()
		fireball.global_position = player.global_position
		get_tree().current_scene.call_deferred("add_child",fireball)
		casting = false



