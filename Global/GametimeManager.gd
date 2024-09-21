extends Node

var time: float = 0.0
var active: bool = false

var ingame_time_factor: float = 48
var ingame_time: float = 0.0

signal ingame_time_updated(time: float)

func _ready() -> void:
	SaveFileManager.game_state_loaded.connect(on_load)
	SaveFileManager.game_state_saving.connect(on_save)
	SaveFileManager.game_state_start_loading.connect(reset)
	SaveFileManager.game_state_start_unloading.connect(reset)
	
func reset() -> void:
	time = 0.0
	active = false
	
func on_load(game_state: Dictionary) -> void:
	if game_state.has("game_time"):
		time = game_state.game_time
		ingame_time = fmod(time, ingame_time_factor)
	else:
		time = 0.0
		ingame_time = 0.0
	active = true
		
func on_save(game_state: Dictionary) -> void:
	game_state.game_time = time
	
func get_ingame_day() -> int:
	return int(ingame_time / 60 / 60 / 24)
	
func get_ingame_hour() -> int:
	return int(fmod(ingame_time, 60 * 60 * 24) / 60 / 60)
	
func get_ingame_minutes() -> int:
	return int(fmod(fmod(ingame_time, 60 * 60 * 24) / 60, 60))
	
func get_ingame_seconds() -> int:
	return int(fmod(fmod(ingame_time, 60 * 60 * 24), 60))

func _process(delta: float) -> void:
	if active == true and Globals.get_tree().paused == false:
		time += delta
		ingame_time = (time * ingame_time_factor)
		ingame_time_updated.emit(ingame_time)
