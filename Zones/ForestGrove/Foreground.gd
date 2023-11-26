extends Node2D

var trees_tween: Tween

@onready
var trees_tile_map: TileMap = $Trees
var trees_orignal_position: Vector2

@onready
var shadows_tile_map: TileMap = $Shadows

func _ready() -> void:
	trees_orignal_position = trees_tile_map.global_position
	trees_tween = create_tween()

func _process(_delta: float) -> void:
	var movement_direction = Globals.get_player().velocity.normalized()
	if (trees_tween.is_running()):
		trees_tween.kill()
	trees_tween = create_tween()
	trees_tween.tween_property(trees_tile_map, "position", trees_orignal_position + (movement_direction * -0.5), 0.2)
	trees_tween.play()
