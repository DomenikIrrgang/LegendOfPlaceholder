class_name KeybindSetting extends TextureRect

@export
var keybind_type: InputControlls.KeybindType

var action_name: String

func _ready():
	gui_input.connect(on_gui_input)

func init(_action_name: String) -> void:
	action_name = _action_name
	texture = load(InputControlls.get_action_texture(action_name, keybind_type))
	InputControlls.keybind_changed.connect(on_keybind_changed)
	
func on_keybind_changed(_keybind_type: InputControlls.KeybindType, action: String) -> void:
	if keybind_type == _keybind_type and action_name == action:
		texture = load(InputControlls.get_action_texture(action_name, keybind_type))

func on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_MASK_LEFT and event.is_released():
		InputControlls.enter_keybind_mode(keybind_type, action_name)
