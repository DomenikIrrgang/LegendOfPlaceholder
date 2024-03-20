class_name FlagValueObjective
extends QuestObjective

@export
var flag: GameFlag.Enum

@export
var flag_value: bool

@export
var progress_string: String = ""

func init() -> void:
	GameStateManager.flag_changed.connect(on_flag_changed)
	
func reset() -> void:
	GameStateManager.flag_changed.disconnect(on_flag_changed)

func on_flag_changed(_flag: GameFlag.Enum, value: bool) -> void:
	if flag == _flag:
		objective_progress_changed.emit(self)

func is_completed() -> bool:
	return GameStateManager.get_flag(flag) == flag_value
	
func get_progess_string() -> String:
	return ("1" if is_completed() else "0")  + "/1 " + progress_string
