extends Area2D

@export var next_level_path: String = "res://Scenes/Levels/Level_02.tscn" # Caminho para o próximo nível

func _on_body_entered(body: Node2D) -> void:
	if body.name == "CatPlayer": # Verifica se é o jogador
		print("Gato alcançou a zona de saída! Carregando próximo nível...")
		if ResourceLoader.exists(next_level_path): # Garante que o próximo nível exista
			get_tree().change_scene_to_file(next_level_path)
		else:
			print("AVISO: Próximo nível não encontrado em:", next_level_path)
			print("Fim do jogo ou voltar para a tela inicial.")
			get_tree().change_scene_to_file("res://Scenes/TitleScreen.tscn") # Ou outra ação
