extends CharacterBody2D

## The bunny. Arrows to move, Space to hop, hold Space on the way up to hang in
## the air a bit longer. Four constants, tune them and you have a different game.

signal hopped

const SPEED := 90.0
const HOP_VELOCITY := -240.0
const GRAVITY := 900.0
## Gravity multiplier while rising with the hop key still held. Lower floats more.
const FLOAT_GRAVITY_SCALE := 0.45
## Gravity multiplier after the hop key is released mid-rise. Cuts the jump short.
const CUT_GRAVITY_SCALE := 2.0

@onready var _sprite: Sprite2D = $Sprite2D


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += _current_gravity() * delta

	if is_on_floor() and Input.is_action_just_pressed("ui_accept"):
		velocity.y = HOP_VELOCITY
		hopped.emit()

	var direction := Input.get_axis("ui_left", "ui_right")
	velocity.x = direction * SPEED
	if not is_zero_approx(direction):
		_sprite.flip_h = direction < 0.0

	move_and_slide()


## Rising with the key held floats, rising after release drops fast, falling is
## plain gravity. This is the whole feel of the game.
func _current_gravity() -> float:
	if velocity.y >= 0.0:
		return GRAVITY
	if Input.is_action_pressed("ui_accept"):
		return GRAVITY * FLOAT_GRAVITY_SCALE
	return GRAVITY * CUT_GRAVITY_SCALE
