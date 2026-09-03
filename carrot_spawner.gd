extends Node2D

## Drops a carrot every so often, picks it up when the bunny gets close enough,
## and squashes the sprite on takeoff. Deleting this file leaves you with a
## working movement demo, which is usually what you actually want from a jam
## skeleton.

const SPAWN_EVERY := 1.4
const CARROT_SIZE := 16.0
const PICKUP_RADIUS := 14.0
const SPAWN_MARGIN := Vector2(24.0, 40.0)

@onready var _player: CharacterBody2D = $Player
@onready var _carrots: Node2D = $Carrots
@onready var _score_label: Label = $Score

var _score := 0
var _spawn_timer := 0.0


func _ready() -> void:
	_player.hopped.connect(_on_player_hopped)


func _process(delta: float) -> void:
	_spawn_timer -= delta
	if _spawn_timer <= 0.0:
		_spawn_timer = SPAWN_EVERY
		_spawn_carrot()
	_collect_nearby()


func _spawn_carrot() -> void:
	var texture := PlaceholderTexture2D.new()
	texture.size = Vector2(CARROT_SIZE, CARROT_SIZE)

	var carrot := Sprite2D.new()
	carrot.texture = texture
	carrot.modulate = Color(1.0, 0.55, 0.25)

	var bounds := get_viewport_rect().size
	carrot.position = Vector2(
		randf_range(SPAWN_MARGIN.x, bounds.x - SPAWN_MARGIN.x),
		randf_range(SPAWN_MARGIN.y, bounds.y - SPAWN_MARGIN.y)
	)
	_carrots.add_child(carrot)


func _collect_nearby() -> void:
	for carrot in _carrots.get_children():
		if carrot.position.distance_to(_player.position) > PICKUP_RADIUS:
			continue
		carrot.queue_free()
		_score += 1
		_score_label.text = str(_score)


## Squash on the way up, spring back over 120ms. Costs nothing, sells the hop.
func _on_player_hopped() -> void:
	var sprite := _player.get_node("Sprite2D") as Sprite2D
	sprite.scale = Vector2(0.8, 1.2)
	create_tween().tween_property(sprite, "scale", Vector2.ONE, 0.12) \
		.set_trans(Tween.TRANS_BACK) \
		.set_ease(Tween.EASE_OUT)
