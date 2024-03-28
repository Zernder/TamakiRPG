extends Control
#
#
#@onready var charactersheet = $"."
#@onready var strengthlabel = %strengthlabel
#@onready var strengthbutton = %strengthbutton
#@onready var dexteritylabel = %dexteritylabel
#@onready var dexteritybutton = %dexteritybutton
#@onready var constitutionlabel = %constitutionlabel
#@onready var constitutionbutton = %constitutionbutton
#@onready var intelligencelabel = %intelligencelabel
#@onready var intelligencebutton = %intelligencebutton
#@onready var wisdomlabel = %wisdomlabel
#@onready var wisdombutton = %wisdombutton
#@onready var statpoints = $Statpoints
#
#
#func _process(_delta):
	#statbars()
	#levelupCharacterSheet()
#
#
#func _input(_event):
	#CharacterSheet()
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
#
#
#func levelupCharacterSheet():
	#if tamaexp.characterscreen == true:
		#charactersheet.show()
		#tamaexp.characterscreen = false
		#Global.is2D = true
#
#
#
#func statbars():
	#strengthlabel.text = "Strength: " + str(Tama.Strength)
	#dexteritylabel.text = "Dexterity: " + str(Tama.Dexterity)
	#constitutionlabel.text = "Constitution: " + str(Tama.Constitution)
	#intelligencelabel.text = "Intelligence: " + str(Tama.Intelligence)
	#wisdomlabel.text = "Wisdom: " + str(Tama.Wisdom)
	#statpoints.text = "Stat Points: " + str(tamaexp.statpoints)
#
#
#func _on_strengthbutton_pressed():
	#if Tama.statpoints > 0:
		#Tama.Strength += 1
		#Tama.statpoints -= 1
#
#
#func _on_dexteritybutton_pressed():
	#if Tama.statpoints > 0:
		#Tama.Dexterity += 1
		#Tama.statpoints -= 1
#
#
#func _on_constitutionbutton_pressed():
	#if Tama.statpoints > 0:
		#Tama.Constitution += 1
		#Tama.statpoints -= 1
#
#
#func _on_intelligencebutton_pressed():
	#if Tama.statpoints > 0:
		#Tama.Intelligence += 1
		#Tama.statpoints -= 1
#
#
#func _on_wisdombutton_pressed():
	#if Tama.statpoints > 0:
		#Tama.Wisdom += 1
		#Tama.statpoints -= 1
#
#
#func DonePressed():
	#Tama.StatCheck()
	#get_tree().paused = false
	#$".".hide()
#
