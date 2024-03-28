extends ThrownWeapons

@onready var player = get_tree().current_scene.find_child("Tamaki")
@onready var ShurikenTimeout = $ShurikenTimeout


func _ready():
	ShurikenTimeout.start(0.6)
	set_as_top_level(true)

func _physics_process(delta):
	ShurikenOne(delta)

func ShurikenOne(delta):
	rotation = Global.direction.angle()
	direction = Global.LastDirection
	position += direction.normalized() * speed * delta
	rotate(rotationSpeed * delta) 


func DestroyShuriken(body):
	queue_free()


func EnemyHit(area):
	if area.is_in_group("BlueSlimeHitbox"):
		queue_free()


func DestroyShurikenV():
	queue_free()
