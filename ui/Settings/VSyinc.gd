extends CheckBox


func _ready():
	button_pressed = true if DisplayServer.window_get_vsync_mode() == DisplayServer.VSYNC_ADAPTIVE else false
	toggled.connect(on_toggle)
	GraphicsManager.graphics_setting_changed.connect(on_setting_changed)
	
func on_setting_changed(setting: GraphicsManager.Setting, value) -> void:
	if setting == GraphicsManager.Setting.VSYNC_MODE and value == DisplayServer.VSYNC_DISABLED:
		set_pressed_no_signal(false)
		
func on_toggle(_toggled: bool) -> void:
	if _toggled:
		GraphicsManager.set_setting(GraphicsManager.Setting.VSYNC_MODE, DisplayServer.VSYNC_ADAPTIVE)
	else:
		GraphicsManager.set_setting(GraphicsManager.Setting.VSYNC_MODE, DisplayServer.VSYNC_DISABLED)
