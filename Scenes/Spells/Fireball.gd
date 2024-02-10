extends Area2D

@onready var weapon = $"."
var speed = 300

func _ready():
	$Lifespan.start(2)
	set_as_top_level(true)

var direction = Vector2.ZERO

func _process(delta):
	position += direction.normalized() * speed * delta

func set_direction(new_direction: Vector2) -> void:
	direction = new_direction.normalized()


func EnteredEnemy(area):
	if area.is_in_group("EnemyHitbox"):
		queue_free()
	if area.is_in_group("TamakiHitbox"):
		queue_free()

func TilesetEntered(_body):
	queue_free()

func LifespanEnded():
	queue_free()
