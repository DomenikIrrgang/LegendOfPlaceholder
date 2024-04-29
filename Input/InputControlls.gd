extends Node

const XBOX_BUTTON_TEXTURE = {
	JOY_BUTTON_A: InputTextures.GAMEPAD_A,
	JOY_BUTTON_B: InputTextures.GAMEPAD_B,
	JOY_BUTTON_X: InputTextures.GAMEPAD_X,
	JOY_BUTTON_Y: InputTextures.GAMEPAD_Y,
	JOY_BUTTON_LEFT_SHOULDER: InputTextures.GAMEPAD_LB,
	JOY_BUTTON_RIGHT_SHOULDER: InputTextures.GAMEPAD_RB,
	JOY_AXIS_TRIGGER_LEFT: InputTextures.GAMEPAD_LT,
	JOY_AXIS_TRIGGER_RIGHT: InputTextures.GAMEPAD_RT
}

const KEY_TEXTURE = {
	KEY_ESCAPE: InputTextures.KEY_ESCAPE,
	KEY_SPACE: InputTextures.KEY_SPACE,
	KEY_SHIFT: InputTextures.KEY_SHIFT,
	KEY_R: InputTextures.KEY_R,
	KEY_L: InputTextures.KEY_L,
	KEY_K: InputTextures.KEY_K,
	KEY_J: InputTextures.KEY_J,
	KEY_I: InputTextures.KEY_I,
	KEY_O: InputTextures.KEY_O,
	KEY_P: InputTextures.KEY_P,
	KEY_B: InputTextures.KEY_B,
	KEY_E: InputTextures.KEY_E,
	KEY_C: InputTextures.KEY_C,
	KEY_V: InputTextures.KEY_V,
	KEY_X: InputTextures.KEY_X
}

enum KeybindType {
	GAMEPAD,
	KEYBOARD_MOUSE
}

const MOUSE_TEXTURE = {
	MOUSE_BUTTON_LEFT: InputTextures.LEFT_MOUSE,
	MOUSE_BUTTON_RIGHT: InputTextures.RIGHT_MOUSE
}

var device_id = -1
var dead_zone = 0.05

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	Input.joy_connection_changed.connect(joy_connection_changed)
	if has_controller():
		self.device_id = Input.get_connected_joypads()[0]
	
func has_controller() -> bool:
	return Input.get_connected_joypads().size() > 0
		
func joy_connection_changed(_device_id: int, connected: bool):
	if connected:
		device_id = _device_id
	else:
		device_id = -1

func get_button_texture(action_name: String) -> String:
	var input_events: Array[InputEvent] = InputMap.action_get_events(action_name)
	for _input_event in input_events:
		if has_controller():
			if _input_event is InputEventJoypadButton:
				return XBOX_BUTTON_TEXTURE[_input_event.button_index]
			if _input_event is InputEventJoypadMotion:
				return XBOX_BUTTON_TEXTURE[_input_event.axis]
		if !has_controller() and _input_event is InputEventKey:
			var keycode = _input_event.physical_keycode if _input_event.physical_keycode != 0 else _input_event.keycode
			return KEY_TEXTURE[keycode]
		if !has_controller() and _input_event is InputEventMouse:
			return MOUSE_TEXTURE[_input_event.button_index]
	return InputTextures.KEY_ESCAPE
	
func get_action_texture(action_name: String, keybind_type: KeybindType) -> String:
	match(keybind_type):
		KeybindType.KEYBOARD_MOUSE:
			return get_keyboard_texture(action_name)
		KeybindType.GAMEPAD:
			return get_controller_texture(action_name)
		_:
			return ""
	
func get_keyboard_texture(action_name: String) -> String:
	var input_events: Array[InputEvent] = InputMap.action_get_events(action_name)
	for _input_event in input_events:
		if _input_event is InputEventKey:
			var keycode = _input_event.physical_keycode if _input_event.physical_keycode != 0 else _input_event.keycode
			return KEY_TEXTURE[keycode] if KEY_TEXTURE.has(keycode) else InputTextures.KEY_ESCAPE
		if !has_controller() and _input_event is InputEventMouseButton:
			return MOUSE_TEXTURE[_input_event.button_index]
	return InputTextures.KEY_ESCAPE
	
func get_controller_texture(action_name: String) -> String:
	var input_events: Array[InputEvent] = InputMap.action_get_events(action_name)
	for _input_event in input_events:
		if _input_event is InputEventJoypadButton:
			return XBOX_BUTTON_TEXTURE[_input_event.button_index] if XBOX_BUTTON_TEXTURE.has(_input_event.button_index) else InputTextures.GAMEPAD_A 
		if _input_event is InputEventJoypadMotion:
			return XBOX_BUTTON_TEXTURE[_input_event.axis] if XBOX_BUTTON_TEXTURE.has(_input_event.axis) else InputTextures.GAMEPAD_A
	return InputTextures.GAMEPAD_A
	
func isKeybindType(keybind_type: KeybindType, event: InputEvent) -> bool:
	match(keybind_type):
		KeybindType.KEYBOARD_MOUSE:
			return event is InputEventKey or event is InputEventMouseButton
		KeybindType.GAMEPAD:
			return event is InputEventJoypadButton or event is InputEventJoypadMotion
	return false
	
func getKeybindType(event: InputEvent) -> KeybindType:
	if event is InputEventKey or event is InputEventMouseButton:
		return KeybindType.KEYBOARD_MOUSE
	if event is InputEventJoypadButton or event is InputEventJoypadMotion:
		return KeybindType.GAMEPAD
	return -1
	
func setActionKeybind(action_name: String, event: InputEvent) -> void:
	InputMap.action_erase_event(
		action_name,
		getActionKeybindForKeybindType(action_name, getKeybindType(event))
	)
	InputMap.action_add_event(action_name, event)
	keybind_changed.emit(getKeybindType(event), action_name)

func getActionKeybindForKeybindType(action_name: String, keybind_type: KeybindType) -> InputEvent:
	var input_events: Array[InputEvent] = InputMap.action_get_events(action_name)
	for input_event in input_events:
		if getKeybindType(input_event) == keybind_type:
			return input_event
	return null
	
	
func get_directional_vector() -> Vector2:
	return Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	
### Rewrite

signal input_event(input_state: InputState)

signal entered_keybind_mode(keybind_type: KeybindType, action: String)
signal keybind_changed(keybind_type: KeybindType, action: String)
signal exited_keybind_mode(keybind_type: KeybindType, action: String)

var interceptors: Array[InputInterceptor] = [
	PlayerControlInputInterceptor.new(),
	InteractableInRangeInterceptor.new(),
	InteractionPromptInterceptor.new(),
	DialogInputInterceptor.new(),
	CutsceneInputInterceptor.new(),
]

var state: InputState = InputState.new()
var keybind_mode = {
	active = false,
	keybind_type = -1,
	action = ""
}

func enter_keybind_mode(keybind_type: KeybindType, action: String) -> void:
	if keybind_type == KeybindType.GAMEPAD and not has_controller():
		return
	keybind_mode = {
		active = true,
		keybind_type = keybind_type,
		action = action
	}
	entered_keybind_mode.emit(keybind_type, action)
	
func exit_keybind_mode() -> void:
	exited_keybind_mode.emit(keybind_mode.keybind_type, keybind_mode.action)
	keybind_mode = {
		active = false,
		keybind_type = -1,
		action = ""
	}

func _input(event: InputEvent) -> void:
	if not keybind_mode.active and not Globals.get_tree().paused and is_action(event):
		state = calculate_input_state()
		input_event.emit(state)
	if keybind_mode.active and isKeybindType(keybind_mode.keybind_type, event):
		setActionKeybind(keybind_mode.action, event)
		exit_keybind_mode()

func calculate_input_state() -> InputState:
	for interceptor in interceptors:
			state = interceptor.on_input(state)
	return state
		
func is_action(event: InputEvent) -> bool:
	for action in InputMap.get_actions():
		if event.is_action(action):
			return true
	return false

func get_state() -> InputState:
	return calculate_input_state()
