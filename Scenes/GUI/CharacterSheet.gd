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

@onready var charactersheet = $"."


func _process(_delta):
	statbars()
	levelupCharacterSheet()
	
#func _input(event):
	#CharacterSheet()
#
#
#
#func CharacterSheet():
	#if Input.is_action_just_pressed("Charactersheet"):
		#if charactersheet.visible == false:
			#charactersheet.show()
			#get_tree().paused = true
		#elif charactersheet.visible == true:
			#charactersheet.hide()
			#get_tree().paused = false


func levelupCharacterSheet():
	if Tamakistats.screenup == 1:
		charactersheet.show()
		Tamakistats.screenup = 0
		Global.is2D = true



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
