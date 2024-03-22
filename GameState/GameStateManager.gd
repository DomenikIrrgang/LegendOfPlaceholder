extends Node

var game_state: GameState = GameState.new()

signal flag_changed(flag: GameFlag.Enum, value: bool)

func _ready() -> void:
	SaveFileManager.save_file_start_loading.connect(reset)
	SaveFileManager.save_file_saving.connect(on_save)
	SaveFileManager.save_file_loaded.connect(on_load)

func reset() -> void:
	game_state = GameState.new()
	
func on_save(save_file: Dictionary) -> void:
	var flags = {}
	for flag in GameFlag.Enum.keys():
		flags[flag] = get_flag(GameFlag.Enum[flag])
	save_file.flags = flags

func on_load(save_file: Dictionary) -> void:
	for flag in save_file.flags:
		game_state.flags[GameFlag.Enum[flag]] = save_file.flags[flag]

func get_game_state() -> GameState:
	return game_state
	
func set_flag(flag: GameFlag.Enum, value: bool) -> void:
	game_state.flags[flag] = value
	flag_changed.emit(flag, value)
	
func get_flag(flag: GameFlag.Enum) -> bool:
	return game_state.flags[flag] if game_state.flags.has(flag) else false
