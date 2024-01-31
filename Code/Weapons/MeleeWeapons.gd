extends Node2D

@onready var Anim = $AnimationPlayer
@onready var weapon = $"."
var speed = 100

func _ready():
	set_as_top_level(true)
	

func EnteredEnemy(area):
	if area.is_in_group("EnemyHitbox"):
		weapon.queue_free()

func TilesetEntered(_body):
	weapon.queue_free()
	
func Swing():
	pass
