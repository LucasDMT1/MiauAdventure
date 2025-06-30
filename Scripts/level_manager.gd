extends Node2D

@export var pause_menu_scene: PackedScene # Será a referência para o PauseMenu.tscn

func _ready() -> void:
	# Garante que o mouse esteja escondido no jogo
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"): # "ui_cancel" é geralmente a tecla ESC
		_toggle_pause_menu()

func _toggle_pause_menu() -> void:
	if get_tree().paused: # Se o jogo já está pausado
		_resume_game()
	else: # Se o jogo não está pausado
		_pause_game()

func _pause_game() -> void:
	get_tree().paused = true # Pausa o motor do jogo
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE) # Mostra o mouse

	# Instancia e adiciona o menu de pausa
	var pause_menu_instance = pause_menu_scene.instantiate()
	add_child(pause_menu_instance)

func _resume_game() -> void:
	get_tree().paused = false # Despausa o motor do jogo
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED) # Esconde o mouse novamente

func _restart_level() -> void:
	get_tree().paused = false # Despausa antes de recarregar
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED) # Esconde o mouse
	get_tree().reload_current_scene()

func _exit_to_title() -> void:
	get_tree().paused = false # Despausa antes de sair
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE) # Mostra o mouse para o menu de título
	get_tree().change_scene_to_file("res://Scenes/TitleScreen.tscn")
