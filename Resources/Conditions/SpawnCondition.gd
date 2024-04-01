class_name SpawnCondition
extends Resource
	
@export
var conditions: Array[Condition] = []

func is_fulfilled() -> bool:
	for condition in conditions:
		if not condition.is_fulfilled():
			return false
	return true
