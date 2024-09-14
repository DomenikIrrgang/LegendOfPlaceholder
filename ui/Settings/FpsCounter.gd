extends CheckBox

func _ready():
	button_pressed = true if GraphicsManager.settings[GraphicsManager.Setting.FPS_COUNTER_SHOWN] == true else false
	toggled.connect(on_toggle)
	
func on_toggle(toggled: bool) -> void:
	GraphicsManager.set_setting(
		GraphicsManager.Setting.FPS_COUNTER_SHOWN,
		toggled
	)
