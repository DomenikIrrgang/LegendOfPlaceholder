class_name FlagValueCondition
extends Condition

@export
var flag: GameFlag.Enum

@export
var flag_value: bool

func is_fulfilled() -> bool:
	return GameStateManager.get_flag(flag) == flag_value
