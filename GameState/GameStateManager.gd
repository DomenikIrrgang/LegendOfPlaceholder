extends Node

var game_state: GameState = GameState.new()

signal flag_changed(flag: GameFlag.Enum, value: bool)

func _ready() -> void:
	SaveFileManager.game_state_start_loading.connect(reset)
	SaveFileManager.game_state_saving.connect(on_save)
	SaveFileManager.game_state_loaded.connect(on_load)

func reset() -> void:
	game_state = GameState.new()
	
func on_save(_game_state: Dictionary) -> void:
	var flags = {}
	for flag in GameFlag.Enum.keys():
		flags[flag] = get_flag(GameFlag.Enum[flag])
	_game_state.flags = flags

func on_load(_game_state: Dictionary) -> void:
	for flag in _game_state.flags:
		game_state.flags[GameFlag.Enum[flag]] = _game_state.flags[flag]

func get_game_state() -> GameState:
	return game_state
	
func set_flag(flag: GameFlag.Enum, value: bool) -> void:
	game_state.flags[flag] = value
	flag_changed.emit(flag, value)
	
func get_flag(flag: GameFlag.Enum) -> bool:
	return game_state.flags[flag] if game_state.flags.has(flag) else false
