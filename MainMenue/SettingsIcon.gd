extends TextureRect

@onready
var settings = $"../../../../../../Settings"

@onready
var center = $"../../../../../../CenterContainer"

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_MASK_LEFT and event.is_pressed():
		settings.show()
		center.hide()

func _on_settings_hidden() -> void:
	center.show()
