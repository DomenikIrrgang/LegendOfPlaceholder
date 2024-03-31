extends Node

signal save_file_saving(save_file: Dictionary)
signal save_file_saved()

signal save_file_start_loading()
signal save_file_loaded(save_file: Dictionary)

const SAVE_FILE_PATH: String = "user://savegame.save"

func save_file_exists() -> bool:
	return FileAccess.file_exists(SAVE_FILE_PATH)

func load_save_file() -> void:
	save_file_start_loading.emit()
	if save_file_exists():
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
	save_file_saved.emit()
	
func get_resource_uid(resource: Resource) -> String:
	var id = str(ResourceLoader.get_resource_uid(resource.resource_path))
	return str(ResourceLoader.get_resource_uid(resource.resource_path))
	
func get_resource_from_uid(uid: String) -> Resource:
	var path = ResourceLoader.load(ResourceUID.get_id_path(int(uid)))
	return ResourceLoader.load(ResourceUID.get_id_path(int(uid)))
	
func get_node_uid(node: Node) -> String:
	var path = str(ResourceLoader.get_resource_uid(node.scene_file_path))
	return str(ResourceLoader.get_resource_uid(node.scene_file_path))
