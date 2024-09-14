extends Node

func _ready() -> void:
	SettingsManager.settings_file_loaded.connect(on_save_file_loaded)
	SettingsManager.settings_file_saving.connect(on_save_file_saving)

func on_save_file_loaded(save_file: Dictionary) -> void:
	if save_file.has("graphics_settings"):
		DisplayServer.window_set_mode(save_file.graphics_settings.window_mode)
	
func on_save_file_saving(save_file: Dictionary) -> void:
	save_file.graphics_settings = {
		window_mode = DisplayServer.window_get_mode()
	}
