extends Resource
class_name WeaponData

#enum Type { Head, Chest, Legs, Feet, Weapon, Accesory, Main }


#@export var SlotType: Type
@export var ItemName: String
@export var ItemTexture: Texture2D
@export var BaseDamage: float
@export var BaseStaminaCost: float
@export var Scene: PackedScene
@export_multiline var ItemDescription: String

 
