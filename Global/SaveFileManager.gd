extends Node

signal save_file_saving(save_file: Dictionary)
signal save_file_saved()
signal save_file_start_loading()
signal save_file_loaded(save_file: Dictionary)

signal game_state_saving(game_state: Dictionary)
signal game_state_saved()
signal game_state_start_loading()
signal game_state_loaded(game_state: Dictionary)


const SAVE_FILE_PATH: String = "user://savegame.save"
const SAVE_FILE_PASSWORD: String = "8Mp7vF0TzAYD2WhsNnhWs9p3ZHZGdktH"
const USE_ENCRYPTION: bool = false
const MAX_GAME_STATE_SLOTS: int = 3

var loaded_game_state_index: int = -1
var save_file: Dictionary = {}

var version: float = 1.0

func _ready() -> void:
	if not save_file_exists():
		save_file = create_save_file()
	else:
		save_file = load_save_file()

func save_file_exists() -> bool:
	return FileAccess.file_exists(SAVE_FILE_PATH)
	
func is_game_state_loaded() -> bool:
	return loaded_game_state_index != -1

func load_save_file() -> Dictionary:
	save_file_start_loading.emit()
	if save_file_exists():
		var save_file_handle: FileAccess
		if USE_ENCRYPTION:
			save_file_handle = FileAccess.open_encrypted_with_pass(SAVE_FILE_PATH, FileAccess.READ, SAVE_FILE_PASSWORD)
		else:
			save_file_handle = FileAccess.open(SAVE_FILE_PATH, FileAccess.READ)
		var line = save_file_handle.get_line()
		var data: Dictionary = JSON.parse_string(line)
		save_file_handle.close()
		save_file_loaded.emit(data)
		return data
	return {}
		
func load_game_state(index: int) -> void:
	if loaded_game_state_index != -1:
		loaded_game_state_index = index
		if is_new_game_state(index):
			save_to_save_file()
		game_state_start_loading.emit()
		game_state_loaded.emit(save_file.game_states[index].data)
	
func is_first_game_state_save() -> bool:
	return is_new_game_state(loaded_game_state_index)
	
func is_new_game_state(index: int) -> bool:
	return save_file.game_states[index].data == {}
	
func save_game_state() -> Dictionary:
	var save_data = {}
	game_state_saving.emit(save_data)
	game_state_saved.emit()
	return {
		name = save_file.game_states[loaded_game_state_index].name,
		data = save_data
	}
	
func get_game_state(index: int) -> Dictionary:
	return save_file.game_states[index]
	
func set_game_state_name(index: int, name: String) -> void:
	save_file.game_states[index].name = name
	
func save_to_save_file() -> void:
	var save_file_handle: FileAccess
	if USE_ENCRYPTION:
		save_file_handle = FileAccess.open_encrypted_with_pass(SAVE_FILE_PATH, FileAccess.WRITE, SAVE_FILE_PASSWORD)
	else:
		save_file_handle = FileAccess.open(SAVE_FILE_PATH, FileAccess.WRITE)
	save_file_saving.emit(save_file)
	save_file.game_states[loaded_game_state_index] = save_game_state()
	save_file_handle.store_line(JSON.stringify(save_file))
	save_file_handle.close()
	save_file_saved.emit()
	
func create_save_file() -> Dictionary:
	var save_file: FileAccess
	if USE_ENCRYPTION:
		save_file = FileAccess.open_encrypted_with_pass(SAVE_FILE_PATH, FileAccess.WRITE, SAVE_FILE_PASSWORD)
	else:
		save_file = FileAccess.open(SAVE_FILE_PATH, FileAccess.WRITE)
	var save_file_content = {}
	save_file_content.version = version
	save_file_content.game_states = []
	for i in range(MAX_GAME_STATE_SLOTS):
		save_file_content.game_states.append({
			data = {},
			name = ""
		})
	save_file_saving.emit(save_file_content)
	save_file.store_line(JSON.stringify(save_file_content))
	save_file.close()
	save_file_saved.emit()
	return save_file_content
	
func get_resource_uid(resource: Resource) -> String:
	var id = str(ResourceLoader.get_resource_uid(resource.resource_path))
	return str(ResourceLoader.get_resource_uid(resource.resource_path))
	
func get_resource_from_uid(uid: String) -> Resource:
	var path = ResourceLoader.load(ResourceUID.get_id_path(int(uid)))
	return ResourceLoader.load(ResourceUID.get_id_path(int(uid)))
	
func get_node_uid(node: Node) -> String:
	var path = str(ResourceLoader.get_resource_uid(node.scene_file_path))
	return str(ResourceLoader.get_resource_uid(node.scene_file_path))
