extends MarginContainer

func _ready() -> void:
	hidden.connect(on_hide)
	
func on_hide():
	SettingsManager.save_to_settings_file()

func _on_close_pressed() -> void:
	hide()
