extends Area2D

@onready var weapon = $"."
var speed = 300

func _ready():
	set_as_top_level(true)

var direction = Vector2.ZERO

func _process(delta):
	position += direction.normalized() * speed * delta

	# Ensure the arrow is always facing the firing direction
	if direction != Vector2.ZERO:
		rotation = direction.angle()

func set_direction(new_direction: Vector2) -> void:
	direction = new_direction.normalized()

func LeftScreen():
	queue_free()

func EnteredEnemy(area):
	if area.is_in_group("EnemyHitbox"):
		weapon.queue_free()

func TilesetEntered(_body):
	weapon.queue_free()
