class_name DragAndDrop
extends Control

var dragging: bool = false
var data

@onready
var icon: TextureRect = $Icon

signal on_start_dragging()
signal on_stop_dragging()

func _ready():
	icon.visible = false

func _process(_delta: float):
	if dragging:
		icon.global_position = get_global_mouse_position()
	
func start_dragging(_data, _texture: Texture = null) -> void:
	data = _data
	if _texture != null:
		icon.texture = _texture
		icon.visible = true
	dragging = true
	on_start_dragging.emit()
	
func stop_dragging() -> void:
	dragging = false
	icon.visible = false
	on_stop_dragging.emit()
	
func is_dragging() -> bool:
	return dragging
