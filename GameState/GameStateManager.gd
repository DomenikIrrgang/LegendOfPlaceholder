extends Node

var game_state: GameState = GameState.new()

signal flag_changed(flag: GameFlag.Enum, value: bool)

func get_game_state() -> GameState:
	return game_state
	
func set_flag(flag: GameFlag.Enum, value: bool) -> void:
	game_state.flags[flag] = value
	flag_changed.emit(flag, value)
	
func get_flag(flag: GameFlag.Enum) -> bool:
	return game_state.flags[flag] if game_state.flags.has(flag) else false
