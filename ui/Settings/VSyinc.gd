extends CheckBox


func _ready():
	button_pressed = true if DisplayServer.window_get_vsync_mode() == DisplayServer.VSYNC_ADAPTIVE else false
	toggled.connect(on_toggle)
	
func on_toggle(toggled: bool) -> void:
	if toggled:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ADAPTIVE)
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
