extends CanvasLayer
class_name GUI

const tamastats = preload("res://Scenes/Characters/Tamaki/TamaStats.tres")


# Define GUI elements
@onready var healthbar = $Bars/Healthbar
@onready var healthbarlabel = $Bars/Healthbar/HealthbarLabel
@onready var staminabar = $Bars/StaminaBar
@onready var staminatext = $Bars/StaminaBar/StaminaText
@onready var xpbar = $Bars/XPBar
@onready var xplabel = $Bars/XPBar/XPLabel
@onready var levellabel = $Bars/XPBar/LevelLabel
@onready var manabar = $Bars/ManaBar
@onready var manatext = $Bars/ManaBar/ManaText


func _process(_delta):
	updateBars()
	tamastats.LevelUp()
	xpbar.max_value = tamastats.requiredxp

func updateBars():
	# Update health bar
	healthbar.value = tamastats.health
	healthbar.max_value = tamastats.maxHealth
	healthbarlabel.text = "Health: " + str(tamastats.health) + "/" + str(tamastats.maxHealth)
	healthbar.tooltip_text = "Health: " + str(tamastats.health) + "/" + str(tamastats.maxHealth)

	# Update stamina bar
	staminabar.value = tamastats.stamina
	staminabar.max_value = tamastats.maxStamina
	staminatext.text = "Stamina: " + str(tamastats.stamina) + "/" + str(tamastats.maxStamina)
	staminabar.tooltip_text = "Stamina: " + str(tamastats.stamina) + "/" + str(tamastats.maxStamina)

	# Update mana bar
	manabar.value = tamastats.mana
	manabar.max_value = tamastats.maxMana
	manatext.text = "Mana: " + str(tamastats.mana) + "/" + str(tamastats.maxMana)

	# Update level label
	levellabel.text = "Level " + str(tamastats.level)

	# Update XP bar and label
	xpbar.value = tamastats.currentxp
	xplabel.text = "XP: " + str(tamastats.currentxp) + "   Needed: " + str(tamastats.requiredxp)
