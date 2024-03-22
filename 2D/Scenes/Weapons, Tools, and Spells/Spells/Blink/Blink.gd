extends Sprite2D

@onready var tilemap = get_tree().current_scene.find_child("Forest")
@export var TamakiStats: CharacterStats
@onready var blink = $"."

var canbeplaced: bool = true:
	set(value):
		canbeplaced = value
		if value:
			modulate = Color(1, 1, 1, 0.7)
		else:
			modulate = Color(1, 0.25, 0.25, 0.7)


func _physics_process(_delta):
	updatetile()
	position = get_global_mouse_position()


func updatetile():
	var tiledata = tilemap.get_cell_tile_data(0,tilemap.local_to_map(position))
	if tiledata:
		canbeplaced = tiledata.get_custom_data("Placeable")

func _input(_event):
		if canbeplaced == true and TamakiStats.stamina >= 2:
			var player = get_tree().current_scene.find_child("Tamaki")
			player.position = position
			TamakiStats.stamina -= 2
			queue_free()


func _on_timer_timeout():
	queue_free()
