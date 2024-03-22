extends Control

@export var Tamakistats: CharacterStats

@onready var strengthlabel = %strengthlabel
@onready var strengthbutton = %strengthbutton
@onready var dexteritylabel = %dexteritylabel
@onready var dexteritybutton = %dexteritybutton
@onready var constitutionlabel = %constitutionlabel
@onready var constitutionbutton = %constitutionbutton
@onready var intelligencelabel = %intelligencelabel
@onready var intelligencebutton = %intelligencebutton
@onready var wisdomlabel = %wisdomlabel
@onready var wisdombutton = %wisdombutton
@onready var statpoints = $Statpoints

@onready var bars = $"../Bars"
@onready var hot_bar = $"../HotBar"
@onready var character_sheet = $"."



func _process(_delta):
	statbars()
	CharacterSheet()

func CharacterSheet():
	var charactersheet = $"."
	if Tamakistats.screenup == 1:
		charactersheet.show()
		Tamakistats.screenup = 0
	elif Input.is_action_just_pressed("Charactersheet"):
		if charactersheet.visible:
			charactersheet.hide()
			get_tree().paused = false
		else:
			charactersheet.show()
			get_tree().paused = true


func statbars():
	strengthlabel.text = "Strength: " + str(Tamakistats.Strength)
	dexteritylabel.text = "Dexterity: " + str(Tamakistats.Dexterity)
	constitutionlabel.text = "Constitution: " + str(Tamakistats.Constitution)
	intelligencelabel.text = "Intelligence: " + str(Tamakistats.Intelligence)
	wisdomlabel.text = "Wisdom: " + str(Tamakistats.Wisdom)
	statpoints.text = "Stat Points: " + str(Tamakistats.statpoints)



func _on_strengthbutton_pressed():
	if Tamakistats.statpoints > 0:
		Tamakistats.Strength += 1
		Tamakistats.statpoints -= 1


func _on_dexteritybutton_pressed():
	if Tamakistats.statpoints > 0:
		Tamakistats.Dexterity += 1
		Tamakistats.statpoints -= 1


func _on_constitutionbutton_pressed():
	if Tamakistats.statpoints > 0:
		Tamakistats.Constitution += 1
		Tamakistats.statpoints -= 1


func _on_intelligencebutton_pressed():
	if Tamakistats.statpoints > 0:
		Tamakistats.Intelligence += 1
		Tamakistats.statpoints -= 1


func _on_wisdombutton_pressed():
	if Tamakistats.statpoints > 0:
		Tamakistats.Wisdom += 1
		Tamakistats.statpoints -= 1


func DonePressed():
	Tamakistats.StatCheck()
	get_tree().paused = false
	$".".hide()
