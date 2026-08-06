class_name Player
extends CharacterBody2D

## Minimal player movement (WASD / arrow keys). The prototype's focus is
## the command interface, so this stays deliberately simple -- see the
## project's non-goals around graphics and large gameplay systems.

const SPEED := 220.0

func _physics_process(_delta: float) -> void:
	var input_vector := Vector2.ZERO
	if Input.is_key_pressed(KEY_A) or Input.is_key_pressed(KEY_LEFT):
		input_vector.x -= 1.0
	if Input.is_key_pressed(KEY_D) or Input.is_key_pressed(KEY_RIGHT):
		input_vector.x += 1.0
	if Input.is_key_pressed(KEY_W) or Input.is_key_pressed(KEY_UP):
		input_vector.y -= 1.0
	if Input.is_key_pressed(KEY_S) or Input.is_key_pressed(KEY_DOWN):
		input_vector.y += 1.0

	velocity = input_vector.normalized() * SPEED
	move_and_slide()
