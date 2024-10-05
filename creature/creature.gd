extends CharacterBody2D

func _physics_process(delta: float):
	move_and_slide()

func move(dir, speed):
	velocity.x = dir * speed
