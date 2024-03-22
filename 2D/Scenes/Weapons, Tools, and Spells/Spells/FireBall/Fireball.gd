extends Area2D

@export var TamakiStats: CharacterStats
@onready var weapon = $"."
var speed = 250
var direction = Vector2.ZERO

func _ready():
	$Lifespan.start(0.6)
	set_as_top_level(true)

func _process(delta):
	position += direction * speed * delta

func _input(_event):
	if TamakiStats.mana >= 5:
		var mouse_position = get_global_mouse_position()
		direction = (mouse_position - position).normalized()
		TamakiStats.mana -= 5

func EnteredEnemy(area):
	if area.is_in_group("EnemyHitbox"):
		queue_free()
	if area.is_in_group("TamakiHitbox"):
		pass

func TilesetEntered(_body):
	queue_free()

func LifespanEnded():
	weapon.queue_free()
