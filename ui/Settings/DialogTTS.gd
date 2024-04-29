extends CheckBox

func _ready():
	button_pressed = SoundManager.tts_enabled
	toggled.connect(on_toggle)
	
func on_toggle(toggled: bool) -> void:
	print("toggled")
	SoundManager.set_tts(toggled)
