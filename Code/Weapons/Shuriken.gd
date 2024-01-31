extends Area2D

@onready var Anim = $Spin
@onready var weapon = $"."
var speed = 300

func _ready():
	Anim.play("Spin")
	set_as_top_level(true)

var direction = Vector2.ZERO

func _process(delta):
	position += direction.normalized() * speed * delta

func set_direction(new_direction: Vector2) -> void:
	direction = new_direction.normalized()


func LeftScreen():
	queue_free()

func EnteredEnemy(area):
	if area.is_in_group("EnemyHitbox"):
		queue_free()

func TilesetEntered(_body):
	queue_free()


func ShurikenKiller():
	queue_free()
