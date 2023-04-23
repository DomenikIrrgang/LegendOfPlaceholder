class_name Rage
extends UnitResource

func _init(_stat_calculator: StatCalculator) -> void:
	super(_stat_calculator)
	type = ResourceType.Enum.RAGE
	set_maximum_value(100)

func reset() -> void:
	set_value(0)
	
func get_maximum_value() -> int:
	return super.get_maximum_value() + stat_calculator.get_stat_set().get_stat(Stat.RAGE)
	
func on_stat_changed(stat, _value) -> void:
	if stat == Stat.RAGE:
		resource_maximum_value_changed.emit(get_maximum_value())
