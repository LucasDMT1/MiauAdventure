extends CharacterBody2D

# Velocidades
@export var speed: float = 200.0 # Velocidade de movimento horizontal
@export var jump_force: float = 400.0 # Força do pulo
@export var gravity: float = 900.0 # Força da gravidade

# A propriedade 'velocity' já existe no CharacterBody2D, não precisamos declará-la aqui.

func _physics_process(delta: float) -> void:
	# 1. Gravidade
	if not is_on_floor(): # <--- CORREÇÃO AQUI: Sem parênteses!
		velocity.y += gravity * delta
		# Limita a velocidade de queda para não acelerar infinitamente
		if velocity.y > 800: # Valor arbitrário, ajuste se precisar
			velocity.y = 800
	else:
		# Se estiver no chão e não estiver pulando, zera a velocidade Y para evitar "afundar" ou acumular gravidade.
		# Mas, mantenha uma pequena velocidade para baixo se não houver input de pulo,
		# para garantir que 'is_on_floor' continue retornando true em superfícies inclinadas.
		if Input.is_action_just_pressed("ui_up"): # Se for pular, não zera.
			pass # A velocidade y será definida no pulo.
		elif velocity.y > 0: # Se já estiver "caindo" (mesmo que no chão), zere ou mantenha pequeno.
			velocity.y = 0.0 # <--- Zera a velocidade Y quando no chão e não pulando.


	# 2. Movimento Horizontal
	var input_direction: float = Input.get_axis("ui_left", "ui_right")
	velocity.x = input_direction * speed

	# 3. Pulo
	# is_on_floor é uma propriedade, não uma função que precisa de ().
	if Input.is_action_just_pressed("ui_up") and is_on_floor: # <--- CORREÇÃO AQUI: Sem parênteses!
		velocity.y = -jump_force
	
	# 4. Movimentar o corpo do personagem
	move_and_slide() # Agora funciona com a propriedade 'velocity' do CharacterBody2D

	# Exemplo de animação (usando AnimatedSprite2D - comente se estiver usando ColorRect)
	# var animated_sprite = $AnimatedSprite2D # Certifique-se de que o nome do nó está correto
	# if animated_sprite:
	# 	if is_on_floor: # <--- CORREÇÃO AQUI: Sem parênteses!
	# 		if input_direction != 0:
	# 			animated_sprite.play("run")
	# 			animated_sprite.flip_h = input_direction < 0 # Vira o sprite se for para a esquerda
	# 		else:
	# 			animated_sprite.play("idle")
	# 	else:
	# 		if velocity.y < 0:
	# 			animated_sprite.play("jump")
	# 		else:
	# 			animated_sprite.play("fall")
