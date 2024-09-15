extends Node

enum Setting {
	FPS_COUNTER_SHOWN,
	LIMIT_FPS_IN_FOREGROUND,
	LIMIT_FPS_IN_BACKGROUND,
	FPS_LIMIT_FOREGROUND,
	FPS_LIMIT_BACKGROUND,
	VSYNC_MODE,
	WINDOW_MODE,
}

signal graphics_setting_changed(setting: Setting, value)

var settings: Dictionary = {
	Setting.FPS_COUNTER_SHOWN: false,
	Setting.LIMIT_FPS_IN_FOREGROUND: false,
	Setting.LIMIT_FPS_IN_BACKGROUND: true,
	Setting.FPS_LIMIT_FOREGROUND: 60,
	Setting.FPS_LIMIT_BACKGROUND: 30,
	Setting.VSYNC_MODE: DisplayServer.VSYNC_DISABLED,
	Setting.WINDOW_MODE: DisplayServer.WindowMode.WINDOW_MODE_FULLSCREEN
}

func _ready() -> void:
	SettingsManager.settings_file_loaded.connect(on_save_file_loaded)
	SettingsManager.settings_file_saving.connect(on_save_file_saving)
	graphics_setting_changed.connect(on_setting_changed)
	get_window().focus_entered.connect(on_window_focused)
	get_window().focus_exited.connect(on_window_unfocused)
	
func on_save_file_loaded(save_file: Dictionary) -> void:
	if save_file.has("graphics_settings"):
		set_setting(Setting.VSYNC_MODE, save_file.graphics_settings.vsync)
		set_setting(Setting.WINDOW_MODE, save_file.graphics_settings.window_mode)
		set_setting(Setting.FPS_COUNTER_SHOWN, save_file.graphics_settings.fps_counter_shown)
		set_setting(Setting.LIMIT_FPS_IN_BACKGROUND, save_file.graphics_settings.limit_fps_in_background)
		set_setting(Setting.LIMIT_FPS_IN_FOREGROUND, save_file.graphics_settings.limit_fps_in_foreground)
		set_setting(Setting.FPS_LIMIT_BACKGROUND, save_file.graphics_settings.fps_limit_background)
		set_setting(Setting.FPS_LIMIT_FOREGROUND, save_file.graphics_settings.fps_limit_foreground)
	
func set_setting(setting: Setting, value) -> void:
	settings[setting] = value
	graphics_setting_changed.emit(setting, value)
	
func on_setting_changed(setting: Setting, value) -> void:
	match(setting):
		Setting.LIMIT_FPS_IN_FOREGROUND:
			if value == true:
				set_setting(Setting.VSYNC_MODE, DisplayServer.VSYNC_DISABLED)
			update_foreground_fps()
		Setting.VSYNC_MODE:
			DisplayServer.window_set_vsync_mode(value)
			if value != DisplayServer.VSYNC_DISABLED:
				set_setting(Setting.LIMIT_FPS_IN_FOREGROUND, false)
			update_foreground_fps()
		Setting.WINDOW_MODE:
			DisplayServer.window_set_mode(value)
		Setting.FPS_LIMIT_FOREGROUND:
			update_foreground_fps()
		Setting.FPS_LIMIT_BACKGROUND:
			update_foreground_fps()
			
	
func on_save_file_saving(save_file: Dictionary) -> void:
	save_file.graphics_settings = {
		window_mode = settings[Setting.WINDOW_MODE],
		vsync = settings[Setting.VSYNC_MODE],
		fps_counter_shown = settings[Setting.FPS_COUNTER_SHOWN],
		limit_fps_in_background = settings[Setting.LIMIT_FPS_IN_BACKGROUND],
		limit_fps_in_foreground = settings[Setting.LIMIT_FPS_IN_FOREGROUND],
		fps_limit_background = settings[Setting.FPS_LIMIT_BACKGROUND],
		fps_limit_foreground = settings[Setting.FPS_LIMIT_FOREGROUND]
	}
	
func update_foreground_fps() -> void:
	if get_window().has_focus():
		if DisplayServer.window_get_vsync_mode() == DisplayServer.VSYNC_DISABLED and settings[Setting.LIMIT_FPS_IN_FOREGROUND]:
			Engine.max_fps = settings[Setting.FPS_LIMIT_FOREGROUND]
		else:
			Engine.max_fps = 0
	
func on_window_focused() -> void:
	update_foreground_fps()
	
func on_window_unfocused() -> void:
	if settings[Setting.LIMIT_FPS_IN_BACKGROUND]:
		Engine.max_fps = settings[Setting.FPS_LIMIT_BACKGROUND]
