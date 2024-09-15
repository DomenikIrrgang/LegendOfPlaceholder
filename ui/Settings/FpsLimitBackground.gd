extends CheckBox


func _ready():
	button_pressed = true if GraphicsManager.settings[GraphicsManager.Setting.LIMIT_FPS_IN_BACKGROUND] == true else false
	toggled.connect(on_toggle)
	
func on_toggle(_toggled: bool) -> void:
	GraphicsManager.set_setting(
		GraphicsManager.Setting.LIMIT_FPS_IN_BACKGROUND,
		_toggled
	)
