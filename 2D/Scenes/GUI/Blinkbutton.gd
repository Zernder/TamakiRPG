extends TextureButton

@export var skillnode: PackedScene

func _on_pressed():
	var skill = skillnode.instantiate()
	skill.global_position = get_global_mouse_position()
	get_tree().current_scene.call_deferred("add_child",skill)
