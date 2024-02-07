class_name ItemData
extends Resource

enum Type { Head, Chest, Legs, Feet, Weapon, Accesory, Main }


@export var type: Type
@export var name: String
@export_multiline var description: String
@export var texture: Texture2D
	
