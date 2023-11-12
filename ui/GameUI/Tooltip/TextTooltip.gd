class_name TextTooltip
extends PanelContainer

@onready
var label: Label = $PanelContainer/MarginContainer/Tect

func _process(delta):
	if visible:
		global_position = get_viewport().get_mouse_position()
		global_position.y -= size.y


func show_text(text: String) -> void:
	label.text = text
	
