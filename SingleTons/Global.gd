extends Node2D


var Cooldown: bool
var direction: Vector2 = Vector2.ZERO
var LastDirection: Vector2 = Vector2.ZERO
var ActionCooldown: bool = false
var FamiliarSummoned: bool = false


var is2D: bool = true

func _process(_delta):
	WorldView()

func WorldView():
	if is2D == true:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	elif is2D == false:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
