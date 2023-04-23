const Unit = preload("res://src/combat/Unit.gd")

var unit
var type
var value

func _init(param_unit: Unit, param_type: String, param_value: int):
	unit = param_unit
	type = param_type
	value = param_value
