extends CanvasLayer
class_name GUI

@onready var Tamaki = Global.TAMAKI

@onready var healthbarlabel = $Bars/HealthbarLabel
@onready var HBar = $Bars/Healthbar
@onready var LevelLabel = $Bars/LevelLabel
@onready var xpbar = $Bars/XPBar
@onready var xpLabel = $Bars/XPLabel


func _ready():
	Invready()
	Tamaki.currentxp = 0


func _process(_delta):
	Bars()
	InventoryProcess()

func Bars():
	LevelLabel.text = "Level " + str(Tamaki.Level)
	HBar.value = Tamaki.Health
	healthbarlabel.text = "Health: " + str(Tamaki.Health)
	HBar.max_value = Tamaki.MaxHealth
	xpbar.value = Tamaki.currentxp
	xpbar.max_value = Tamaki.requiredxp
	xpLabel.text = "XP: " + str(Tamaki.currentxp) + "                 Needed: " + str(Tamaki.requiredxp)

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

func InventoryProcess():
	if Input.is_action_just_pressed("Inventory"):
		$Inventory.visible = !$Inventory.visible

