extends CharacterBody2D

@export var speed: float = 200.0
@export var jump_force: float = 400.0
@export var gravity: float = 900.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta
		if velocity.y > 800:
			velocity.y = 800
	else:
		if not Input.is_action_just_pressed("ui_up"):
			velocity.y = 0.0

	var input_direction: float = Input.get_axis("ui_left", "ui_right")
	velocity.x = input_direction * speed

	if input_direction != 0:
		if input_direction < 0:
			animated_sprite.flip_h = true
		else:
			animated_sprite.flip_h = false

	if Input.is_action_just_pressed("ui_up") and is_on_floor:
		velocity.y = -jump_force

	move_and_slide()

	if animated_sprite:
		if is_on_floor:
			if input_direction != 0:
				animated_sprite.play("run")
			else:
				animated_sprite.play("idle")
		else:
			if velocity.y < 0:
				animated_sprite.play("jump")
			else:
				animated_sprite.play("fall")
