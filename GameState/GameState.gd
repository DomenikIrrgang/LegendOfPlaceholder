class_name GameState
extends Node

var flags: Dictionary = {} : get = get_flags, set = set_flags

func get_flags() -> Dictionary:
	return flags
	
func set_flags(_flags: Dictionary) -> void:
	flags = _flags
