extends CheckBox

func _ready():
	button_pressed = SoundManager.tts_enabled
	toggled.connect(on_toggle)
	
func on_toggle(_toggled: bool) -> void:
	SoundManager.set_tts(_toggled)
