extends Node2D

var desired_height = 330 # Defina a altura desejada da janela
var window_size: Vector2

func _ready() -> void:
	window_size = DisplayServer.screen_get_size()
	print(window_size)
	# Defina o tamanho da janela para ocupar toda a largura do monitor e altura desejada
	DisplayServer.window_set_size(Vector2(window_size.x, desired_height))
	
	# Posicione a janela na parte inferior da tela
	DisplayServer.window_set_position(Vector2(0, window_size.y - desired_height))
	
	# Defina a janela como transparente e sem borda
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_TRANSPARENT, true)
	
	# Habilite fundo transparente para o viewport
	get_viewport().transparent_bg = true

func _process(delta: float) -> void:
	pass
