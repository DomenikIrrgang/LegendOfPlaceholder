class_name UnitResource
extends Node

var value: int = 50
var maximum_value: int = 100
var type: int = ResourceType.Enum.HEALTH
var stat_calculator: StatCalculator

signal resource_value_changed(resource: UnitResource, new_value: int, change: int, original_change: int)
signal resource_maximum_value_changed(resource: UnitResource, new_maximum_value: int)

func _init(_stat_calculator: StatCalculator) -> void:
	stat_calculator = _stat_calculator
	stat_calculator.get_unit().stat_changed.connect(on_stat_changed)
	
func update(_delta: float) -> void:
	pass

func set_value(new_value: int) -> int:
	var old_value = value
	var change = new_value - old_value
	if new_value >= 0:
		if new_value <= get_maximum_value():
			value = new_value
		else:
			value = get_maximum_value()
	else:
		value = 0
	if (value != old_value):
		resource_value_changed.emit(self, value, value - old_value, change)
	return value - old_value
	
func set_value_silent(new_value: int) -> int:
	var old_value = value
	if new_value >= 0:
		if new_value <= get_maximum_value():
			value = new_value
		else:
			value = get_maximum_value()
	else:
		value = 0
	return value - old_value
	
func set_maximum_value(new_maximum_value: int) -> int:
	var old_maximum_value: int = maximum_value
	maximum_value = new_maximum_value if new_maximum_value > 0 else 0
	value = value if value <= get_maximum_value() else get_maximum_value()
	resource_maximum_value_changed.emit(self, maximum_value, old_maximum_value)
	return maximum_value - old_maximum_value
	
func get_maximum_value() -> int:
	return maximum_value
	
func get_value() -> int:
	return value
	
func increase_value(change: int) -> int:
	return set_value(get_value() + change)

func decrease_value(change: int) -> int:
	return increase_value(-change)
	
func increase_maximum_value(change: int) -> int:
	return set_maximum_value(get_maximum_value() + change)
	
func decrease_maximum_value(change: int) -> int:
	return increase_maximum_value(-change)
	
func get_percentage() -> float:
	return float(get_value()) / get_maximum_value()

func reset() -> void:
	set_value(get_maximum_value())
	
func on_stat_changed(_stat: int, _value: int) -> void:
	if get_maximum_value() < get_value():
		set_value(get_maximum_value())
