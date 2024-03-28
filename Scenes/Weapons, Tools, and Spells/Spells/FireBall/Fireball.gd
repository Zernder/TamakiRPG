extends Node2D

@onready var anim = $AnimatedSprite2D

const tamastats = preload("res://Scenes/Characters/Tamaki/TamaStats.tres")
const blinkscene = preload("res://Scenes/Weapons, Tools, and Spells/Spells/Blink/blink.tscn")
const fireballscene = preload("res://Scenes/Weapons, Tools, and Spells/Spells/FireBall/Fireball.tscn")
const ShurikenScene = preload("res://Scenes/Weapons, Tools, and Spells/Weapons/Shuriken.tscn")


var speed = 750
var direction = Global.direction
var lastdirection = Global.LastDirection

func _ready():
	set_as_top_level(true)


func _physics_process(delta):
	fireballOne(delta)


func fireballOne(delta):
	if tamastats.mana >= 5:
		rotation = Global.direction.angle()
		direction = Global.LastDirection
		position += direction.normalized() * speed * delta
		anim.play("idle")
		tamastats.mana -= 5


#func EnteredEnemy(area):
	#if area.is_in_group("EnemyHitbox"):
		#queue_free()
	#if area.is_in_group("TamakiHitbox"):
		#pass
#
#func TilesetEntered(body):
	#queue_free()
#
#func LifespanEnded():
	#queue_free()
