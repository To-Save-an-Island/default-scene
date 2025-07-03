extends CharacterBody2D

@export var speed: float = 200.0
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

var last_direction: String = "down"

func _physics_process(delta: float) -> void:
	var direction = Vector2.ZERO

	# Handle input for movement
	if Input.is_action_pressed("ui_right"):
		direction.x += 1
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
	if Input.is_action_pressed("ui_down"):
		direction.y += 1
	if Input.is_action_pressed("ui_up"):
		direction.y -= 1

	direction = direction.normalized()

	# Apply movement
	velocity = direction * speed
	move_and_slide()

	# Determine and play animation
	if direction != Vector2.ZERO:
		if abs(direction.x) > abs(direction.y):
			if direction.x > 0:
				play_animation("right")
			else:
				play_animation("left")
		else:
			if direction.y > 0:
				play_animation("down")
			else:
				play_animation("up")
	else:
		play_animation(last_direction, true)

func play_animation(dir: String, idle: bool = false) -> void:
	last_direction = dir
	var anim_name = ("idle_" if idle else "walk_") + dir
	if animated_sprite.animation != anim_name:
		animated_sprite.play(anim_name)
