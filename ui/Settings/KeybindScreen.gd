extends CenterContainer

@onready
var label: Label = $Label

func _ready():
	InputControlls.entered_keybind_mode.connect(on_entered_keybind_mode)
	InputControlls.exited_keybind_mode.connect(func(keybind_type: InputControlls.KeybindType, action: String): visible = false)
	
func on_entered_keybind_mode(keybind_type: InputControlls.KeybindType, action: String) -> void:
	if keybind_type == InputControlls.KeybindType.GAMEPAD:
		visible = true
		label.text = "Press button to keybind action:\n" + action.capitalize()
	if keybind_type == InputControlls.KeybindType.KEYBOARD_MOUSE:
		visible = true		
		label.text = "Press or press button/key to keybind action:\n" + action.capitalize()
