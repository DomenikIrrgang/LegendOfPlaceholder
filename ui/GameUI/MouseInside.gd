class_name MouseInside
extends Control

signal mouse_in
signal mouse_out

var mouse_inside = false

func _process(_delta: float) -> void:
	if get_parent().get_global_rect().has_point(get_global_mouse_position()):
		if !mouse_inside:
			mouse_in.emit()
			mouse_inside = true
	else:
		if mouse_in:
			mouse_out.emit()
			mouse_inside = false
