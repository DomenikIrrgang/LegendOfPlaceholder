extends CheckBox


func _ready():
	button_pressed = true if DisplayServer.window_get_vsync_mode() == DisplayServer.VSYNC_ADAPTIVE else false
	toggled.connect(on_toggle)
	
func on_toggle(_toggled: bool) -> void:
	if _toggled:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ADAPTIVE)
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
