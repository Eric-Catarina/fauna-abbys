extends CharacterBody2D

# Constantes de velocidade e gravidade
const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Variáveis de controle de direção e estado
var direction : float = 0.0
var state : String = "idle" # Estados: "idle", "explore_left", "explore_right"

func _physics_process(delta: float) -> void:
	match state:
		"explore_left":
			explore_left()
		"explore_right":
			explore_right()
		"idle":
			idle()
	move_and_slide()

# Funções para os diferentes estados

func explore_left():
	direction = -1.0
	velocity.x = direction * SPEED

func explore_right():
	direction = 1.0
	velocity.x = direction * SPEED

func idle():
	velocity.x = 0

# Função para transicionar para estados
func set_state(new_state: String) -> void:
	state = new_state
