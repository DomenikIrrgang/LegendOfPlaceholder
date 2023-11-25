extends HBoxContainer

@onready
var back: Label = $Back

@onready
var page_number: Label = $PageNumber

@onready
var forward: Label = $Forward

var current_page: int = 0
var max_page: int = 0

signal page_changed(page: int)

func set_page_number(number: int, _max_page: int) -> void:
	current_page = number
	max_page = _max_page
	if current_page <= 0:
		back.modulate.a = 0
	else:
		back.modulate.a = 1
	page_number.text = str(current_page + 1)
	if current_page < max_page - 1:
		forward.modulate.a = 1
	else:
		forward.modulate.a = 0
	if max_page <= 1:
		visible = false
	else:
		visible = true

func _on_back_gui_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_MASK_LEFT and event.is_pressed():
		if current_page > 0:
			set_page_number(current_page - 1, max_page)
			page_changed.emit(current_page)


func _on_forward_gui_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_MASK_LEFT and event.is_pressed():
		if current_page < max_page - 1:
			set_page_number(current_page + 1, max_page)
			page_changed.emit(current_page)
