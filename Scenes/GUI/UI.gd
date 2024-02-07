extends CanvasLayer
class_name GUI

const TAMAKI = preload("res://Resources/Characters/Tamaki_stats.tres")

@onready var healthbarlabel = $Bars/HealthbarLabel
@onready var HBar = $Bars/Healthbar
@onready var LevelLabel = $Bars/LevelLabel
@onready var xpbar = $Bars/XPBar
@onready var xpLabel = $Bars/XPLabel


func _ready():
	Invready()
	TAMAKI.currentxp = 0


func _process(_delta):
	Bars()
	#InventoryProcess()

func Bars():
	LevelLabel.text = "Level " + str(TAMAKI.Level)
	HBar.value = TAMAKI.Health
	healthbarlabel.text = "Health: " + str(TAMAKI.Health)
	HBar.max_value = TAMAKI.MaxHealth
	xpbar.value = TAMAKI.currentxp
	xpbar.max_value = TAMAKI.requiredxp
	xpLabel.text = "XP: " + str(TAMAKI.currentxp) + "                 Needed: " + str(TAMAKI.requiredxp)

var InvSize = 16
var itemsload = [
	"res://Resources/Shuriken.tres"
]

func Invready():
	for I in InvSize:
		var slot := InventorySlot.new()
		slot.init(ItemData.Type.Main, Vector2(105, 105))
		%Inv.add_child(slot)
		
	for i in itemsload.size():
		var item := InventoryItem.new()
		item.init(load(itemsload[i]))
		%Inv.get_child(i).add_child(item)

#func InventoryProcess():
	#if Input.is_action_just_pressed("Inventory"):
		#$Inventory.visible = !$Inventory.visible

