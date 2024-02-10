extends Area2D


@onready var weapon = $"."
var speed = 300
var rotation_speed = 750  # Adjust the rotation speed as needed

func _ready():
	$ShurikenKiller.start()
	set_as_top_level(true)

var direction = Vector2.ZERO

func _process(delta):
	position += direction.normalized() * speed * delta

	# Rotate the shuriken
	rotate(rotation_speed * delta)  # Rotate the shuriken by rotation_speed degrees per second

func set_direction(new_direction: Vector2) -> void:
	direction = new_direction.normalized()


func LeftScreen():
	queue_free()

func EnteredEnemy(area):
		queue_free()

func TilesetEntered(_body):
	queue_free()


func ShurikenKiller():
	queue_free()
