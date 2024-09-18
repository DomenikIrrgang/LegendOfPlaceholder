class_name Condition
extends Resource

func is_fulfilled() -> bool:
	return true

func get_string() -> String:
	return "Condition fulfilled: " + str(is_fulfilled())
