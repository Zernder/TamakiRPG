extends CharacterBody2D
class_name Tamaki


#-------------------------------# ALL VARIABLES #------------------------------------------#

@export var tamastats: CharacterClass
@onready var tamaki = $"."
@onready var blueslime = get_tree().current_scene.find_child("BlueSlime")

# Animations
@onready var animT = $AnimationTree
@onready var animP = %AnimationPlayer


var Swing : bool = false
var Throw : bool = false
var Sneak : bool = false
var Hit : bool = false


#-------------------------------# The Runtimes #-------------------------------------------#

func _ready():
	tamastats.speed = 60
	Global.is2D = true
	tamastats.statCheck()

func _process(_delta):
	tamastats.coordinates = position
	castbar.value = cast.wait_time - cast.time_left
	tamastats.LevelUp()


func _physics_process(_delta):
	Movement()
	UseWeapons()
	ExitGame()
	move_and_slide()

#------------------------------------# Movement #------------------------------------------#


func Movement():
	if Swing:
		velocity = Vector2.ZERO
		return
	else:
		Global.direction = Input.get_vector("ui_left","ui_right","ui_up","ui_down").normalized()

		if Global.direction != Vector2.ZERO and Swing == false:
			# Only allow movement in one of four directions
			if abs(Global.direction.x) > abs(Global.direction.y):
				Global.direction.y = 0
			else:
				Global.direction.x = 0

			velocity = Global.direction * tamastats.speed
			SetWalking(true)
			Global.LastDirection = Global.direction
			UpdateBlend()
		else:
			velocity = Vector2.ZERO
			SetWalking(false)


		## Adjust speed based on sprint and stealth mode
		#if Input.is_action_pressed("Sprint") and !StealthActive:
			#SprintActive = true
			#Tama.Speed = 150
			#Anim.speed_scale = 2
		#elif !StealthActive:
			#SprintActive = false
			#Tama.Speed = 120
			#Anim.speed_scale = 1.0
			#player.modulate = Color(1, 1, 1, 1)
			#$CollisionPolygon2D.disabled = false


#----------------------------------# Animation Blending #----------------------------------#


func SetWalking(value):
	animT["parameters/conditions/Walking"] = value
	animT["parameters/conditions/Idle"] = not value

func setSwing(value = false):
	Swing = value
	animT["parameters/conditions/Swing"] = value

func setThrow(value = false):
	Throw = value
	animT["parameters/conditions/Throw"] = value

func UpdateBlend():
	animT["parameters/Idle/blend_position"] = Global.direction
	animT["parameters/Walking/blend_position"] = Global.direction
	animT["parameters/Katana/blend_position"] = Global.direction
	animT["parameters/Shuriken/blend_position"] = Global.direction


#------------------------------------# Combat #--------------------------------------------#

# Weapons
const KatanaScene = preload("res://Scenes/Weapons, Tools, and Spells/Weapons/Katana.tscn")
const ShurikenScene = preload("res://Scenes/Weapons, Tools, and Spells/Weapons/Shuriken.tscn")
@onready var weaponmarker = %WeaponMarker
@onready var shurikens = $Weapons/Shurikens
@onready var castbar = $Weapons/Castbar

# Timers
@onready var weaponcooldown = $Timers/WeaponCooldown
@onready var cast = $Timers/Cast
@onready var regeneration = $Timers/Regeneration
@onready var damaged = $Timers/Damaged

func UseWeapons():
	if Input.is_action_just_pressed("Primary") and Global.ActionCooldown == false:
		setSwing(true)
		Global.ActionCooldown = true
		weaponcooldown.start(.5)
		await weaponcooldown.timeout
		Global.ActionCooldown = false
	# Throw Shuriken
	elif Input.is_action_pressed("Secondary") and Global.ActionCooldown == false and tamastats.stamina >= 2:
		setThrow(true)
		tamastats.stamina -= 2
		Global.ActionCooldown = true
		weaponcooldown.start(.2)
		var Shuriken = ShurikenScene.instantiate()
		add_child(Shuriken)
		Shuriken.position = self.position
		await weaponcooldown.timeout
		Global.ActionCooldown = false


func CastSpell(time = 1.0):
	castbar.max_value = time
	castbar.show()
	cast.wait_time = time
	cast.start()
	await cast.timeout
	castbar.hide()


func HitboxEntered(area):
	if area.is_in_group("BlueSlimeDamageBox") and !Hit:
			Hit = true
			animP.play("Damaged")
			damaged.start(1)
			tamastats.health -= (area.get_parent().get_parent().slimestats.meleeDamage - tamastats.meleeDefense)
			await damaged.timeout
			Hit = false
	if tamastats.health <= 0:
		get_tree().quit()


func RegenTimer():
	tamastats.StartRegeneration()

func Tamalevelup():
	tamastats.LevelUp()
	tamastats.level += 1
	tamastats.Dexterity += 2
	tamastats.statpoints += 3
	tamastats.statCheck()


func ExitGame():
	if Input.is_action_just_pressed("Pause Menu"):
		get_tree().quit()

