extends Node

signal save_file_saving(save_file: Dictionary)

signal save_file_start_loading()
signal save_file_loaded(save_file: Dictionary)

const SAVE_FILE_PATH: String = "user://savegame.save"

func save_file_exists() -> bool:
	return FileAccess.file_exists(SAVE_FILE_PATH)

func load_save_file() -> void:
	if save_file_exists():
		save_file_start_loading.emit()
		var save_file = FileAccess.open(SAVE_FILE_PATH, FileAccess.READ)
		var line = save_file.get_line()
		var data: Dictionary = JSON.parse_string(line)
		save_file.close()
		save_file_loaded.emit(data)
	
func save_to_save_file() -> void:
	var save_file = FileAccess.open(SAVE_FILE_PATH, FileAccess.WRITE)
	var save_data = {}
	save_file_saving.emit(save_data)
	save_file.store_line(JSON.stringify(save_data))
	save_file.close()
	
func get_resource_uid(resource: Resource) -> String:
	return str(ResourceLoader.get_resource_uid(resource.resource_path))
	
func get_resource_from_uid(uid: String) -> Resource:
	return ResourceLoader.load(ResourceUID.get_id_path(int(uid)))
