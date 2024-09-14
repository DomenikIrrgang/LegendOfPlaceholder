extends Node

signal settings_file_saving(settings_file: Dictionary)
signal settings_file_saved()
signal settings_file_start_loading()
signal settings_file_loaded(settings_file: Dictionary)

const SETTINGS_FILE_PATH: String = "user://rinia.settings"

var settings_file: Dictionary = {}

var version: float = 1.0

func _ready() -> void:
	if not settings_file_exists():
		settings_file = create_settings_file()
	else:
		settings_file = load_settings_file()
	

func settings_file_exists() -> bool:
	return FileAccess.file_exists(SETTINGS_FILE_PATH)
	
func load_settings_file() -> Dictionary:
	settings_file_start_loading.emit()
	if settings_file_exists():
		var settings_file_handle: FileAccess
		settings_file_handle = FileAccess.open(SETTINGS_FILE_PATH, FileAccess.READ)
		var line = settings_file_handle.get_line()
		var data: Dictionary = JSON.parse_string(line)
		settings_file_handle.close()
		settings_file_loaded.emit(data)
		return data
	return {}
	
func save_to_settings_file() -> void:
	var settings_file_handle: FileAccess
	settings_file_handle = FileAccess.open(SETTINGS_FILE_PATH, FileAccess.WRITE)
	settings_file_saving.emit(settings_file)
	settings_file_handle.store_line(JSON.stringify(settings_file))
	settings_file_handle.close()
	settings_file_saved.emit()
	
func create_settings_file() -> Dictionary:
	var settings_file: FileAccess
	settings_file = FileAccess.open(SETTINGS_FILE_PATH, FileAccess.WRITE)
	var settings_file_content = {}
	settings_file_content.version = version
	settings_file_saving.emit(settings_file_content)
	settings_file.store_line(JSON.stringify(settings_file_content))
	settings_file.close()
	settings_file_saved.emit()
	return settings_file_content
