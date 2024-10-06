extends CharacterBody2D

func _physics_process(delta: float):
	move_and_slide()

func move(dir: Vector2, speed: float):
	# Aplicar a velocidade de forma independente para X e Y
	velocity.x = dir.x * speed
	velocity.y = dir.y * speed
