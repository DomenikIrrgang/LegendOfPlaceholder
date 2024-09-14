extends Node

enum Setting {
	FPS_COUNTER_SHOWN
}

signal graphics_setting_changed(setting: Setting)

var settings: Dictionary = {}

func _ready() -> void:
	SettingsManager.settings_file_loaded.connect(on_save_file_loaded)
	SettingsManager.settings_file_saving.connect(on_save_file_saving)
	
func on_save_file_loaded(save_file: Dictionary) -> void:
	if save_file.has("graphics_settings"):
		DisplayServer.window_set_mode(save_file.graphics_settings.window_mode)
		DisplayServer.window_set_vsync_mode(save_file.graphics_settings.vsync if save_file.graphics_settings.has("vsync") else DisplayServer.VSYNC_DISABLED)
		set_setting(Setting.FPS_COUNTER_SHOWN, save_file.graphics_settings.fps_counter_shown if save_file.graphics_settings.has("fps_counter_shown") else false)
	
func set_setting(setting: Setting, value) -> void:
	settings[setting] = value
	graphics_setting_changed.emit(setting, value)
	
func on_save_file_saving(save_file: Dictionary) -> void:
	save_file.graphics_settings = {
		window_mode = DisplayServer.window_get_mode(),
		vsync = DisplayServer.window_get_vsync_mode(),
		fps_counter_shown = settings[Setting.FPS_COUNTER_SHOWN]
	}
