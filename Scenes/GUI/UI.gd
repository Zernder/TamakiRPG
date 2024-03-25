extends CanvasLayer
class_name GUI

@export var TamakiStats: CharacterStats

@onready var HBar = %Healthbar
@onready var HBarlabel = %HealthbarLabel
@onready var StaminaBar = %StaminaBar
@onready var Staminalabel = %StaminaText
@onready var LevelLabel = %LevelLabel
@onready var XPBar = %XPBar
@onready var XPLabel =%XPLabel
@onready var manabar = %ManaBar
@onready var manalabel = %ManaText


func _process(_delta):
	Bars()
	TamakiStats.LevelUp()
	XPBar.max_value = TamakiStats.requiredxp

func Bars():
	HBar.value = TamakiStats.health
	StaminaBar.value = TamakiStats.stamina
	XPBar.value = TamakiStats.currentxp
	manabar.value = TamakiStats.mana
	HBarlabel.text = "Health: " + str(TamakiStats.health) + "/" + str(TamakiStats.maxHealth)
	Staminalabel.text = "Stamina: " + str(TamakiStats.stamina) + "/" + str(TamakiStats.maxStamina)
	manalabel.text = "Mana: " + str(TamakiStats.mana) + "/" + str(TamakiStats.maxMana)
	XPLabel.text = "XP: " + str(TamakiStats.currentxp) + "   Needed: " + str(TamakiStats.requiredxp)
	HBar.tooltip_text = "Health: " + str(TamakiStats.health) + "/" + str(TamakiStats.maxHealth)
	StaminaBar.tooltip_text = "Stamina: " + str(TamakiStats.stamina) + "/" + str(TamakiStats.maxStamina)
	LevelLabel.text = "Level " + str(TamakiStats.level)
	HBar.max_value = TamakiStats.maxHealth
	StaminaBar.max_value = TamakiStats.maxStamina
	manabar.max_value = TamakiStats.maxMana


func _on_restart_game_pressed():
	get_tree().reload_current_scene()


func _on_exit_game_pressed():
	get_tree().quit()



#var InvSize = 16
#var itemsload = [
	#"res://Resources/Shuriken.tres"
#]
#
#func Invready():
	#for I in InvSize:
		#var slot := InventorySlot.new()
		#slot.init(ItemData.Type.Main, Vector2(105, 105))
		#%Inv.add_child(slot)
		#
	#for i in itemsload.size():
		#var item := InventoryItem.new()
		#item.init(load(itemsload[i]))
		#%Inv.get_child(i).add_child(item)
#
#func InventoryProcess():
	#if Input.is_action_just_pressed("Inventory"):
		#$Inventory.visible = !$Inventory.visible
