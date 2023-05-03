class_name KeybindDisplay
extends TextureRect

@export
var action_name: String

signal keybind_pressed()
signal keybind_released()

func _input(event) -> void:
	if (event.is_action_released(action_name)):
		scale -= Vector2(0.3, 0.3)
		position += size * 0.15
		keybind_released.emit()
	if (event.is_action_pressed(action_name)):
		scale += Vector2(0.3, 0.3)	
		position -= size * 0.15
		keybind_pressed.emit()

func _ready():
	Input.joy_connection_changed.connect(joy_connection_changed)
	set_button_texture(InputControlls.get_button_texture(action_name))
	
func set_action_name(_action_name: String) -> void:
	action_name = _action_name
	set_button_texture(InputControlls.get_button_texture(action_name))	
	
func joy_connection_changed(_device_id: int, _connected: bool):
	set_button_texture(InputControlls.get_button_texture(action_name))

func set_button_texture(texture_path: String) -> void:
	self.texture = load(texture_path)