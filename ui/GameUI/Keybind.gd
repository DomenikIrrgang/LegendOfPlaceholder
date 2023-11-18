class_name KeybindDisplay
extends TextureRect

@export
var action_name: String

var original_scale: Vector2
var original_position: Vector2

signal keybind_pressed()
signal keybind_released()

func _ready():
	Input.joy_connection_changed.connect(joy_connection_changed)
	set_button_texture(InputControlls.get_button_texture(action_name))
	original_position = position
	original_scale = scale
	InputControlls.input_event.connect(on_input)
	
func on_input(state: InputState) -> void:
	if (state.action_map.has(action_name) and state.action_map[action_name] == false):
		scale = original_scale
		position = original_position
		keybind_released.emit()
	if (state.action_map.has(action_name) and state.action_map[action_name] == true):
		scale += Vector2(0.3, 0.3)
		position -= size * 0.15
		keybind_pressed.emit()
	
func set_action_name(_action_name: String) -> void:
	action_name = _action_name
	set_button_texture(InputControlls.get_button_texture(action_name))	
	
func joy_connection_changed(_device_id: int, _connected: bool):
	set_button_texture(InputControlls.get_button_texture(action_name))

func set_button_texture(texture_path: String) -> void:
	self.texture = load(texture_path)
