extends CheckBox


func _ready():
	button_pressed = true if GraphicsManager.settings[GraphicsManager.Setting.LIMIT_FPS_IN_FOREGROUND] == true else false
	toggled.connect(on_toggle)
	GraphicsManager.graphics_setting_changed.connect(on_settings_changed)
	
func on_settings_changed(setting: GraphicsManager.Setting, value) -> void:
	if setting == GraphicsManager.Setting.LIMIT_FPS_IN_FOREGROUND:
		set_pressed_no_signal(value)
		
func on_toggle(_toggled: bool) -> void:
	GraphicsManager.set_setting(
		GraphicsManager.Setting.LIMIT_FPS_IN_FOREGROUND,
		_toggled
	)
