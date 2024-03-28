extends Spells



func _physics_process(delta):
	Blink()

func Blink():
		if tamastats.stamina >= 2:
			position = player.position
			var target_position = position + Global.LastDirection * 100
			get_tree().create_tween().tween_property(player, "modulate", Color(1, 1, 1, 0.4), 0.1)
			get_tree().create_tween().tween_property(player, "position", target_position, 0.2)
			tamastats.stamina -= 2
