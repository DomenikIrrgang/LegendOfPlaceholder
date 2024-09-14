extends CheckBox

func _ready():
	button_pressed = true if GraphicsManager.settings[GraphicsManager.Setting.FPS_COUNTER_SHOWN] == true else false
	toggled.connect(on_toggle)
	
func on_toggle(_toggled: bool) -> void:
	GraphicsManager.set_setting(
		GraphicsManager.Setting.FPS_COUNTER_SHOWN,
		_toggled
	)
