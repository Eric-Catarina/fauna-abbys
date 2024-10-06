extends BTAction

@export var target_pos_var := &"pos"
@export var dir_var := &"dir"

@export var speed_var = 100
@export var tolerance = 10

func _tick(_delta:float) -> Status:
	var target_pos: Vector2 = blackboard.get_var(target_pos_var, Vector2.ZERO)
	var dir = blackboard.get_var(dir_var)
	
	# Calcula a distância tanto em X quanto em Y
	var distance_x = abs(agent.global_position.x - target_pos.x)
	var distance_y = abs(agent.global_position.y - target_pos.y)
		
	# Verifica se o agente está dentro da tolerância nos eixos X e Y
	if distance_x < tolerance and distance_y < tolerance:
		agent.move(Vector2(0, 0), 0)  # Para o movimento
		return SUCCESS
	else:
	# Calcula a direção para o alvo sem normalizar
		var dir_to_target = target_pos - agent.global_position
		dir_to_target = dir_to_target.normalized()  # Apenas depois normaliza para movimento correto
		agent.move(dir_to_target, speed_var)  # Move o agente na direção do alvo
		return RUNNING
