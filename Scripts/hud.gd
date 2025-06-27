extends CanvasLayer

@onready var score_label: Label = $HUD_Container/ScoreContainer/ScoreLabel

@onready var hearts: Array[TextureRect] = [
	$HUD_Container/LivesContainer/Heart_1,
	$HUD_Container/LivesContainer/Heart_2,
	$HUD_Container/LivesContainer/Heart_3
]

@export var heart_full_texture: Texture2D = preload("res://Assets/Sprites/heart_full.png")
@export var  heart_empty_texture: Texture2D = preload("res://Assets/Sprites/heart_empty.png")


func _ready() -> void:
	print("HUD _ready: HUD inicializada.")

	for heart in hearts:
		# Antes de atribuir, verifique se 'heart' NÃO é nulo
		if heart != null:
			heart.texture = heart_full_texture
		else:
			print("ALERTA: Tentando atribuir textura a um coração nulo no _ready()!")


func update_lives(current_lives: int) -> void:
	print("HUD: Vidas atualizadas para: ", current_lives)
	for i in range(hearts.size()):
		var heart = hearts[i]
		# --- NOVO PRINT PARA DEPURAR CADA CORAÇÃO ANTES DE USAR ---
		if heart == null:
			print("ERRO CRÍTICO: Coração no índice ", i, " é nulo na update_lives! Ignorando este coração.")
			continue # Pula para a próxima iteração do loop se o coração for nulo
		# --- FIM DO NOVO PRINT ---

		if i < current_lives:
			heart.texture = heart_full_texture
			heart.visible = true
		else:
			if heart_empty_texture:
				heart.texture = heart_empty_texture
				heart.visible = true
			else:
				heart.visible = false
# ... restante do código ...
