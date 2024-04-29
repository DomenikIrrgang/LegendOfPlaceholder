extends HBoxContainer

@onready
var action: Label = $Action

@onready
var controller_keybind: KeybindSetting = $HBoxContainer/ControllerKeybind

@onready
var keyboard_keybind: KeybindSetting = $HBoxContainer/KeyboardKeybind

func init(action_name: String):
	action.text = action_name.capitalize()
	controller_keybind.init(action_name)
	keyboard_keybind.init(action_name)
