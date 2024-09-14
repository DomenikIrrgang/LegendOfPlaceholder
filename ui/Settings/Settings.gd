extends MarginContainer

func _ready() -> void:
	hidden.connect(on_hide)
	
func on_hide():
	SettingsManager.save_to_settings_file()
