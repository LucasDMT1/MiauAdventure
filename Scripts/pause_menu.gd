extends CanvasLayer

# Sinais que este menu de pausa VAI EMITIR para quem o está ouvindo (o LevelManager)
signal resume_game
signal restart_level
signal exit_to_title

func _ready() -> void:
	# Garante que o mouse esteja visível quando o menu de pausa é ativado
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	print("PauseMenu _ready: Mouse visível e menu pronto.") # Debugging

# Funções chamadas pelos botões (conectadas na interface do Godot)
# Certifique-se de que os nomes dos botões na cena correspondem a estas funções!
# Se você renomeou para ResumeButton, RestartButton, ExitButton, está certo.
# Se não, ajuste os nomes das funções aqui.
func _on_ResumeButton_pressed() -> void:
	print("Botão RESUMIR clicado!")
	resume_game.emit() # Emite o sinal para quem está ouvindo (LevelManager)
	queue_free() # Remove este menu de pausa da cena

func _on_RestartButton_pressed() -> void:
	print("Botão REINICIAR FASE clicado!")
	restart_level.emit() # Emite o sinal
	queue_free()

func _on_ExitButton_pressed() -> void:
	print("Botão SAIR PARA O TÍTULO clicado!")
	exit_to_title.emit() # Emite o sinal
	queue_free()
