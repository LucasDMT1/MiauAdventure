extends Node

# Sinais para a HUD ou outras partes do jogo ouvirem quando vidas ou pontuação mudam
signal lives_changed(new_lives)
signal score_changed(new_score)

# Variáveis globais para vidas e pontuação
# Usamos 'setget' para emitir sinais automaticamente quando os valores são alterados.
var current_lives: int = 3: # Vidas iniciais do jogador
	set(value):
		current_lives = value
		lives_changed.emit(current_lives) # Emite o sinal lives_changed
		if current_lives <= 0:
			print("Game Over! Voltando para a tela inicial.")
			# Lógica para Game Over: ir para tela de game over, reiniciar tudo, etc.
			# Por enquanto, volta para a tela de título e reseta o estado do jogo.
			reset_game_state() # Reseta para um novo jogo
			get_tree().change_scene_to_file("res://Scenes/TitleScreen.tscn")

var current_score: int = 0: # Pontuação inicial do jogador
	set(value):
		current_score = value
		score_changed.emit(current_score) # Emite o sinal score_changed

# Chamado quando o GameManager é carregado.
func _ready() -> void:
	# Garante que a HUD seja atualizada com os valores iniciais assim que o jogo começa
	# (isso é especialmente importante se o jogo não começar da TitleScreen).
	lives_changed.emit(current_lives)
	score_changed.emit(current_score)
	print("GameManager inicializado.")

# Função para adicionar pontos
func add_score(amount: int) -> void:
	if amount > 0:
		current_score += amount
		print("Pontos adicionados: ", amount, ". Pontuação total: ", current_score)

# Função para perder uma vida
func lose_life() -> void:
	current_lives -= 1
	print("Vida perdida. Vidas restantes: ", current_lives)

# Função para resetar o estado do jogo (para um novo jogo)
func reset_game_state() -> void:
	current_lives = 3 # Volta para 3 vidas
	current_score = 0 # Zera a pontuação
	print("Estado do jogo resetado.")
