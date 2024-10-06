extends BTAction

@export var range_min_in_dir_x: float =40.0
@export var range_max_in_dir_x: float =100.0

@export var range_min_in_dir_y: float =10.0
@export var range_max_in_dir_y: float =25.0

# position será uma variável global que pode ser acessada atraves da keyword pos
@export var position_var: StringName = &"pos"
@export var dir_var: StringName = &"dir"
func _tick(_delta: float) -> Status:
	var pos: Vector2
	var dir = random_dir()
	
	pos = random_pos(dir)
	blackboard.set_var(position_var, pos)
	return SUCCESS

func random_dir():
	# Gera valores aleatórios entre -1 e 1 para X e Y
	var dir_x = randf_range(-1.0, 1.0)
	var dir_y = randf_range(-1.0, 1.0)

	# Cria um vetor de direção
	var dir = Vector2(dir_x, dir_y).normalized()  # Normaliza para garantir que a direção tenha magnitude 1
	blackboard.set_var(dir_var, dir)
	return dir


func random_pos(dir):
	var vector: Vector2
	var distance_x = randi_range(range_min_in_dir_x, range_max_in_dir_x) * dir.x
	var distance_y = randi_range(range_min_in_dir_y, range_max_in_dir_y) * dir.y
	
	# Calcula a posição final tanto em X quanto em Y
	vector.x = agent.global_position.x + distance_x
	vector.y = agent.global_position.y + distance_y
	return vector
