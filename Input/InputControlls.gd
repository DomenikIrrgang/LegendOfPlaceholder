extends Node

const XBOX_BUTTON_TEXTURE = {
	JOY_BUTTON_A: InputTextures.GAMEPAD_A,
	JOY_BUTTON_B: InputTextures.GAMEPAD_B,
}

const KEY_TEXTURE = {
	KEY_ESCAPE: InputTextures.KEY_ESCAPE,
	KEY_SPACE: InputTextures.KEY_SPACE,
	KEY_SHIFT: InputTextures.KEY_SHIFT,
	KEY_R: InputTextures.KEY_R
}

const MOUSE_TEXTURE = {
	MOUSE_BUTTON_LEFT: InputTextures.LEFT_MOUSE,
	MOUSE_BUTTON_RIGHT: InputTextures.RIGHT_MOUSE
}

var device_id = -1
var dead_zone = 0.05

func _ready():
	Input.joy_connection_changed.connect(joy_connection_changed)
	if has_controller():
		self.device_id = Input.get_connected_joypads()[0]
	
func has_controller() -> bool:
	return Input.get_connected_joypads().size() > 0
		
func joy_connection_changed(device_id: int, connected: bool):
	if connected:
		self.device_id = device_id
	else:
		self.device_id = -1

func get_button_texture(action_name: String) -> String:
	var input_events: Array[InputEvent] = InputMap.action_get_events(action_name)
	for input_event in input_events:
		print(input_event)
		if has_controller() and input_event is InputEventJoypadButton or input_event is InputEventJoypadMotion:
			if "XInput" in Input.get_joy_name(device_id):
				return XBOX_BUTTON_TEXTURE[input_event.button_index]
		if !has_controller() and input_event is InputEventKey:
			print(KEY_ESCAPE, " ", KEY_SPACE)
			print(input_event.physical_keycode)
			return KEY_TEXTURE[input_event.physical_keycode]
		if !has_controller() and input_event is InputEventMouse:
			return MOUSE_TEXTURE[input_event.button_index]
	return KEY_TEXTURE[action_name]

