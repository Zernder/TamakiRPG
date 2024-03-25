extends Sprite2D

@onready var tilemap = get_tree().current_scene.find_child("Forest")
@onready var player = get_tree().current_scene.find_child("Tamaki")
@export var TamakiStats: CharacterStats
@onready var blink = $"."


func _input(_event):
	if TamakiStats.stamina >= 2:
		position = player.position
		var target_position = position + Global.LastDirection * 100
		get_tree().create_tween().tween_property(player, "modulate", Color(1, 1, 1, 0.4), 0.4)
		get_tree().create_tween().tween_property(player, "position", target_position, 0.8)
		TamakiStats.stamina -= 2
		queue_free()

func _on_timer_timeout():
	queue_free()
