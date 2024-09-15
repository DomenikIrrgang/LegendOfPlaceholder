extends Node

enum Setting {
	FPS_COUNTER_SHOWN,
	LIMIT_FPS_IN_BACKGROUND
}

signal graphics_setting_changed(setting: Setting)

var settings: Dictionary = {}

func _ready() -> void:
	SettingsManager.settings_file_loaded.connect(on_save_file_loaded)
	SettingsManager.settings_file_saving.connect(on_save_file_saving)
	get_window().focus_entered.connect(on_window_focused)
	get_window().focus_exited.connect(on_window_unfocused)
	
func on_save_file_loaded(save_file: Dictionary) -> void:
	if save_file.has("graphics_settings"):
		DisplayServer.window_set_mode(save_file.graphics_settings.window_mode)
		DisplayServer.window_set_vsync_mode(save_file.graphics_settings.vsync if save_file.graphics_settings.has("vsync") else DisplayServer.VSYNC_DISABLED)
		set_setting(Setting.FPS_COUNTER_SHOWN, save_file.graphics_settings.fps_counter_shown if save_file.graphics_settings.has("fps_counter_shown") else false)
		set_setting(Setting.LIMIT_FPS_IN_BACKGROUND, save_file.graphics_settings.limit_fps_in_background if save_file.graphics_settings.has("limit_fps_in_background") else true)
	
func set_setting(setting: Setting, value) -> void:
	settings[setting] = value
	graphics_setting_changed.emit(setting, value)
	
func on_save_file_saving(save_file: Dictionary) -> void:
	save_file.graphics_settings = {
		window_mode = DisplayServer.window_get_mode(),
		vsync = DisplayServer.window_get_vsync_mode(),
		fps_counter_shown = settings[Setting.FPS_COUNTER_SHOWN],
		limit_fps_in_background = settings[Setting.LIMIT_FPS_IN_BACKGROUND]
	}
	
func on_window_focused() -> void:
	Engine.max_fps = 0
	
func on_window_unfocused() -> void:
	if settings[Setting.LIMIT_FPS_IN_BACKGROUND]:
		Engine.max_fps = 30
