extends CharacterBody2D

var AnimPlayer
var tween: Tween
var creature_sprite: Sprite2D
var idle_tween: Tween

func _ready() -> void:
	AnimPlayer = $AnimationPlayer
	creature_sprite = $CreatureImage
	idle() # Começar a animação de idle quando a cena estiver pronta

func _physics_process(delta: float):
	move_and_slide()

func move(dir: Vector2, speed: float):
	# Aplicar a velocidade de forma independente para X e Y
	velocity.x = dir.x * speed
	velocity.y = dir.y * speed

func idle():
	# Garante que a animação de idle seja rodando indefinidamente em loop
	if idle_tween:
		idle_tween.kill() # Reinicia o tween, se já estiver rodando

	idle_tween = get_tree().create_tween()

	# Define os valores de escala para aumentar e diminuir o tamanho do sprite
	var scale_up = creature_sprite.scale * Vector2(1.1, 1.1) # Aumenta 10%
	var scale_down = creature_sprite.scale * Vector2(0.9, 0.9) # Diminui 10%

	# Anima a rotação, um leve giro para os lados
	var rotation_left = creature_sprite.rotation_degrees - 5
	var rotation_right = creature_sprite.rotation_degrees + 5

	# Criação da animação com o Tween
	idle_tween.tween_property(creature_sprite, "scale", scale_up, 1).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	idle_tween.tween_property(creature_sprite, "rotation_degrees", rotation_left, 1).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	
	# Depois de completar a animação de aumento, retorna ao tamanho original e faz o giro oposto
	idle_tween.tween_property(creature_sprite, "scale", scale_down, 1).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT).set_delay(1)
	idle_tween.tween_property(creature_sprite, "rotation_degrees", rotation_right, 1).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT).set_delay(1)

	# Fazer o tween repetir para loopar a animação de idle
	idle_tween.set_loops(-1)

func flip():
	# Parar a animação de idle temporariamente
	if idle_tween:
		idle_tween.kill()

	# Cria um novo tween para flipar a criatura
	tween = get_tree().create_tween()

	# Inverter a escala na direção X para flipar a criatura
	var flipped_scale = Vector2(creature_sprite.scale.x * -1, creature_sprite.scale.y)
	tween.tween_property(creature_sprite, "scale", flipped_scale, 0.15).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

	# Quando a animação de flipar terminar, retomar a animação de idle
	tween.connect("finished", Callable(self, "_on_flip_finished"))

func _on_flip_finished():
	# Reinicia a animação de idle depois de flipar
	idle()
