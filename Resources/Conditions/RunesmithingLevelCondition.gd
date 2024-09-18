class_name RunesmithingLevelCondition
extends Condition

@export
var level: int

func is_fulfilled() -> bool:
	return RunesmithingManager.level >= level
	
func get_string() -> String:
	return "Requires Runesmithing Level " + str(level)
