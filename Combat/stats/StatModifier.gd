class_name StatModifier
extends Node

var stat: Stat.Enum
var modifier: float

func _init(_stat: Stat.Enum, _modifier: float):
	stat = _stat
	modifier = _modifier

func get_stat(stat: Stat.Enum, value: int) -> int:
	return value * modifier
