extends Spells

func _physics_process(delta):
	SummonSlime()

func SummonSlime():
		if tamastats.mana >= 10 and Global.FamiliarSummoned == false:
			player.CastSpell(10)
			tamastats.speed = 0
			casting = true
			await  player.find_child("Cast").timeout
			var familiar = SlimeFamiliarScene.instantiate()
			familiar.global_position = player.global_position
			get_tree().current_scene.call_deferred("add_child",familiar)
			casting = false
			tamastats.mana -= 10
			Global.FamiliarSummoned = true
			tamastats.speed = 60
