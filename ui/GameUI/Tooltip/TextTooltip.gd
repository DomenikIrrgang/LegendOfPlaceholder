class_name TextTooltip
extends PanelContainer

@onready
var label: Label = $PanelContainer/MarginContainer/Tect

func _process(_delta: float) -> void:
	visible = true
	global_position = get_viewport().get_mouse_position() + Vector2(1, 1)
	global_position.y -= size.y


func show_text(text: String) -> void:
	label.text = text
	
