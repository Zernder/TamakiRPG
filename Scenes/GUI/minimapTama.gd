extends AnimatedSprite2D

@onready var anim = $"."


func _physics_process(_delta):
	Movement()

func Movement():
	# Get the input direction.
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down").normalized()

	# Play the appropriate animation based on the input direction for the minimap version.
	if direction != Vector2.ZERO:
		if abs(direction.x) > abs(direction.y):
			# Horizontal movement dominates, play left/right animation
			if direction.x > 0:
				anim.play("walkright")
			else:
				anim.play("walkleft")
		else:
			# Vertical movement dominates, play up/down animation
			if direction.y < 0:
				anim.play("walkup")
			else:
				anim.play("walkdown")
	else:
		# No movement, play idle animation
		anim.play("idle")


