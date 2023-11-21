class_name MouseInside
extends Control

signal mouse_in
signal mouse_out

var mouse_inside = false

func _process(_delta: float) -> void:
	if get_parent().get_global_rect().has_point(get_global_mouse_position()):
		if !mouse_inside:
			emit_signal("mouse_in")
			mouse_inside = true
	else:
		if mouse_in:
			emit_signal("mouse_out")
			mouse_inside = false
