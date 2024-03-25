extends CharacterBody2D
class_name Tamaki

@onready var player = $"."
#-------------------------------# ALL VARIABLES #------------------------------------------#

@export var Stats: CharacterStats

@onready var HitBox = $"Areas/Tamaki Hitbox"
var StealthActive: bool = false
var SprintActive: bool = false
var Swing : bool = false
var Throw : bool = false
var Sneaky : bool = false


#-------------------------------# The Runtimes #-------------------------------------------#

func _ready():
	Stats.speed = 60
	Global.is2D = true
	Stats.StatCheck()

func _process(_delta):
	Stats.location = position
	castbar.value = cast.wait_time - cast.time_left


func _physics_process(_delta):
	Movement()
	SwingKatana()
	ThrowShuriken()
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

			velocity = Global.direction * Stats.speed
			SetWalking(true)
			Global.LastDirection = Global.direction
			UpdateBlend()
		else:
			velocity = Vector2.ZERO
			SetWalking(false)

#
		## Adjust speed based on sprint and stealth mode
		#if Input.is_action_pressed("Sprint") and !StealthActive:
			#SprintActive = true
			#Stats.Speed = 150
			#Anim.speed_scale = 2
		#elif !StealthActive:
			#SprintActive = false
			#Stats.Speed = 120
			#Anim.speed_scale = 1.0
			#player.modulate = Color(1, 1, 1, 1)
			#$CollisionPolygon2D.disabled = false

#----------------------------------# Animation Blending #----------------------------------#

@onready var Anim = $AnimationTree
@onready var AnimPlayer = %AnimationPlayer

func SetWalking(value):
	Anim["parameters/conditions/Walking"] = value
	Anim["parameters/conditions/Idle"] = not value

func setSwing(value = false):
	Swing = value
	Anim["parameters/conditions/Swing"] = value

func setThrow(value = false):
	Throw = value
	Anim["parameters/conditions/Throw"] = value

func UpdateBlend():
	Anim["parameters/Idle/blend_position"] = Global.direction
	Anim["parameters/Walking/blend_position"] = Global.direction
	Anim["parameters/Katana/blend_position"] = Global.direction
	Anim["parameters/Shuriken/blend_position"] = Global.direction

#------------------------------------# Combat #--------------------------------------------#


const ShurikenScene = preload("res://Scenes/Weapons, Tools, and Spells/Weapons/Shuriken.tscn")
const KatanaScene = preload("res://Scenes/Weapons, Tools, and Spells/Weapons/Katana.tscn")
@onready var castbar = $Magic/Castbar
@onready var cast = $Timers/Cast
var Hit = false
@onready var ActionCooldown: bool = false


func SwingKatana():
	if Input.is_action_just_pressed("Primary") and ActionCooldown == false:
		setSwing(true)
		ActionCooldown = true
		%WeaponCooldown.start(.5)


func ThrowShuriken():
	if Input.is_action_pressed("Secondary"):
		if ActionCooldown == false and Stats.stamina >= 2:
			setThrow(true)
			Stats.stamina -= 2
			ActionCooldown = true
			%WeaponCooldown.start(.2)
			var Shuriken = ShurikenScene.instantiate()
			Shuriken.rotation = Global.direction.angle()
			Shuriken.direction = Global.LastDirection
			Shuriken.global_position = %WeaponMarker.global_position
			$Weapons/Shurikens.add_child(Shuriken)

func WeaponCooldown():
	ActionCooldown = false


func casting(time = 1.0):
	castbar.max_value = time
	castbar.show()
	
	cast.wait_time = time
	cast.start()


func casttimeout():
	castbar.hide()

func HitboxEntered(area):
	if area.is_in_group("BlueSlimeDamageBox"):
		if Hit == false:
			Hit = true
			AnimPlayer.play("Damaged")
			$Timers/Damaged.start(2)
			Stats.health -= (area.get_parent().get_parent().Stats.meleeDamage - Stats.meleeDefense)

	if Stats.health <= 0:
		get_tree().quit()

func DamageTimeout():
	Hit = false
	HealthRegen()

func HealthRegen():
	if Stats.health < Stats.maxHealth:
		Stats.health += Stats.healthRegeneration
		if Stats.health > Stats.maxHealth:
			Stats.health = Stats.maxHealth

func StaminaRegen():
	if Stats.stamina < Stats.maxStamina:
		Stats.stamina += Stats.staminaRegeneration
		if Stats.stamina > Stats.maxStamina:
			Stats.stamina = Stats.maxStamina

func ManaRegen():
	if Stats.mana < Stats.maxMana:
		Stats.mana += Stats.manaRegeneration
		if Stats.mana > Stats.maxMana:
			Stats.mana = Stats.maxMana

func RegenTimer():
	HealthRegen()
	StaminaRegen()
	ManaRegen()


func ExitGame():
	if Input.is_action_just_pressed("Exit"):
		get_tree().quit()



