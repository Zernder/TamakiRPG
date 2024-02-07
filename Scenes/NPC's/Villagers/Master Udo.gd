extends CharacterBody2D
#
#@onready var Anim = $AnimatedSprite2D
#@onready var timer = $Timer
#var Health = 20
#var Speed = 40
#var CurrentState = IDLE
#var dir = Vector2.RIGHT
#
#func _ready():
	#Anim.play("idle")
	#randomize()
#
#func _process(delta):
	#statemachine(delta)
	#HealthBar()
#
#func _physics_process(_delta):
	#death()
	#move_and_slide()
#
#enum {
		#IDLE,
		#NEWDIR,
		#MOVE
	#}
#
#func statemachine(delta):
	#if Health > 0:
		#match CurrentState:
			#IDLE:
				#Anim.play("idle")
			#NEWDIR:
				#dir = choose([Vector2.RIGHT, Vector2.LEFT, Vector2.UP, Vector2.DOWN])
			#MOVE:
				#move(delta)
#
#func move(delta):
	#position += dir * Speed * delta
	#
	#if dir.x > 0:
		#Anim.play("walkright")
	#elif dir.x < 0:
		#Anim.play("walkleft")
	#elif dir.y > 0:
		#Anim.play("walkdown")
	#elif dir.y < 0:
		#Anim.play("walkup")
	#else:
		#Anim.play("idle")
#
#func choose(array):
	#array.shuffle()
	#return array.front()
#
#func death():
	#if Health <= 0:
		#queue_free()
#
#func StateReset():
	#timer.wait_time = choose([0.5, 1, 3])
	#CurrentState = choose([IDLE,NEWDIR,MOVE])
#
#
#func HealthBar():
	#$Healthbar.value = Health
#
#func HitboxEntered(area):
	#if area.is_in_group("Arrow"):
		#Health -= 2
		#print(Health)
	#if Health <= 0:
		#$DeathTimer.start()
#
#
#func DeathTimer():
	#queue_free()
#
