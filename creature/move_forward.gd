@tool
extends BTAction

## Define as direções e a velocidade que a criatura irá usar ao explorar.
@export var speed_var: StringName = &"speed"   # A variável da velocidade no "blackboard"
@export var explore_duration: float = 2.0      # Duração do movimento de exploração
@export var direction_var: StringName = &"direction" # Direção atual de exploração (esquerda ou direita)

# Nome personalizado para o Behavior Tree Editor
func _generate_name() -> String:
	return "Explore  speed: %s  duration: %ss" % [
		LimboUtility.decorate_var(speed_var),
		explore_duration]

# Função que será chamada a cada "tick" da árvore de comportamento
func _tick(_delta: float) -> Status:
	var speed: float = blackboard.get_var(speed_var, 100.0)  # Obtém a velocidade
	var direction: float = blackboard.get_var(direction_var, 1.0)  # Direção (1 = direita, -1 = esquerda)
	
	# Aplica o movimento
	var desired_velocity: Vector2 = Vector2(direction, 0) * speed
	agent.move(desired_velocity)
	
	# Verifica se a duração da exploração foi atingida
	if elapsed_time > explore_duration:
		return SUCCESS
	
	return RUNNING
