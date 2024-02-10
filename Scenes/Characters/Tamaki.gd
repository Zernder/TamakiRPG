extends CharacterBody2D
class_name Tamaki

@onready var player = $"."
#-------------------------------# ALL VARIABLES #------------------------------------------#

@export var Stats: GameStats

@onready var HitBox = $"Areas/Tamaki Hitbox"

var direction: Vector2 = Vector2.ZERO
var LastDirection: Vector2 = Vector2.ZERO
var StealthActive: bool = false
var SprintActive: bool = false
var Swing : bool = false
var Throw : bool = false
var Sneaky : bool = false


#-------------------------------# The Runtimes #-------------------------------------------#

func _ready():
	Stats.StatUpdate()
	Stats.StatCheck()


func _process(_delta):
	Stats.location = position
	Movement()
	SwingKatana()
	ThrowShuriken()
	CastSpell()
	ExitGame()
	move_and_slide()

#------------------------------------# Movement #------------------------------------------#


func Movement():
		direction = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
		
		if direction != Vector2.ZERO and Swing == false:
			velocity = direction * Stats.speed
			SetWalking(true)
			LastDirection = direction
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
	Anim["parameters/Idle/blend_position"] = direction
	Anim["parameters/Walking/blend_position"] = direction
	Anim["parameters/Katana/blend_position"] = direction
	Anim["parameters/Shuriken/blend_position"] = direction

#------------------------------------# Combat #--------------------------------------------#


var ShurikenScene = Global.ShurikenData.Scene
var KatanaScene = Global.KatanaData.Scene
var FireballScene = Global.FireballData.scene
var Hit = false
@onready var ActionCooldown: bool = false


func SwingKatana():
	if Input.is_action_just_pressed("Primary") and ActionCooldown == false:
		setSwing(true)
		ActionCooldown = true
		%ActionCooldownTimer.start(.5)


func ThrowShuriken():
	if Input.is_action_pressed("Secondary"):
		if ActionCooldown == false and Stats.stamina >= 2:
			setThrow(true)
			Stats.stamina -= 2
			ActionCooldown = true
			%ActionCooldownTimer.start(.2)


			var Shuriken = ShurikenScene.instantiate()
			Shuriken.rotation = direction.angle()
			Shuriken.direction = LastDirection
			Shuriken.global_position = %WeaponMarker.global_position
			$Weapons/Shurikens.add_child(Shuriken)


func CastSpell():
	if Input.is_action_pressed("Cast"):
		if ActionCooldown == false and Stats.mana >= 5:
			setThrow(true)
			Stats.mana -= 5
			ActionCooldown = true
			%ActionCooldownTimer.start(1)


			var Fireball = FireballScene.instantiate()
			$Weapons/Fireballs.add_child(Fireball)
			Fireball.rotation = direction.angle()
			Fireball.direction = LastDirection
			Fireball.global_position = %WeaponMarker.global_position + direction * 20


func ExitGame():
	if Input.is_action_just_pressed("Exit"):
		get_tree().quit()

func WeaponCooldown():
	ActionCooldown = false


func DamageBoxEntered(area):
	pass # Replace with function body.

func HitboxEntered(area):
	if area.is_in_group("BlueSlimeDamageBox"):
		if Hit == false:
			Hit = true
			AnimPlayer.play("Damaged")
			$Timers/Damaged.start(5)
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
