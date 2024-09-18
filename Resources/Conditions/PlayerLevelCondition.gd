class_name PlayerLevelCondition
extends Condition

@export
var level: int

func is_fulfilled() -> bool:
	return Globals.get_player().get_level() >= level
	
func get_string() -> String:
	return "Requires level " + str(level)
